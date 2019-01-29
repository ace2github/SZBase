//
//  SZWeekSet.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZWeekSet.h"
@interface SZWeekSet ()
@property (nonatomic, strong) NSHashTable *objPool;
@end

@implementation SZWeekSet
- (id)init {
    if (self = [super init]) {
        _objPool = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:128];
    }
    return self;
}

- (void)addObject:(id)object {
    [_objPool addObject:object];
}
- (void)removeObject:(id)object {
    [_objPool removeObject:object];
}

- (void)removeAllObjects {
    [_objPool removeAllObjects];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
    NSEnumerator *enumerator = [_objPool objectEnumerator];
    id tmpObj = nil;
    BOOL stop = NO;
    NSUInteger index = 0;
    while ((tmpObj = [enumerator nextObject]) != nil) {
        if (block) block(tmpObj, index++, &stop);
        
        if (stop) break;
    }
}

- (NSArray *)allValues {
    return _objPool.allObjects;
}
@end
