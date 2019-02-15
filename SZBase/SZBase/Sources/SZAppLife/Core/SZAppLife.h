//
//  SZAppLife.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAppHandler.h"

@interface SZAppLife : NSObject
+ (instancetype)defaultCenter;

- (void)registerHandler:(SZAppHandler *)handler;
- (void)unregisterHandler:(SZAppHandler *)handler;
@end
