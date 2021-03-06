// class-dump results processed by bin/class-dump/dump.rb
//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//



#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCUIElementTypes.h>
#import "CDStructures.h"
@protocol OS_dispatch_queue;
@protocol OS_xpc_object;

@class NSData, NSString, UIImage, _XCTImageImplementation;

@interface XCTImage : NSObject <NSCopying>
{
    _XCTImageImplementation *_internalImplementation;
}

@property(readonly, copy) NSData *data;
@property(readonly, copy) UIImage *image;
@property(retain) _XCTImageImplementation *internalImplementation;
@property(copy) NSString *name;
@property(readonly) double scale;

+ (id)UTIForQuality:(NSInteger)arg1;
+ (id)_dataForImage:(id)arg1 quality:(NSInteger)arg2;
+ (double)_scaleForImage:(id)arg1;
+ (double)compressionQualityForQuality:(NSInteger)arg1;
- (void)_ensureImage;
- (id)_init;
- (id)attachment;
- (id)dataWithQuality:(NSInteger)arg1;
- (id)debugQuickLookObject;
- (id)initWithData:(id)arg1 scale:(double)arg2;
- (id)initWithImage:(id)arg1;

@end

