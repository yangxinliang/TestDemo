//
//  YXLDrawViewController.m
//  TouchTracker
//
//  Created by PingAnXL on 17/4/11.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "YXLDrawViewController.h"
#import "YXLDrawView.h"

@interface YXLDrawViewController ()

@end

@implementation YXLDrawViewController
//  加载view的方法
- (void)loadView {


    YXLDrawView * backView = [[YXLDrawView alloc] init];

    self.view = backView;

}
// 控制器初始化的方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.tabBarItem.title = @"单手触摸";
        
        
    }

    return self;
}
// 视图在控制器生命周期
- (void)viewDidLoad {

    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    
    btn.backgroundColor = [UIColor redColor];

    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:btn];


}

- (void)btnClick {
  
    
    NSLog(@"我被点击了");

}


@end
