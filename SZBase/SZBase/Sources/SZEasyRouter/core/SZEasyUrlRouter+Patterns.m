//
//  SZEasyUrlRouter+Patterns.m
//  MGJRouterDemo
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 juangua. All rights reserved.
//

#import "SZEasyUrlRouter+Patterns.h"
NSString *const kSZEasyRouterUrlPatternBeginCharacter = @"::";

@implementation SZEasyUrlRouter (Patterns)
#pragma mark Categry for Pattern
- (NSString *)generateURLWithPattern:(NSString *)patternUrl parameters:(NSArray *)parameters {
    NSString *newUrl = [patternUrl copy];
    
    NSString *encodeUrl = [self.class encodeUrlString:patternUrl];
    
    NSArray *pathComponents = [self pathComponents:encodeUrl];
    NSInteger paramIndex = 0;
    for (NSInteger i=0; i<pathComponents.count; i++) {
        NSString *path = [pathComponents objectAtIndex:i];
        if ([path hasPrefix:kSZEasyRouterUrlPatternBeginCharacter]) {
            if (paramIndex < parameters.count) {
                NSString *param = [parameters objectAtIndex:paramIndex++];
                newUrl = [newUrl stringByReplacingOccurrencesOfString:path withString:[self.class decodeUrlString:param]];
            } else {
                newUrl = nil;
                break;
            }
        }
    }
    
    return newUrl;
}
@end
