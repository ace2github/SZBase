//
//  SZEasyTest.m
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 juangua. All rights reserved.
//

#import "SZEasyTest.h"
#import "SZEasyRouter.h"
#import "SZEasyUrlRouter.h"
#import "SZEasyUrlRouter+Patterns.h"

@implementation SZEasyTest
+ (void)runTests {
    [self testDetaultEasyRouter];
    [self testUrlEasyRouter];
    [self testUrlEasyRouterURLPattern];
}

+ (void)testDetaultEasyRouter {
    SZEasyRouter *eRouter = [[SZEasyRouter alloc] init];
    [eRouter addRoutePath:@"a.b.c" object:@"a.b.c"];
    NSLog(@"%@",[eRouter objectWithRoutePath:@"a"]);//nil
    NSLog(@"%@",[eRouter objectWithRoutePath:@"a.b.c.1"]);//nil
    
    
    [eRouter addRoutePath:@"a.b" object:@"a.b"];
    [eRouter addRoutePath:@"a.b.d" object:@"a.b.d"];
    NSLog(@"%@",[eRouter objectWithRoutePath:@"a.b.c"]);
    NSLog(@"%@",[eRouter objectWithRoutePath:@"a.b"]);
    NSLog(@"%@",[eRouter objectWithRoutePath:@"a.b.d"]);
    
    NSLog(@"%@",[eRouter objectWithRoutePath:@"a.b.f"]);

}

+ (void)testUrlEasyRouter {
    NSString *url = @"mgj://search/car";
    [SZEasyUrlRouter registerUrl:url handler:^(id userInfo, NSDictionary *parameters, SZEasyUrlRouteCompleteHandler complete) {
        NSLog(@"open success");
        NSLog(@"%@, \n%@, \n%@",userInfo ,parameters, complete);
    }];
    [SZEasyUrlRouter openUrl:url userInfo:nil complete:nil];

    //带参数的url
    url = @"mgj://foo/bar?key=value&name=陈朝晖&password=";
    [SZEasyUrlRouter registerUrl:url handler:^(id userInfo, NSDictionary *parameters, SZEasyUrlRouteCompleteHandler complete) {
        NSLog(@"open success");
        NSLog(@"%@, \n%@, \n%@",userInfo ,parameters, complete);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (complete) complete(@"执行完咯，回调给你了");
        });
    }];
    [SZEasyUrlRouter openUrl:url userInfo:@"不需要CallBack" complete:nil];
    
    //需要complete回调的调用
    [SZEasyUrlRouter openUrl:url userInfo:@"123 需要CallBack" complete:^(id result) {
        NSLog(@"open CallBack: %@", result);
    }];
    
    
    //未注册
    [SZEasyUrlRouter openUrl:@"mgj://" userInfo:@"未注册" complete:^(id result) {
        NSLog(@"未注册 CallBack: %@", result);
    }];
    [SZEasyUrlRouter openUrl:@"mgj://foo" userInfo:@"未注册" complete:^(id result) {
        NSLog(@"未注册 CallBack: %@", result);
    }];
    [SZEasyUrlRouter openUrl:@"mgj://foo/bar/car" userInfo:nil complete:nil];
}

+ (void)testUrlEasyRouterURLPattern {
    SZEasyUrlRouter *urlRouter = [[SZEasyUrlRouter alloc] init];
    NSLog(@"%@",[urlRouter generateURLWithPattern:@"mgj://search/::color/::size" parameters:@[@"red",@"1024"]]);
    NSLog(@"%@",[urlRouter generateURLWithPattern:@"mgj://search/::color/::size/detail.html" parameters:@[@"red",@"1024"]]);
    NSLog(@"%@",[urlRouter generateURLWithPattern:@"mgj://search/::color/::size/detail.html#fragment?key=value" parameters:@[@"red",@"1024"]]);
    NSLog(@"%@",[urlRouter generateURLWithPattern:@"search/::color/::size/detail.html" parameters:@[@"red",@"1024"]]);
    NSLog(@"%@",[urlRouter generateURLWithPattern:@"search/::color/::size/detail.html" parameters:@[@"red",@"1024",@"Err"]]);
    NSLog(@"%@",[urlRouter generateURLWithPattern:@"search/::color/::size/detail.html" parameters:@[@"red"]]);
    
    NSString *urlPattern = @"mgj://search/::color/::size/detail.html?key=value";
    [[SZEasyUrlRouter defaultRouter] registerUrl:urlPattern handler:^(id userInfo, NSDictionary *parameters, SZEasyUrlRouteCompleteHandler complete) {
        NSLog(@"%@, \n%@, \n%@",userInfo ,parameters, complete);
    }];
    
    [[SZEasyUrlRouter defaultRouter] openUrl:urlPattern userInfo:@{@"color":@"red",@"size":@(1024)}];
}
@end
