//
//  XLCarouselViewCell.m
//  UICollection卡片
//
//  Created by PingAnXL on 17/6/19.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "XLCarouselViewCell.h"

@implementation XLCarouselViewCell

- (instancetype)initWithFrame:(CGRect)frame {
   
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor redColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,250,250)];

        [self.contentView addSubview:self.imageView];
    }
    return self;


}

@end
