//
//  ForWordController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "ForWordController.h"
#import "NSObject+performSelector.h"
#import "Person.h"

#import <objc/message.h>
@interface ForWordController ()

@end

@implementation ForWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    NSObject * p = [[NSObject alloc] init];
    // 下面的可以代表  [[Person alloc] init];
    /* objc_msgSend 前半部分表示传的参数类型  id (*)  表示返回值的类型  objc_msgSend 后半部分和前半部分是一一对应的
     *
     */
    // 1.创建对象
    NSObject * p1 =  ((NSObject * (*)(id,SEL))objc_msgSend)((id)[NSObject class],@selector(alloc));
    // 2.初始化对象
    p1 =  ((NSObject *(*)(id, SEL))objc_msgSend)((id)p1,@selector(init));
    


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // performSelector 方法
    //    [self invocationMedthSengMessage];
    // 使用 NSInvocation 和 NSMethodSignature 可以使performSelector 传多个值
    [self performSelector:@selector(call:withString:) withObjects:@[@"dsad",@"dsadsa"]];


}


- (void)call:(NSString *)str withString:(NSString *)str2{
    
    NSLog(@"%@ %@",str,str2);
    
}

- (void)call:(NSString *)str{
    
    NSLog(@"%@",str);
    
}

// 第一种方法  直接调用某个对象的消息方式
- (void)instaceMedtod {
    
    [self performSelector:@selector(send) withObject:nil afterDelay:1];
    
}
- (void)send {
    
    
    NSLog(@"我被调用了 %@",[NSThread currentThread]);
    
}

// 第二种方法 使用NSInvocation

- (void)invocationMedthSengMessage {
    
    
    NSMethodSignature * sinNature = [ForWordController instanceMethodSignatureForSelector:@selector(send:withContent:)];
    
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
    
    
}

// 这个有返回信息的函数
- (id)invocationMedthSengMessageWithArgum {
    
    
    NSMethodSignature * sinNature = [ForWordController instanceMethodSignatureForSelector:@selector(send:withContent:)];
    
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
    
    // 下面这个判断函数是否有返回值 有返回值 就把获取到函数的返回值
    id res = nil;
    if (sinNature.methodReturnLength != 0) {
        
        [invocation getReturnValue:&res];
    }
    
    return res;
    
}

// 实现的方法
- (id)send:(NSString *)number withContent:(NSString *)content {
    
    
    //    NSLog(@"电话号码是%@电话的内容是%@",number,content);
    
    NSString * str = @"dasdas";
    
    return str;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
