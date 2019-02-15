//
//  ViewController.m
//  SZBase
//
//  Created by ChaohuiChen on 2019/1/21.
//  Copyright © 2019 ChaohuiChen. All rights reserved.
//

#import "ViewController.h"
#import "SZAppLifeTester.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"SZBaseDemo";
    [SZAppLifeTester runTests];
}


@end
