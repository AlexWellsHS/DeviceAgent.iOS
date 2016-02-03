//
//  SessionRoutes.m
//  xcuitest-server
//
//  Created by Chris Fuentes on 1/29/16.
//  Copyright © 2016 calabash. All rights reserved.
//

#import "CBApplication.h"
#import "SessionRoutes.h"
#import "CBConstants.h"
#import "CBMacros.h"

@implementation SessionRoutes
+ (NSArray <CBRoute *> *)getRoutes {
    return @[
             [CBRoute post:@"/session" withBlock:^(RouteRequest *request, RouteResponse *response) {
                 NSDictionary *json = DATA_TO_JSON(request.body);
                 NSString *bundlePath = json[CB_BUNDLE_PATH_KEY];
                 NSString *bundleID = json[CB_BUNDLE_ID_KEY];
                 NSArray *launchArgs = json[CB_LAUNCH_ARGS_KEY] ?: @[];
                 NSDictionary *environment = json[CB_ENVIRONMENT_KEY] ?: @{};
                 
                 NSAssert(bundleID, @"Must specify \"bundleID\"");
                 
                 if (!bundlePath || [bundlePath isEqual:[NSNull null]]) {
                     [CBApplication launchBundleID:bundleID
                                        launchArgs:launchArgs
                                               env:environment];
                 } else {
                     [CBApplication launchBundlePath:bundlePath
                                            bundleID:bundleID
                                          launchArgs:launchArgs
                                                 env:environment];
                 }
                 [response respondWithJSON:@{@"status" : @"launching!"}];
             }]
             ];
}
@end
