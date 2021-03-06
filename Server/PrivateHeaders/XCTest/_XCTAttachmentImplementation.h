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

@class NSData, NSDate, NSDictionary, NSString;

@interface _XCTAttachmentImplementation : NSObject
{
    NSString *_uniformTypeIdentifier;
    NSInteger _lifetime;
    NSString *_name;
    NSDate *_timestamp;
    NSDictionary *_userInfo;
    NSData *_payload;
    NSString *_fileNameOverride;
    CDUnknownBlockType _serializationBlock;
    BOOL _hasPayload;
}

@property(copy) NSString *fileNameOverride;
@property BOOL hasPayload;
@property NSInteger lifetime;
@property(copy) NSString *name;
@property(copy) NSData *payload;
@property(copy) CDUnknownBlockType serializationBlock;
@property(copy) NSDate *timestamp;
@property(copy) NSString *uniformTypeIdentifier;
@property(copy) NSDictionary *userInfo;


@end

