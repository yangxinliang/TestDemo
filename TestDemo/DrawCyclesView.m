//
//  DrawCyclesView.m
//  TestDemo
//
//  Created by PingAnXL on 2017/9/4.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "DrawCyclesView.h"

#define kBordeeWith 20

@implementation DrawCyclesView

- (void)drawRect:(CGRect)rect {
    
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat width = rect.size.width;
    
    CGRect frame = CGRectMake(kBordeeWith + width / 4, kBordeeWith + width / 4, rect.size.width - kBordeeWith * 2 - width / 2, rect.size.height - kBordeeWith * 2 - width / 2);
    // 填充当前绘画区域内的颜色
    [[UIColor whiteColor] set];
    // 填充当前矩形区域
    CGContextFillRect(ctx, rect);
    
    CGContextAddEllipseInRect(ctx, frame);
    
    [[UIColor orangeColor] set];
    
    CGContextFillPath(ctx);
    
//    CGPathRelease(ctx);
    
    
}

@end
