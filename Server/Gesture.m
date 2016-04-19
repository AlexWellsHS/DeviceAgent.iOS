
#import "CoordinateQuery.h"
#import "ThreadUtils.h"
#import "Gesture.h"

@implementation Gesture

+ (NSString *)name {
    _must_override_exception;
}

+ (NSArray <NSString *> *)optionalKeys { return @[ CBX_DURATION_KEY ]; }
+ (NSArray <NSString *> *)requiredKeys { return @[]; }

+ (JSONKeyValidator *)validator {
    return [JSONKeyValidator withRequiredKeys:[self requiredKeys]
                                 optionalKeys:[self optionalKeys]];
}

+ (NSArray <NSString *> *)defaultOptionalSpecifiers {
    return @[CBX_IDENTIFIER_KEY,
             CBX_TEXT_KEY,
             CBX_TEXT_LIKE_KEY,
             CBX_PROPERTY_KEY,
             CBX_PROPERTY_LIKE_KEY,
             CBX_INDEX_KEY];
}

+ (Gesture *)executeWithGestureConfiguration:(GestureConfiguration *)gestureConfig
                                         query:(Query *)query
                                    completion:(CompletionBlock)completion {
    Gesture *gest = [self withGestureConfiguration:gestureConfig
                                             query:query];
    [gest execute:completion];
    return gest;
}

+ (instancetype)withGestureConfiguration:(GestureConfiguration *)gestureConfig
                                   query:(Query *)query {
    Gesture *gesture = [self new];
    
    gesture.gestureConfiguration = gestureConfig;
    gesture.query = query;
    
    return gesture;
}

- (XCSynthesizedEventRecord *)eventWithCoordinates:(NSArray<Coordinate *> *)coordinates {
    _must_override_exception;
}

- (XCTouchGesture *)gestureWithCoordinates:(NSArray<Coordinate *> *)coordinates {
    _must_override_exception;
}

- (void)validate {
    //TODO:
    //Just assume it's valid by default?
}

- (id)setup:(NSArray<Coordinate *> *)coords { return nil; }

- (void)execute:(CompletionBlock)completion {
    [self validate];
    
    NSMutableArray <Coordinate *> *coords = [NSMutableArray new];
    if (self.query.isCoordinateQuery) {
        CoordinateQuery *cq = [self.query asCoordinateQuery];
        if (cq.coordinate) {
            [coords addObject:cq.coordinate];
        }
        if (cq.coordinates) {
            [coords addObjectsFromArray:cq.coordinates];
        }
    } else {
        NSArray <XCUIElement *> *elements = [self.query execute];
        if (elements.count == 0) {
            @throw [CBXException withMessage:@"Error performing gesture: No elements match query."];
        }
        for (XCUIElement *el in elements) {
            /*
                TODO: discussion of 'visibility'
            */
            CGRect frame = el.wdFrame;
            CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidX(frame));
            [coords addObject:[Coordinate fromRaw:center]];
        }
    }
    
    
    //Testmanagerd calls are async, but the http server is sync so we need to synchronize it.
    [ThreadUtils runSync:^(BOOL *setToTrueWhenDone, NSError *__autoreleasing *err) {
        if ([[XCTestDriver sharedTestDriver] daemonProtocolVersion] != 0x0) {
            [[Testmanagerd get] _XCT_synthesizeEvent:[self eventWithCoordinates:coords]
                                          completion:^(NSError *e) {
                                              *setToTrueWhenDone = YES;
                                              *err = e;
                                          }];
        } else {
            [[Testmanagerd get] _XCT_performTouchGesture:[self gestureWithCoordinates:coords]
                                              completion:^(NSError *e) {
                                                  *setToTrueWhenDone = YES;
                                                  *err = e;
                                              }];
        }
    } completion:completion];
}

@end