//
//  SZModule.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZModule.h"

@interface SZModule ()
@property (nonatomic, strong) id<SZYModule> impl;
@end

@implementation SZModule
+ (NSMutableDictionary *)moduleMapper {
    static NSMutableDictionary *_modulesMapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _modulesMapper = [[NSMutableDictionary alloc] init];
    });
    return _modulesMapper;
}

+ (instancetype)shareModule {
    NSAssert(![self isEqual:[SZModule class]], @"Cannot create virtual interface.");
    
    NSString *moduleKey = NSStringFromClass([self class]);
    id module = [self moduleMapper][moduleKey];
    if (!module) {
        module = [[self alloc] init];
        [self moduleMapper][moduleKey] = module;
    }
    return module;
}

#pragma mark - core
#pragma mark - getter & setter
- (BOOL)containImpl {
    return _impl ? YES : NO;
}
- (id)implementation {
    return _impl;
}

- (BOOL)implementWithImpl:(id<SZYModule>)impl {
    if (self.impl) {
        return NO;
    } else {
        self.impl = impl;
    }
    return YES;
}

#pragma mark - private
#pragma mark method
- (BOOL)respondsToSelector:(SEL)aSelector {
    return self.impl && [self.impl respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (self.impl && [self.impl respondsToSelector:aSelector]) {
        return self.impl;
    } else {
        return nil;
    }
}

#pragma mark key-path
- (id)valueForKey:(NSString *)key {
    if (self.impl) {
        return [(NSObject *)self.impl valueForKey:key];
    }
    return nil;
}

- (id)valueForKeyPath:(NSString *)keyPath {
    if (self.impl) {
        return [(NSObject *)self.impl valueForKeyPath:keyPath];
    }
    return nil;
}

- (BOOL)validateValue:(inout id _Nullable * _Nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError {
    if (self.impl) {
        return [(NSObject *)self.impl validateValue:ioValue
                                             forKey:inKey
                                              error:outError];
    }
    return NO;
}

- (BOOL)validateValue:(inout id _Nullable * _Nonnull)ioValue forKeyPath:(NSString *)inKeyPath error:(out NSError **)outError {
    if (self.impl) {
        return [(NSObject *)self.impl validateValue:ioValue
                                         forKeyPath:inKeyPath
                                              error:outError];
    }
    return NO;
}
@end
