//
//  ButtonCallbackObject.m
//  高级编程例子
//
//  Created by PingAnXL on 17/4/19.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "ButtonCallbackObject.h"

@implementation ButtonCallbackObject

+ (void)buttonCallBackObject:(NSString *)str callBlock:(void (^)(NSString *str1))callBlock {

   
    NSString * str1 = nil;
    
    if ([str isEqualToString:@"wo"]) {
        
        
        str1 = str;
        
        
        callBlock(str1);
    }
    
    


}



@end
