//
//  SZRWLockTest.m
//  SZSafeDemo
//
//  Created by ChaohuiChen on 2019/1/30.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZRWLockTest.h"

@implementation SZRWLockTest
- (void)runTests {
    _datasource = [NSMutableArray array];
    [self.datasource addObject:@"init value"];
    
    self.rwlock = [[SZRWLock alloc] init];
    
    //test
    [self bigDataWrite];
    [self readTask:@"[A]" time:0.1];
    [self readTask:@"[B]" time:0.05];
    [self readTask:@"[C]" time:0.01];
    [self writeTask:@"<1>" time:0.03];
    [self writeTask:@"<2>" time:0.09];
    //test end
}


- (void)bigDataWrite{
    double time = CFAbsoluteTimeGetCurrent();
    [self.rwlock writeLock];
    for (double i=0; i<1000000; i++) {
        [self.datasource addObject:[NSString stringWithFormat:@"New Value : %@",@(i)]];
    }
    [self.rwlock unlock];
    NSLog(@"Time::%f",CFAbsoluteTimeGetCurrent()-time);
}

- (void)readTask:(NSString *)name time:(float)time {
    __weak typeof(self) wSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:time repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(wSelf) sSelf = wSelf;
        //NSLog(@"\n\n");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            double time = CFAbsoluteTimeGetCurrent();
            [sSelf.rwlock readLock];
            //            if (![sSelf.rwlock tryReadLock]) {
            //                NSLog(@"Error.Read");
            //                return ;
            //            }
            NSLog(@"-------------------------- %@,Read Start!",name);
            NSLog(@"%@,Read:: %@", name, sSelf.datasource.firstObject);
            NSLog(@"-------------------------- %@,Read END!",name);
            [sSelf.rwlock unlock];
            NSLog(@"Time::%f",CFAbsoluteTimeGetCurrent()-time);
        });
    }];
}

- (void)writeTask:(NSString *)name time:(float)time{
    __weak typeof(self) wSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:time repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(wSelf) sSelf = wSelf;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            double time = CFAbsoluteTimeGetCurrent();
            [sSelf.rwlock writeLock];
            //            if (![sSelf.rwlock tryWriteLock]) {
            //                NSLog(@"Error.write");
            //                return ;
            //            }
            NSLog(@"\n\n");
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>> %@,Write Start!",name);
            sSelf.datasource[0] = [NSString stringWithFormat:@"%@,Wirte New Value",name];
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>> %@,Write END!",name);
            [sSelf.rwlock unlock];
            NSLog(@"Time::%f",CFAbsoluteTimeGetCurrent()-time);
        });
    }];
}
@end
