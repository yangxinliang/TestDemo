//
//  DicViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "DicViewController.h"

#import "XLDictionary.h"
#import "XLArray.h"

@interface DicViewController ()

@end

@implementation DicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    XLDictionary * dict = [XLDictionary dictionary];
    
    [dict setValue:@"哈哈" forKey:@"你的"];
    [dict setValue:@"你好" forKey:@"你的"];
    [dict setValue:@123456 forKey:@"数字"];
    
    NSLog(@"%@",[dict valueForKey:@"你的"]);
    NSLog(@"%@",[dict valueForKey:@"数字"]);
    
    XLArray * array = [XLArray array];
    
    [array addObject:@"dasdasda"];



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
