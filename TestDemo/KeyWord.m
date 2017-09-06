//
//  KeyWord.m
//  面试题demo
//
//  Created by PingAnXL on 17/3/28.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "KeyWord.h"

//extern 的使用

NSString * Yannik = @"yangxinliang";

@implementation KeyWord

+ (void)test {

 // const 的使用 以下两个 *p1 *p2 是可读 不能写 p1 p2 是变量 可以赋值
    const NSString * p1 = @"dasdas";
    NSString const * p2 = @"dasdasda";
    
    p1 = @"eeeeedd";
    p2 = @"ddffff";
    NSLog(@"%@%@",p1,p2);
    
   // p3 p4 p5 只能读 不能赋值
    NSString * const p3 = @"kkkkkk";
    
    const NSString * const p4 = @"vvvvvv";

    NSString const * const p5 = @"ooooo";
    
//    p3 = @"1232131";  // 会报错
//    p4 = @"0878";
//    p5 = @"09899uyu98";
    
    // const 也可以和 static 一起使用  p6 不能修改只能读 p7 可以修改
    
    static NSString * const p6 = @"23123123";
    static NSString const * p7 = @",mnhjkldasdas";
    
    NSLog(@"%@%@%@%@%@",p3,p4,p5,p6,p7);

    
   // extern
    
//    extern 简介：可释义为“外部”的意思。
//    extern 作用：只是用来声明外部全局变量，注意 extern 只能声明，不能用于定义。
//    extern 工作原理：先在当前文件查找有没有全局变量，没有找到，才会去其他文件查找。
    
    
    
}


@end
