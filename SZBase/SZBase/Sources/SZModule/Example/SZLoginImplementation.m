//
//  SZLoginImplementation.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZLoginImplementation.h"

@implementation SZLoginImplementation
+ (void)load {
    [[SZLoginModule shareModule] implementWithImpl:[[self alloc] init]];
}

- (void)reloginAgain {
    NSLog(@"%s",__func__);
}
@end
