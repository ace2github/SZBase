//
//  SZAppHandler.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZAppHandler : NSObject
@property (nonatomic, strong) id context;

@property (nonatomic, copy) void (^appWillResignActiveBlock)(id context);
@property (nonatomic, copy) void (^appDidEnterBackgroundBlock)(id context);
@property (nonatomic, copy) void (^appWillEnterForegroundBlock)(id context);
@property (nonatomic, copy) void (^appDidBecomeActiveBlock)(id context);
@end

