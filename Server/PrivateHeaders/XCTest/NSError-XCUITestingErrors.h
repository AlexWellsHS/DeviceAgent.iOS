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

@interface NSError (XCUITestingErrors)
+ (id)_xcui_error:(NSInteger)arg1 description:(id)arg2;
+ (id)_xcui_error:(NSInteger)arg1 description:(id)arg2 userInfo:(id)arg3;
+ (id)_xcui_errorWithDomain:(id)arg1 code:(NSInteger)arg2 description:(id)arg3;
- (BOOL)xcui_isUITestingError:(NSInteger)arg1;
@end

