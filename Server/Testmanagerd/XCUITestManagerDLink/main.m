//
//  main.m
//  XCUITestManagerDLink
//
//  Created by Chris Fuentes on 2/16/16.
//  Copyright © 2016 calabash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeShim.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [XcodeShim connect];
    }
    return 0;
}
