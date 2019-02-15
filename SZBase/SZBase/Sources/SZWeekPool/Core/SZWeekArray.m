//
//  SZWeekArray.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZWeekArray.h"
@interface SZWeekArray ()
@property (nonatomic, strong) NSPointerArray *objPool;
@end

@implementation SZWeekArray
- (id)init {
    if (self = [super init]) {
        _objPool = [NSPointerArray weakObjectsPointerArray];
        //手动插入Null，否则Compact的时候不会将自动填充的Null元素剔除
        [_objPool addPointer:NULL];
    }
    return self;
}

- (NSArray *)allValues {
    [_objPool compact];
    return _objPool.allObjects;
}

- (NSUInteger)indexOfObject:(id)object {
    if (!object) return NSNotFound;
    
    for (NSUInteger index = 0; index < _objPool.count; index++) {
        if ([_objPool pointerAtIndex:index] == (__bridge void *)object) {
            return index;
        }
    }
    return NSNotFound;
}

- (void)addObject:(id)object{
    if (!object) return;
    
    [_objPool addPointer:(__bridge void *)object];
    [_objPool compact];
}

- (void)removeObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if (index != NSNotFound) {
        [_objPool removePointerAtIndex:index];
    }
    [_objPool compact];
}

- (void)removeAllObjects {
    for (NSInteger index = _objPool.count-1; index >= 0; index--) {
        [_objPool removePointerAtIndex:index];
    }
    [_objPool compact];
}
@end
