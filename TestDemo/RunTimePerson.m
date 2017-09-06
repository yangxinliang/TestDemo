//
//  RunTimePerson.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "RunTimePerson.h"
#import <objc/message.h>

@implementation RunTimePerson


void run (id self,SEL _cmd,NSString * string) {
    
    
    
    NSLog(@"我传的字符串是%@",string);
    
    NSLog(@"dadasdasdadsasd");
    
    
}


// 判断类方法
+ (BOOL)resolveClassMethod:(SEL)sel {
    
    
    NSLog(@"我会被打印吗？？？？");
    
    
    
    return NO;
}
// 判断实例方法  可以在这里动态添加没有实现的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    
    NSLog(@"%@",NSStringFromSelector(sel));
    NSLog(@"我是啥时候被调用的11111111");
    
    if (sel == NSSelectorFromString(@"run:")) {
        
        
        class_addMethod(self, sel, (IMP)run, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
    
    //    return NO;
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    //    NSString * selName = NSStringFromSelector(aSelector);
    //
    //    if ([selName hasSuffix:@"Value"]) {
    //        return self.age;
    //    }
    
    
    NSLog(@"我是啥时候被调用的22222222");
    
    return nil;
    
    
}



- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    //    NSMethodSignature * sig = [super methodSignatureForSelector:aSelector];
    //
    //    if (!sig) {
    //
    //        for (id obj in self) {
    //            if ((sig = [obj methodSignatureForSelector:self])) {
    //                break;
    //            }
    //        }
    //
    //    }
    
    NSString * selName = NSStringFromSelector(aSelector);
    
    if ([selName hasSuffix:@"eat"]) {
        
        NSLog(@"我是啥时候被调用的333333333");
        
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    
    //    NSLog(@"我是啥时候被调用的333333333");
    
    return nil;
    
    
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    
    NSString * selName = NSStringFromSelector(anInvocation.selector);
    
    
    
    if ([selName hasSuffix:@"eat"]) {
        
        
        [self play];
        NSLog(@"我啥时候被调用的444444444");
        [anInvocation invokeWithTarget:self.age];
        
        
    }
    
}


- (void)play {
    
    NSLog(@"此方法没有实现");
    
}

//- (void)eat {
//
//    NSLog(@"吃饭");
//}




//#pragma mark - runtime 方法交换
//
//+ (void)load {
//
//    Method eatMethod = class_getInstanceMethod(self, @selector(eat));
//
//    Method playMethod = class_getInstanceMethod(self, @selector(play));
//
//
//    method_exchangeImplementations(eatMethod, playMethod);
//
//
//}
//
//- (void)eat {
//
//    NSLog(@"eat1213213");
//    
//    [self eat];
//}
//- (void)play {
//    NSLog(@"playewqewqe");
//
//}

@end
