//
//  SZEasyRouter.h
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/18.
//  Copyright © 2019 juangua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SZEasyRouterProtocol <NSObject>
- (NSMutableDictionary *)findRoutePath:(NSString *)routePath;
- (NSArray *)pathComponents:(NSString *)routePath;
@end

/*
 默认路径格式L：a.b.c
 */
@interface SZEasyRouter : UIView <SZEasyRouterProtocol>
+ (instancetype)defaultRouter;

//请勿随意更改里面的内容
@property (readonly) NSMutableDictionary *rootRouter;

- (BOOL)addRoutePath:(NSString *)routePath object:(id)object;
- (id)objectWithRoutePath:(NSString *)routePath;
- (BOOL)containRoutePath:(NSString *)routePath;

//test
- (void)printRounter;
@end

