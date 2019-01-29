//
//  SZEasyRouter.m
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/18.
//  Copyright © 2019 juangua. All rights reserved.
//

#import "SZEasyRouter.h"

NSString *const kSZEasyRouterObject = @"robject";

@interface SZEasyRouter ()
@property (nonatomic, strong) NSMutableDictionary *rootRouter;
@end

@implementation SZEasyRouter
+ (instancetype)defaultRouter {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)addRoutePath:(NSString *)routePath object:(id)object {
    NSMutableDictionary *subRouter = [self createRoutePath:routePath];
    //NSLog(@"nextRouter: %@",subRouter.allKeys);
    if (object && subRouter) {
        subRouter[kSZEasyRouterObject] = object;
        //[self printRounter];
        return YES;
    } else {
        return NO;
    }
}

- (id)objectWithRoutePath:(NSString *)routePath{
    NSMutableDictionary *subRouter = [self findRoutePath:routePath];
    if (subRouter) {
        return subRouter[kSZEasyRouterObject];
    } else {
        return nil;
    }
}

- (BOOL)containRoutePath:(NSString *)routePath {
    return [self findRoutePath:routePath] ? YES : NO;
}

#pragma mark - private
- (NSMutableDictionary *)createRoutePath:(NSString *)routePath {
    NSArray *pathComponents = [self pathComponents:routePath];
    
    NSMutableDictionary *nextRouter = self.rootRouter;
    for (NSString *path in pathComponents) {
        if (![nextRouter objectForKey:path]) {
            //创建新的路由Mapper
            nextRouter[path] = [[NSMutableDictionary alloc] init];
        }
        
        nextRouter = nextRouter[path]; //路由指向下一级
    }
    return nextRouter;
}
- (NSMutableDictionary *)rootRouter {
    if (!_rootRouter) {
        _rootRouter = [NSMutableDictionary dictionaryWithCapacity:1024];
    }
    return _rootRouter;
}
- (void)printRounter {
    NSLog(@"%@", self.rootRouter);
}

#pragma mark - SZEasyRouterProtocol
- (NSMutableDictionary *)findRoutePath:(NSString *)routePath {
    //默认路径格式L：a.b.c，则可以作为 KVC 的 key进行寻址
    return [self.rootRouter valueForKeyPath:routePath];
}

- (NSArray *)pathComponents:(NSString *)routePath {
    return [routePath componentsSeparatedByString:@"."];
}
@end
