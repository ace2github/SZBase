//
//  SZModule.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SZYModule <NSObject>
@end

@interface SZModule : NSObject
@property (nonatomic, assign, readonly) BOOL containImpl;
@property (nonatomic, strong, readonly) id implementation;

+ (instancetype)shareModule;
- (BOOL)implementWithImpl:(id<SZYModule>)impl;
@end

