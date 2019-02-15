//
//  SZAppLifeTester.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZAppLifeTester.h"

@implementation SZAppLifeTester
+ (void)runTests {
    //handler 1
    SZAppHandler *handler1 = [[SZAppHandler alloc] init];
    handler1.appWillResignActiveBlock = ^(id context) {
        NSLog(@"handler1: appWillResignActiveBlock");
    };
    handler1.appDidEnterBackgroundBlock = ^(id context) {
        NSLog(@"handler1: appDidEnterBackgroundBlock");
    };
    [[SZAppLife defaultCenter] registerHandler:handler1];
    
    //handler 2
    SZAppHandler *handler2 = [[SZAppHandler alloc] init];
    handler2.appDidEnterBackgroundBlock = ^(id context) {
        NSLog(@"handler2: appDidEnterBackgroundBlock");
    };
    handler2.appDidBecomeActiveBlock = ^(id context) {
        NSLog(@"handler2: appDidBecomeActiveBlock");
    };
    [[SZAppLife defaultCenter] registerHandler:handler2];
}
@end
