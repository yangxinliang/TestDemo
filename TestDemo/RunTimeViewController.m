//
//  RunTimeViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "RunTimeViewController.h"

#import "RunTimePerson.h"
@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RunTimePerson * p = [RunTimePerson new];
    
    //    id p = [[Person alloc] init];
    
    //    [p setAge:@(18)];
    //
    //    NSLog(@"%lu,%.2f",[p integerValue],[p doubleValue]);
    
    //    [p eat];
    
    //    [p performSelector:@selector(run)];
    
    
    [p performSelector:@selector(run:) withObject:@"Yannik"];

    
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
