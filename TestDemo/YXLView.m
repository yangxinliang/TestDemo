//
//  YXLView.m
//  TouchTracker
//
//  Created by PingAnXL on 17/4/11.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "YXLView.h"
#import "YXLLine.h"


@interface YXLView ()


@property (nonatomic, strong) NSMutableDictionary * linesInProgress;

/**  **/
@property (nonatomic, strong) NSMutableArray * yxlFinisheLines;

/**  **/
@property (nonatomic, weak) YXLLine * selectedLine;
@end

@implementation YXLView

- (instancetype)initWithFrame:(CGRect)frame {

    
//    @throw  [NSException exceptionWithName:@"YXLView" reason:@"初始化失败" userInfo:nil];
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.yxlFinisheLines = [NSMutableArray array];
        self.multipleTouchEnabled = YES;
        
        
        // 双击清除
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.delaysTouchesBegan = YES;
        doubleTap.numberOfTapsRequired = 2;
//        [tap requireGestureRecognizerToFail:];
        
        [self addGestureRecognizer:doubleTap];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [tap requireGestureRecognizerToFail:doubleTap];
        
        tap.delaysTouchesBegan = YES;
        [self addGestureRecognizer:tap];
        
        NSString  * str = @"";
        
        
    }
    return self;


}
// 双击的点击事件
- (void)doubleTap:(UITapGestureRecognizer *)tap {
   
    [self.yxlFinisheLines removeAllObjects];
    [self.linesInProgress removeAllObjects];
    
    [self setNeedsDisplay];

}
// 单击的点击事件
- (void)tap:(UITapGestureRecognizer *)tap {


    CGPoint point = [tap locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    [self setNeedsDisplay];

}

- (void)drawRect:(CGRect)rect {
    
    [[UIColor blackColor] set];
    for (YXLLine * line in self.yxlFinisheLines) {
        
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];

    for (NSValue * value in self.linesInProgress) {
        
        [self strokeLine:self.linesInProgress[value]];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor] set];
    
        [self strokeLine:self.selectedLine];
    }
    
    
    
}

- (YXLLine *)lineAtPoint:(CGPoint)p {

    for (YXLLine * line in self.yxlFinisheLines) {
        CGPoint start = line.begin;
        CGPoint end = line.end;
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.x);
            
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return line;
            }
        }
    }
    return nil;
}

- (void)strokeLine:(YXLLine *)line {
    
    UIBezierPath * bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    
    [bp stroke];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    for (UITouch * touch in touches) {
        
        CGPoint location = [touch locationInView:self];
        
        YXLLine * line = [[YXLLine alloc] init];
        line.begin = location;
        line.end = location;
        
        
        NSValue * value = [NSValue valueWithNonretainedObject:touch];

        self.linesInProgress[value] = line;
            
        
    }
    
    
    
    
    
 //   UITouch * touch = [touches anyObject];
 //   CGPoint location = [touch locationInView:self];
//    self.currentLine = [[YXLLine alloc] init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;
//    
    [self setNeedsDisplay];
    
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));

    
    
    
    for (UITouch * touch in touches) {
        
        NSValue * value = [NSValue valueWithNonretainedObject:touch];
        YXLLine * line = self.linesInProgress[value];
        line.end = [touch locationInView:self];
        
    }
    
    
//    UITouch * touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self];
//    self.currentLine.end = location;
    // 这个方法会立即调用  draw 方法 进行视图重绘  setNeedsLayout 会调用 会默认调用layoutSubViews，就可以
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    NSLog(@"%@",NSStringFromSelector(_cmd));

//    [self.finishedLines addObject:self.currentLine];
    
    for (UITouch * touch in touches) {
        
        NSValue * value = [NSValue valueWithNonretainedObject:touch];
        
        YXLLine * line = self.linesInProgress[value];
        
        [self.yxlFinisheLines addObject:line];
        
        [self.linesInProgress removeObjectForKey:value];
        
    }
 
    
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


    for (UITouch * touch in touches) {
        
        NSValue * value = [NSValue valueWithNonretainedObject:touch];
        [self.linesInProgress removeObjectForKey:value];
        
    }
    [self setNeedsDisplay];

}



@end
