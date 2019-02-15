//
//  SZAppLife.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZAppLife.h"

@interface SZAppLife ()
@property (nonatomic, strong) NSMutableArray *handlerPool;
@end

@implementation SZAppLife
+ (instancetype)defaultCenter {
    static SZAppLife *_defaultCenter = nil;
    static dispatch_once_t _onceToken = 0;
    dispatch_once(&_onceToken, ^{
        _defaultCenter = [[self alloc] init];
    });
    return _defaultCenter;
}
- (id)init {
    if (self = [super init]) {
        _handlerPool = [NSMutableArray arrayWithCapacity:128];
        [self bindAppLifeNotifications];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public
- (void)registerHandler:(SZAppHandler *)handler {
    if (handler) {
        [self unregisterHandler:handler];
        [self.handlerPool addObject:handler];
    }
}
- (void)unregisterHandler:(SZAppHandler *)handler {
    if (handler && [self.handlerPool containsObject:handler]) {
        [self.handlerPool removeObject:handler];
    }
}

#pragma mark - private
- (void)bindAppLifeNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(appWillResignActiveHandler:)
                               name:UIApplicationWillResignActiveNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(appDidEnterBackgroundHandler:)
                               name:UIApplicationDidEnterBackgroundNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(appWillEnterForegroundHandler:)
                               name:UIApplicationWillEnterForegroundNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(appDidBecomeActiveHandler:)
                               name:UIApplicationDidBecomeActiveNotification
                             object:nil];
}

#pragma mark handler
- (void)appWillResignActiveHandler:(NSNotification *)notification {
    NSArray *list = [self.handlerPool copy];
    [list enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(SZAppHandler *handler, NSUInteger idx, BOOL* stop) {
        if (handler.appWillResignActiveBlock) {
            handler.appWillResignActiveBlock(handler.context);
        }
    }];
}

- (void)appDidEnterBackgroundHandler:(NSNotification *)notification {
    NSArray *list = [self.handlerPool copy];
    [list enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(SZAppHandler *handler, NSUInteger idx, BOOL* stop) {
        if (handler.appDidEnterBackgroundBlock) {
            handler.appDidEnterBackgroundBlock(handler.context);
        }
    }];
}

- (void)appWillEnterForegroundHandler:(NSNotification *)notification {
    NSArray *list = [self.handlerPool copy];
    [list enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(SZAppHandler *handler, NSUInteger idx, BOOL* stop) {
        if (handler.appWillEnterForegroundBlock) {
            handler.appWillEnterForegroundBlock(handler.context);
        }
    }];
}

- (void)appDidBecomeActiveHandler:(NSNotification *)notification {
    NSArray *list = [self.handlerPool copy];
    [list enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(SZAppHandler *handler, NSUInteger idx, BOOL* stop) {
        if (handler.appDidBecomeActiveBlock) {
            handler.appDidBecomeActiveBlock(handler.context);
        }
    }];
}
@end
