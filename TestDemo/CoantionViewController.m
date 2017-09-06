//
//  CoantionViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/9/4.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "CoantionViewController.h"
#import "DrawCyclesView.h"
@interface CoantionViewController ()

/**  **/
@property (nonatomic, strong) UIView * redView;
/**  **/
@property (nonatomic, strong) UIView * yellowView;



@end

@implementation CoantionViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, 100, 40)];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
  
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 40, 40)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 40, 40)];
    self.yellowView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:self.yellowView];

    
    
    DrawCyclesView*cView =[[DrawCyclesView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2,self.view.center.y - 50, 200, 200)];
    [self.view addSubview:cView];
    
 
    
    
}

- (void)clickbtn {


    // 基础动画
//    CABasicAnimation * animation = [CABasicAnimation animation];
//    animation.keyPath = @"position.x";
//    animation.fromValue = @77;
//    animation.toValue = @455;
//    animation.duration = 1;
////    animation.fillMode = kCAFillModeForwards;
////    animation.removedOnCompletion = NO;
//    [self.redView.layer addAnimation:animation forKey:@"basic"];
//    
////    self.redView.layer.position = CGPointMake(455, 61);
//    
//    animation.beginTime = CACurrentMediaTime() + 0.5;
//    [self.yellowView.layer addAnimation:animation forKey:@"basic"];
    
    
    // 关键帧动画 （水平晃动）
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position.x";
//    animation.values = @[@0,@10,@-10,@10,@0];
//    animation.keyTimes = @[@0,@(1 / 6.0),@(3 / 6.0),@(5 / 6.0),@1];
//    animation.duration = 0.4;
//    animation.additive = YES;
//    [self.redView.layer addAnimation:animation forKey:@"shake"];
//    
    
    // 关键帧动画绕圆转
    CGRect boundingRect = CGRectMake(0,0, 300, 300);
    CAKeyframeAnimation * orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    
    NSLog(@"%@",orbit.path);
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    [self.redView.layer addAnimation:orbit forKey:@"orbit"];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
