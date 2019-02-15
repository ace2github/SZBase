//
//  SZModuleTester.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/2/15.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "SZModuleTester.h"
#import "SZLoginModule.h"
#import "SZAccountModule.h"

@implementation SZModuleTester
+ (void)runTests {
    [[SZLoginModule shareModule] reloginAgain];
    [[SZAccountModule shareModule] storageAccount];
}
@end
