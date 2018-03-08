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

@class NSData;

@interface XCAccessibilityElement : NSObject <NSCopying, NSSecureCoding>
{
    NSInteger _processIdentifier;
    const struct __AXUIElement *_AXUIElement;
    NSData *_token;
    NSUInteger _elementOrHash;
    NSUInteger _elementID;
    NSUInteger _elementType;
    NSUInteger _originPlatform;
}

@property(readonly) const struct __AXUIElement *AXUIElement;
@property(readonly) NSUInteger elementID;
@property(readonly) NSUInteger elementOrHash;
@property(readonly) NSUInteger elementType;
@property(readonly) NSUInteger originPlatform;
@property(readonly) NSInteger processIdentifier;
@property(readonly, copy) NSData *token;

+ (id)deviceElement;
+ (id)elementWithAXUIElement:(struct __AXUIElement *)arg1;
+ (id)elementWithProcessIdentifier:(NSInteger)arg1;
+ (id)mockElementWithProcessIdentifier:(NSInteger)arg1;
+ (id)mockElementWithProcessIdentifier:(NSInteger)arg1 payload:(id)arg2;
- (id)initWithAXUIElement:(struct __AXUIElement *)arg1 elementType:(NSUInteger)arg2;
- (id)initWithToken:(id)arg1 elementOrHash:(NSUInteger)arg2 elementID:(NSUInteger)arg3 pid:(NSInteger)arg4 elementType:(NSUInteger)arg5 originPlatform:(NSUInteger)arg6;

@end
