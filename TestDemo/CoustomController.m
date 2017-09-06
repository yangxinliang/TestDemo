//
//  CoustomController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "CoustomController.h"

#import "YXLViewController.h"
#import "YXLDrawViewController.h"
@interface CoustomController ()

@end

@implementation CoustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    YXLDrawViewController * vc = [[YXLDrawViewController alloc] init];
    
    YXLViewController * vc2 = [[YXLViewController alloc] init];

    self.viewControllers = @[vc,vc2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
