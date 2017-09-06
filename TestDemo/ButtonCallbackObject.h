//
//  ButtonCallbackObject.h
//  高级编程例子
//
//  Created by PingAnXL on 17/4/19.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonCallbackObject : NSObject


+ (void)buttonCallBackObject:(NSString *)str callBlock:(void(^)(NSString * str1))callBlock;

@end
