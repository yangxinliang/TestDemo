//
//  YCalayer.m
//  UIview刷新
//
//  Created by PingAnXL on 17/4/26.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "YCalayer.h"

@interface YCalayer ()<CALayerDelegate>

@end

@implementation YCalayer

- (instancetype)init {

    self = [super init];

    if (self) {
        self.delegate = self;
        
    }
    
    return self;
}
// 如果代理的这个不实现的话 会实现下面的drawInContext方法  这是非正式的协议
//- (void)displayLayer:(CALayer *)layer {
//
//    
//    NSLog(@"%s",__func__);
//    
//}
// 这个方法不重写的话 会实现下面的 drawLayer:(CALayer *)layer inContext:
//- (void)drawInContext:(CGContextRef)ctx {
//
//    NSLog(@"%s",__func__);
//    
//    
//   
//
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"%s",__func__);

//    CGContextSetLineWidth(ctx, 10.0f);
//    
//    CGContextSetStrokeColorWithColor(ctx, [UIColor yellowColor].CGColor);
//    
//    CGContextStrokeEllipseInRect(ctx, layer.bounds);



}


@end
