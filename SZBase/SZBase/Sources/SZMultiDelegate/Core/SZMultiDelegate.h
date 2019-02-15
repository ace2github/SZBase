//
//  SZMultiDelegate.h
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/22.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZMultiDelegate : NSObject
- (id)initWithDelegates:(NSArray*)delegates;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;
@end

NS_ASSUME_NONNULL_END
