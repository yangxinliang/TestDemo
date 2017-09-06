//
//  Person.m
//  对象发送消息
//
//  Created by PingAnXL on 17/4/24.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "Person.h"
#import "Student.h"
@implementation Person

+ (BOOL)resolveInstanceMethod:(SEL)sel {

    NSLog(@"1号接盘侠");
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {

    NSLog(@"2 号接盘侠");
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {

    NSLog(@"3 号接盘侠");

    NSMethodSignature * signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    
    
    if (signature == nil) {
        
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }


    return signature;
}
// 本类方法没实现的转发到其他的类去实现
- (void)forwardInvocation:(NSInvocation *)anInvocation {

    NSLog(@"4 号接盘侠");
    Student * st = [[Student alloc] init];
    SEL sel = anInvocation.selector;
    
    if ([st respondsToSelector:sel]) {
        
        [anInvocation invokeWithTarget:st];
    }else{
    
        [self doesNotRecognizeSelector:sel];
    }
 

}



@end
