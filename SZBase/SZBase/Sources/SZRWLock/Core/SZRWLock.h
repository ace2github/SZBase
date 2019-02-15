//
//  SZRWLock.h
//  testdemo
//
//  Created by ChaohuiChen on 09/03/2018.
//  Copyright © 2018 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************
 *
 * pthread的读写锁的OC实现方式
 *
 **************************************/
@interface SZRWLock : NSObject
/*
 * 阻塞Read，当前Write操作未完成时，阻塞当前线程，直到Write完成
 * 成功返回YES，失败返回NO
 */
- (BOOL)readLock;
/*
 * 阻塞Write，当前Read或Write操作未完成时，阻塞当前线程，直到Read或Write完成
 * 成功返回YES，失败返回NO
 */
- (BOOL)writeLock;



/*
 * 非阻塞Read，当前Write操作未完成时，立刻返回
 * 成功返回YES，失败返回NO
 */
- (BOOL)tryReadLock;
/*
 * 非阻塞Write，当前Read或Write操作未完成时，立刻返回，
 * 成功返回YES，失败返回NO
 */
- (BOOL)tryWriteLock;



/*
 * 解锁
 * 成功返回YES，失败返回NO
 */
- (BOOL)unlock;
@end
