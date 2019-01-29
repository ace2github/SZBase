//
//  SZWeekArray.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 1、速度很慢很慢，大量数据操作的时候慎用
 */
@interface SZWeekArray : NSObject
@property (readonly, copy) NSArray *allValues;

- (NSUInteger)indexOfObject:(id)object;

- (void)addObject:(id)object ;

- (void)removeObject:(id)object;

- (void)removeAllObjects ;
@end

NS_ASSUME_NONNULL_END
