//
//  SZRWLockTest.h
//  SZSafeDemo
//
//  Created by ChaohuiChen on 2019/1/30.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZRWLock.h"

@interface SZRWLockTest : NSObject
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) SZRWLock *rwlock;

- (void)runTests;
@end

