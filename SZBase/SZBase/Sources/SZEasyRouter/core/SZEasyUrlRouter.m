//
//  SZEasyUrlRouter.m
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/18.
//  Copyright © 2019 juangua. All rights reserved.
//

#import "SZEasyUrlRouter.h"

#pragma mark - SZUrlRouteObject
@interface SZUrlRouteObject : NSObject
@property (nonatomic, copy) SZEasyUrlRouteHandler handler;
@end
@implementation SZUrlRouteObject
@end

#pragma mark - SZEasyUrlRouter
NSString *const kSZEasyRouterUrlSpecialCharacters = @"/?&.";

@interface SZEasyUrlRouter ()
@end

@implementation SZEasyUrlRouter
- (BOOL)registerUrl:(NSString *)url handler:(SZEasyUrlRouteHandler)handler {
    SZUrlRouteObject *obj = [[SZUrlRouteObject alloc] init];
    obj.handler = [handler copy];
    return [self addRoutePath:url object:obj];
}

#pragma mark open method
- (BOOL)openUrl:(NSString *)url {
    return [self openUrl:url userInfo:nil complete:nil];
}

- (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo {
    return [self openUrl:url userInfo:userInfo complete:nil];
}

- (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo complete:(SZEasyUrlRouteCompleteHandler)complete{
    SZUrlRouteObject *obj = [self objectWithRoutePath:url];
    if ([obj isKindOfClass:[SZUrlRouteObject class]]) {
        if (obj.handler) {
            NSString *newUrl = [self.class encodeUrlString:url];
            NSMutableDictionary *parameters = [self.class getUrlParameters:newUrl];
            [parameters enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
                if ([obj isKindOfClass:[NSString class]]) {
                    parameters[key] = [self.class decodeUrlString:obj];
                }
            }];
            NSLog(@"open url success: %@", url);
            obj.handler(userInfo, parameters, complete);
        }
    }
    return NO;
}

#pragma mark - SZEasyRouterProtocol
- (NSMutableDictionary *)findRoutePath:(NSString *)routePath {
    NSArray *pathComponents = [self pathComponents:routePath];
    
    NSMutableDictionary *nextRouter = self.rootRouter;
    for (NSString *path in pathComponents) {
        if ([nextRouter objectForKey:path]) {
            nextRouter = nextRouter[path]; //路由指向下一级
            continue;
        } else {
            //如果路径有一级未找到，则查找失败，直接返回
            nextRouter = nil;
            break;
        }
    }
    
    return nextRouter;
}

- (NSArray *)pathComponents:(NSString *)routePath {
    NSString *newUrl = [self.class encodeUrlString:routePath];
    
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([newUrl rangeOfString:@"://"].location != NSNotFound) {
        NSArray *components = [newUrl componentsSeparatedByString:@"://"];
        [pathComponents addObject:components.firstObject];
        newUrl = components.lastObject;
    }
    
    /**
     去除掉scheme的url，可以解析全部path；
     */
    for (NSString *component in [NSURL URLWithString:newUrl].pathComponents) {
        if ([component isEqualToString:@"/"]) continue;
        if ([[component substringToIndex:1] isEqualToString:@"?"]) break;
        [pathComponents addObject:[self.class decodeUrlString:component]];
    }
    return [pathComponents copy];
}

#pragma mark - Category for Utilities
+ (NSString *)encodeUrlString:(NSString *)url {
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)decodeUrlString:(NSString *)url {
    return [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (BOOL)ifContainsSpecialCharacter:(NSString *)checkedString {
    NSCharacterSet *specialCharactersSet = [NSCharacterSet characterSetWithCharactersInString:kSZEasyRouterUrlSpecialCharacters];
    return [checkedString rangeOfCharacterFromSet:specialCharactersSet].location != NSNotFound;
}

+ (NSMutableDictionary *)getUrlParameters:(NSString *)url {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:6];
    
    NSArray<NSURLQueryItem *> *queryItems = [[NSURLComponents alloc] initWithURL:[[NSURL alloc] initWithString:url] resolvingAgainstBaseURL:false].queryItems;
    for (NSURLQueryItem *item in queryItems) {
        if (item.name && item.name.length) {
            parameters[item.name] = item.value;
        }
    }
    
    return parameters;
}


#pragma mark - Category SZEasyUrlRouter (ClassMethod)
+ (BOOL)registerUrl:(NSString *)url handler:(SZEasyUrlRouteHandler)handler {
    return [[SZEasyUrlRouter defaultRouter] registerUrl:url handler:handler];
}

+ (BOOL)openUrl:(NSString *)url {
    return [[SZEasyUrlRouter defaultRouter] openUrl:url userInfo:nil complete:nil];
}
+ (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo {
    return [[SZEasyUrlRouter defaultRouter] openUrl:url userInfo:userInfo complete:nil];
}
+ (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo complete:(SZEasyUrlRouteCompleteHandler)complete {
    return [[SZEasyUrlRouter defaultRouter] openUrl:url userInfo:userInfo complete:complete];
}
@end
