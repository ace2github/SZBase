//
//  SZRWLock.m
//  testdemo
//
//  Created by ChaohuiChen on 09/03/2018.
//  Copyright © 2018 ChaohuiChen. All rights reserved.
//

#import "SZRWLock.h"
#import <pthread.h>
@interface SZRWLock () {
    pthread_rwlock_t _rwlock;
}
@end

@implementation SZRWLock
- (id)init {
    if (self = [super init]) {
        //PTHREAD_PROCESS_SHARED：互斥锁可以被跨进程共享，即多进程共享
        //PTHREAD_PROCESS_PRIVATE：只能被初始化线程所属的进程中的线程共享，单进程共享
        pthread_rwlockattr_t attr;
        pthread_rwlockattr_init(&attr);
        pthread_rwlockattr_setpshared(&attr, PTHREAD_PROCESS_PRIVATE);
        
        //成功返回 0
        int result = pthread_rwlock_init(&_rwlock, &attr);
        if (result) {
            return nil;
        }
    }
    return self;
}

- (void)dealloc {
    pthread_rwlock_destroy(&_rwlock);
}

- (BOOL)readLock {
    return pthread_rwlock_rdlock(&_rwlock) ? NO : YES;
}

- (BOOL)writeLock {
    return pthread_rwlock_wrlock(&_rwlock) ? NO : YES;
}

- (BOOL)tryReadLock {
    return pthread_rwlock_tryrdlock(&_rwlock) ? NO : YES;
}

- (BOOL)tryWriteLock {
    return pthread_rwlock_trywrlock(&_rwlock) ? NO : YES;
}


- (BOOL)unlock {
    return pthread_rwlock_unlock(&_rwlock) ? NO : YES;
}
@end
