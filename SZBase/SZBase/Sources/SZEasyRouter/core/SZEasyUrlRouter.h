//
//  SZEasyUrlRouter.h
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/18.
//  Copyright © 2019 juangua. All rights reserved.
//

#import "SZEasyRouter.h"

typedef void (^SZEasyUrlRouteCompleteHandler)(id result);
typedef void (^SZEasyUrlRouteHandler)(id userInfo, NSDictionary *parameters, SZEasyUrlRouteCompleteHandler complete);

/*
 URL格式定义：scheme://paths?k1=v1&k2=v2
 */
@interface SZEasyUrlRouter : SZEasyRouter
- (BOOL)registerUrl:(NSString *)url handler:(SZEasyUrlRouteHandler)handler;

- (BOOL)openUrl:(NSString *)url;
- (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo;
- (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo complete:(SZEasyUrlRouteCompleteHandler)complete;
@end

@interface SZEasyUrlRouter (Utilities)
+ (NSString *)encodeUrlString:(NSString *)url;

+ (NSString *)decodeUrlString:(NSString *)url;

+ (NSMutableDictionary *)getUrlParameters:(NSString *)url;
@end
@interface SZEasyUrlRouter (ClassMethod)
+ (BOOL)registerUrl:(NSString *)url handler:(SZEasyUrlRouteHandler)handler;

+ (BOOL)openUrl:(NSString *)url;
+ (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo;
+ (BOOL)openUrl:(NSString *)url userInfo:(id)userInfo complete:(SZEasyUrlRouteCompleteHandler)complete;
@end
