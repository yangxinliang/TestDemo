//
//  YXLDrawView.m
//  TouchTracker
//
//  Created by PingAnXL on 17/4/11.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "YXLDrawView.h"
#import "YXLLine.h"

@interface YXLDrawView ()

/** dsada **/
@property (nonatomic, strong) YXLLine * currentLine;

@property (nonatomic,strong) NSMutableArray * finishedLines;

/** dasdas **/
@property (nonatomic, strong) UIView * redView;



@end

@implementation YXLDrawView

-(instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
      
        self.finishedLines = [NSMutableArray array];
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 40, 40)];
        self.redView.backgroundColor = [UIColor redColor];
        [self addSubview:self.redView];
        
        
    }

    return self;
}

- (void)drawRect:(CGRect)rect {

//    [[UIColor blackColor] set];
//    for (YXLLine * line in self.finishedLines) {
//        
//        [self strokeLine:line];
//    }
//    if (self.currentLine) {
//        
//        [[UIColor redColor] set];
//        
//        [self strokeLine:self.currentLine];
//        
//    }
    
  
  
    
    
    
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
//    UITouch * touch = [touches anyObject];
//    
//    CGPoint location = [touch locationInView:self];
//
//    self.currentLine = [[YXLLine alloc] init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;

//    [self setNeedsDisplay];
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
//    NSLog(@"%@",NSStringFromCGRect(self.redView.frame));
    
    if (CGRectContainsPoint(self.redView.frame, location)) {
        
        NSLog(@"我在点击的内容中%@",NSStringFromCGPoint(location));
        
    }


}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
//    self.currentLine.end = location;
    CGRect rect = CGRectMake(location.x, 0, 1, self.frame.size.height);
    
    // 这个方法会立即调用  draw 方法 进行视图重绘  setNeedsLayout 会调用 会默认调用layoutSubViews，就可以
//    [self setNeedsDisplayInRect:rect];
    
    
    
//    [self test:rect];

    
    

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    [self.finishedLines addObject:self.currentLine];
//    [self setNeedsDisplay];

  
    self.currentLine.frame = CGRectMake(0, 0, 0, 0);
    
    
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:( UIEvent *)event {



}

- (void)test:(CGRect)rect {
  

    
    
//    YXLLine * line = [[YXLLine alloc] initWithFrame:rect];
    
    self.currentLine.frame = rect;
//    line.backgroundColor = [UIColor redColor];
//    [self addSubview:line];


}

- (YXLLine *)currentLine{

    if (!_currentLine) {
        
        _currentLine = [[YXLLine alloc] init];
        
        _currentLine.backgroundColor = [UIColor redColor];
        
        [self addSubview:_currentLine];
        
    }
    
    
    return _currentLine;
}




@end
