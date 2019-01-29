//
//  SZWeekPoolTests.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZWeekPoolTests.h"
#import "SZWeekSet.h"

@implementation SZWeekPoolTests
+ (void)runTests {
    SZWeekSet *sets = [[SZWeekSet alloc] init];
    for (int i=0; i<26; i++) {
        [sets addObject:@(i)];
    }
    
    [sets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@ %@", obj, @(idx));
        if (idx == 10) *stop = YES;
    }];
    
}
@end
