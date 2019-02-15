//
//  SZLoginModuleInterface.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SZLoginModuleInterface <NSObject>
@optional
- (void)reloginAgain;
@end
