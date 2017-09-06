//
//  YXLView.h
//  TouchTracker
//
//  Created by PingAnXL on 17/4/11.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface YXLView : UIView

/** block 代码 **/
@property (nonatomic, copy) void (^actionBlock)(void);

/** 带参数的block **/
@property (nonatomic, copy)  void (^canshuBlock)(NSString * str);

/** 带参数和带返回值的block **/
@property (nonatomic, copy) int (^fanhuizhiBlock)(NSString * str);


@end
