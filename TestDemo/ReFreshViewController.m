//
//  ReFreshViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "ReFreshViewController.h"
#import "TestvView.h"
#import "YCalayer.h"
@interface ReFreshViewController ()<CAAnimationDelegate>
/** view **/
@property (nonatomic, strong) TestvView * xlView;

/** label **/
@property (nonatomic, strong) UILabel * label;

/** Calayer **/
@property (nonatomic, strong) YCalayer * blueCalayer;


/** dsad **/
@property (nonatomic, strong) CALayer * colorLayer;

@end

@implementation ReFreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self configCalayer];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    CGPoint point = [[touches anyObject] locationInView:self.view ];
    
    if ([self.blueCalayer.presentationLayer hitTest:point]) {
        
        self.blueCalayer.backgroundColor = [UIColor yellowColor].CGColor;
        
    }else{
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.blueCalayer.position = point;
        [CATransaction commit];
        
        
    }
    
    
    if ([self.xlView.layer.presentationLayer hitTest:point]) {
        
        self.xlView.backgroundColor = [UIColor yellowColor];
    }else{
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.xlView.layer.position = point;
        [CATransaction commit];
        
        
    }
    
    
    
    
    
}

- (void)configCalayer {
    
    self.blueCalayer = [YCalayer layer];
    self.blueCalayer.frame = CGRectMake(10, 10, 200, 200);
    self.blueCalayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:self.blueCalayer];
    
    [self.blueCalayer display];
    
    self.blueCalayer.cornerRadius = 20;
    self.blueCalayer.borderWidth = 5;
    
    //    UIImage * image = [UIImage imageNamed:@"绑卡图"];
    //    self.blueCalayer.contents = (__bridge id _Nullable)(image.CGImage);
    //    self.blueCalayer.contentsGravity = kCAGravityResizeAspect;
    //    self.blueCalayer.contentsScale = image.scale;
    //    self.blueCalayer.contentsScale = [UIScreen mainScreen].scale;
    
    
    
    
}


// UIView 的一些方法的调用机制
- (void)configUI {
    
    self.xlView = [[TestvView alloc] initWithFrame:CGRectMake(10,80,100,100)];
    self.xlView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.xlView];
    //    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20,200, 40)];
    //    btn.backgroundColor = [UIColor greenColor];
    //    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    
}

- (void)btn {
    
    // setNeedsDisplay 这个方法会调用draw 进行视图重绘  这种方法一般用于绘图
    //    [self.xlView setNeedsDisplay];
    
    //    [self.xlView setNeedsDisplayInRect:CGRectMake(10, 10, 10, 10)];
    
    //单独使用下面这个方法会调用 layoutSubviews  这个方法一般用于数据刷新的
    //    [self.xlView setNeedsLayout];
    // 单独使用这个方法是不会调 layoutSubviews
    [self.xlView layoutIfNeeded];
    // 以上方法两个方法一起调用的时候 也会 调用 layoutSubviews
    
    
}

//
//- (void)viewWillLayoutSubviews {
//
//    NSLog(@"我是控制器的viewWillLayoutSubViews");
//
//}
//
//- (void)viewDidLayoutSubviews {
//
//    NSLog(@"我是控制器的viewDidLayoutSubviews");
//
//
//}


- (void)_bezierPath {
    
    
    UIBezierPath * brzierPath = [[UIBezierPath alloc] init];
    [brzierPath moveToPoint:CGPointMake(0, 150)];
    [brzierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(0, 150) controlPoint2:CGPointMake(20, 150)];
    
    //    [brzierPath addQuadCurveToPoint:CGPointMake(300, 150) controlPoint:CGPointMake(0, 150)];
    
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.path = brzierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    CALayer * shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    
    UIImage * image = [UIImage imageNamed:@"u300"];
    shipLayer.contents = (__bridge id _Nullable)(image.CGImage);
    
    [self.view.layer addSublayer:shipLayer];
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = brzierPath.CGPath;
    [shipLayer addAnimation:animation forKey:nil];
    
}
- (void)anmationDemo {
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame= CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 100, 20)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}
- (void)keyanmationBtn {
    
    //    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //
    //    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //    CABasicAnimation * animation = [CABasicAnimation animation];
    //    animation.keyPath = @"backgroundColor";
    //    animation.toValue = (__bridge id _Nullable)(color.CGColor);
    //
    //    animation.delegate = self;
    //    [self.colorLayer addAnimation:animation forKey:nil];
    
    // 关键祯动画
    
    CAKeyframeAnimation * keyanmation = [CAKeyframeAnimation animation];
    keyanmation.keyPath = @"backgroundColor";
    keyanmation.duration = 2.0;
    keyanmation.values = @[(__bridge id _Nullable)[UIColor blueColor].CGColor,
                           (__bridge id _Nullable)[UIColor redColor].CGColor,
                           (__bridge id _Nullable)[UIColor greenColor].CGColor,
                           (__bridge id _Nullable)[UIColor blueColor].CGColor,
                           
                           ];
    [self.colorLayer addAnimation:keyanmation forKey:nil];
    
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef _Nullable)(anim.toValue);
    [CATransaction commit];
    
    
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
