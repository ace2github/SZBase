//
//  SZMultiDelegate.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/22.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZMultiDelegate.h"
#import "SZWeekArray.h"

@interface SZMultiDelegate ()
@property (nonatomic, strong) SZWeekArray *delegates;
@end

@implementation SZMultiDelegate
- (id)init {
    if (self = [super init]) {
        _delegates = [[SZWeekArray alloc] init];
    }
    return self;
}

- (id)initWithDelegates:(NSArray*)delegates {
    if (self = [super init]) {
        for (id obj in delegates) {
            [self addDelegate:obj];
        }
    }
    return self;
}

- (void)addDelegate:(id)delegate {
    [_delegates addObject:delegate];
}
- (void)removeDelegate:(id)delegate {
    [_delegates removeObject:delegate];
}
- (void)removeAllDelegates {
    [_delegates removeAllObjects];
}

#pragma mark - NSObject Methods
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id delegate in _delegates.allValues) {
        if (delegate && [delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    
    if (!_delegates.allValues.count) {
        // return any method signature, it doesn't really matter
        return [self methodSignatureForSelector:@selector(description)];
    }
    
    for (id delegate in _delegates.allValues) {
        if (delegate) {
            signature = [delegate methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    
    return signature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    BOOL responded = NO;
    
    NSArray *copiedDelegates = _delegates.allValues;
    for (id delegate in copiedDelegates) {
        if (delegate && [delegate respondsToSelector:selector]) {
            [anInvocation invokeWithTarget:delegate];
            responded = YES;
        }
    }
    
    if (!responded) {
        [self doesNotRecognizeSelector:selector];
    }
}
@end
