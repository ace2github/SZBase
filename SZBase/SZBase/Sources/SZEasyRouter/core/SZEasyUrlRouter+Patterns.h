//
//  SZEasyUrlRouter+Patterns.h
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 juangua. All rights reserved.
//

#import "SZEasyUrlRouter.h"
/**
 URL格式定义：scheme://paths/::CustomKey?k1=v1&k2=v2，其中::CustomKey 可以被动态替换
 
 所有针对Url的变形解析，都可以通过Url的字符串操作实现，与底层Router算法无关
 */
@interface SZEasyUrlRouter (Patterns)
- (NSString *)generateURLWithPattern:(NSString *)patternUrl parameters:(NSArray *)parameters;
@end
