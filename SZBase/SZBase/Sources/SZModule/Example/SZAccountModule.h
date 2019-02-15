//
//  SZAccountModule.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZModule.h"

@protocol SZAccountModuleInterface <NSObject>
@optional
- (void)storageAccount;
@end

@interface SZAccountModule : SZModule <SZAccountModuleInterface>

@end
