//
//  SZWeekSet.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 1、插入的顺序会发送变动，且无序。如，1、2、3、4、5...  ——>   无序
 */
@interface SZWeekSet : NSObject
@property (readonly, copy) NSArray *allValues;

- (void)addObject:(id)object ;

- (void)removeObject:(id)object;

- (void)removeAllObjects ;

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
@end
