//
//  Student.m
//  对象发送消息
//
//  Created by PingAnXL on 17/4/24.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)test:(NSString *)argum{


    return argum;
}

- (id)invocationMedthSengMessageWithArgum {
    
    
    
    
    NSMethodSignature * sinNature = [[self class] instanceMethodSignatureForSelector:@selector(send:withContent:)];
    
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sinNature];
    invocation.target = self;
    // invocation 中的方法必须和签名的方法一致
    invocation.selector = @selector(send:withContent:);
    
    /*
     * 第一个参数：需要给指定方法传递的值 第一个参数需要接收一个指针，也就值传递值的时候需要传递地址
     * 第二个参数：需要给指定的方法的第几个参数传值
     *
     */
    NSString * nember = @"11111";
    
    // 注意：设置参数的索引时 不能从0开始，0已经被self 占用， 1 已经被_cmd 占用
    [invocation setArgument:&nember atIndex:2];
    
    NSString * content = @"啊啊啊啊";
    
    [invocation setArgument:&content atIndex:3];
    
    [invocation invoke];
    
    id res = nil;
    if (sinNature.methodReturnLength != 0) {
        
        [invocation getReturnValue:&res];
    }
    
    return res;
    
}



@end
