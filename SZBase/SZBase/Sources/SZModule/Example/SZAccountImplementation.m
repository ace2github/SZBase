//
//  SZAccountImplementation.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZAccountImplementation.h"

@implementation SZAccountImplementation
+ (void)load {
    [[SZAccountModule shareModule] implementWithImpl:[[self alloc] init]];
}

- (void)storageAccount {
    NSLog(@"%s",__func__);
}
@end
