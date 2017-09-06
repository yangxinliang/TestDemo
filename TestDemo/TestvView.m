//
//  TestvView.m
//  UIview刷新
//
//  Created by PingAnXL on 17/4/10.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "TestvView.h"

@implementation TestvView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        NSLog(@"初始化的方法");
    }
    
    return self;
}

// 这个方法在以下的几种情况下会被调用
/*

 1.init 初始化不会触发layoutSubviews  但是使用initWithFrame 进行初始化的时候，当rect 的值不为 CGRectZero
 也会触发
 2. addsSubview 会触发 layoutSubviews
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 
 4、滚动一个UIScrollView会触发layoutSubviews
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 
 */
- (void)layoutSubviews {

    
    
    NSLog(@"layoutSubviews");


}


// 这个方法 标记为需要局部重绘
- (void)setNeedsDisplayInRect:(CGRect)rect {

    NSLog(@"%@",NSStringFromCGRect(rect));


}

- (void)drawRect:(CGRect)rect {
    
    NSLog(@"我是 rect");
 
}


#pragma mark - view的子视图 加载到当前view的 方法调用 或者从当前view 移除时方法调用

//- (void)didAddSubview:(UIView *)subview {
//    
//    NSLog(@"didAddSubview");
//}
//
//- (void)willRemoveSubview:(UIView *)subview {
//    NSLog(@"willRemoveSubview");
//
//    
//}

#pragma mark - view 加载到父视图 方法调用 或者 view 从父视图移除方法调用


//- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
//    
//    NSLog(@"willMoveToSuperview");
//
//    
//}
//
//- (void)didMoveToSuperview {
//    
//    NSLog(@"didMoveToSuperview");
//
//    
//}
//
//- (void)willMoveToWindow:(UIWindow *)newWindow {
//    NSLog(@"willMoveToWindow");
//
//    
//}
//
//- (void)didMoveToWindow {
//    
//    NSLog(@"didMoveToWindow");
//
//}


@end
