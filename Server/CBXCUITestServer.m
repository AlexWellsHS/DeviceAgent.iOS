//
//  CalabashXCUITestServer.m
//  xcuitest-server

#import "RoutingHTTPServer.h"
#import "RoutingConnection.h"
#import "CBXCUITestServer.h"
#import "UIDevice+Wifi_IP.h"
#import "UndefinedRoutes.h"
#import <objc/runtime.h>
#import "CBProtocols.h"
#import "CBConstants.h"

@interface CBXCUITestServer ()
@property (atomic, strong) RoutingHTTPServer *server;
@property (atomic, strong) NSRunLoop *runLoop;
@end

@implementation CBXCUITestServer

static CBXCUITestServer *sharedServer;

+ (void)load {
    static dispatch_once_t oncet;
    dispatch_once(&oncet, ^{
        sharedServer = [self new];
        sharedServer.server = [[RoutingHTTPServer alloc] init];
        [sharedServer.server setRouteQueue:dispatch_get_main_queue()];
        [sharedServer.server setDefaultHeader:@"CalabusDriver"
                                        value:@"CalabashXCUITestServer/1.0"];
        [sharedServer.server setConnectionClass:[RoutingConnection self]];
        [sharedServer.server setType:@"_calabus._tcp."];

        NSString *uuid = [[NSProcessInfo processInfo] globallyUniqueString];
        NSString *token = [uuid componentsSeparatedByString:@"-"][0];
        NSString *serverName = [NSString stringWithFormat:@"CalabusDriver-%@", token];
        [sharedServer.server setName:serverName];

        NSDictionary *capabilities =
        @{
          @"name" : [[UIDevice currentDevice] name]
          };

        [sharedServer.server setTXTRecordDictionary:capabilities];
        [sharedServer registerRoutes];
    });
}

+ (void)start {
    NSLog(@"CalabashXCUITestServer built at %s %s", __DATE__, __TIME__);
    [sharedServer start];
}

- (void)start {
    NSError *error;
    BOOL serverStarted = NO;
        
    [self.server setPort:DEFAULT_SERVER_PORT];
    serverStarted = [self attemptToStartWithError:&error];
    
    if (!serverStarted) {
        NSLog(@"Attempt to start web server failed with error %@", [error description]);
        abort();
    }

    NSLog(@"CalabashXCUITestServer started on http://%@:%hu",
          [UIDevice currentDevice].wifiIPAddress,
          [self.server port]);

    self.runLoop = [NSRunLoop mainRunLoop];
    while ([self.server isRunning] && [self.runLoop runMode:NSDefaultRunLoopMode
                                                 beforeDate:[NSDate distantFuture]]) {
        ;
    }
}

+ (void)stop {
    [sharedServer stop];
}

- (void)stop {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{ [self.server stop:NO];
        [self.server stop:NO];
        NSLog(@"CALABUS DRIVER HAS RETIRED");
    });
}

- (BOOL)attemptToStartWithError:(NSError **)error {
    NSError *innerError = nil;
    BOOL started = [self.server start:&innerError];
    if (!started) {
        if (!error) {
            return NO;
        }
        
        NSString *description = @"Unknown Error when Starting server";
        if ([innerError.domain isEqualToString:NSPOSIXErrorDomain] && innerError.code == EADDRINUSE) {
            description = [NSString stringWithFormat:@"Unable to start web server on port %ld", (long)self.server.port];
        }
        
        *error = [NSError errorWithDomain:CBWebServerErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : description, NSUnderlyingErrorKey : innerError}];
        return NO;
    }
    return YES;
}

/*
 *  Use objc runtime to get all classes inheriting implementing CBRoute.
 *  call [Class addRoutesToServer:self.server] on all resulting classes.
 */
- (void)registerRoutes {
    unsigned int outCount;
    Class *classes = objc_copyClassList(&outCount);
    for (int i = 0; i < outCount; i++) {
        Class c = classes[i];
        if (class_conformsToProtocol(c, @protocol(CBRouteProvider))) {
            NSArray <CBRoute *> *routes = [c performSelector:@selector(getRoutes)];
            for (CBRoute *route in routes) {
                if ([route shouldAutoregister]) {
                    [self.server addRoute:route];
                }
            }
        }
    }
    free(classes);
    for (CBRoute *route in [UndefinedRoutes getRoutes]) {
        [self.server addRoute:route];
    }
}

@end