//
//  NSObject+performSelector.m
//  对象发送消息
//
//  Created by PingAnXL on 17/4/24.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "NSObject+performSelector.h"

@implementation NSObject (performSelector)
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
  
    // 创建签名
    NSMethodSignature * signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    // 判断传入的方法是否存在
    if (signature == nil) {
        
        NSString * info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(aSelector)];
    
        @throw [[NSException alloc] initWithName:@"方法没有" reason:info userInfo:nil];
        return nil;
    }

    // 创建NSInvocation对象
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = self;
    invocation.selector = aSelector;
    // 设置参数
    /*
     当前如果直接遍历参数数组来设置参数
     如果参数数组元素多余参数个数，那么就会报错
    
    */
    
    NSInteger arguments = signature.numberOfArguments - 2;
    /*
     如果直接遍历参数的个数，会存在问题
     如果参数的个数大于了参数值的个数，那么数组会越界
     */
    /*
     谁少就遍历谁
     */
    
    NSUInteger objectsCount = objects.count;
    
    NSInteger count = MIN(arguments, objectsCount);
    
    for (int i = 0; i < count; i ++) {
        NSObject * obj = objects[i];
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        [invocation setArgument:&obj atIndex:i + 2];
    }

    // 调用NSinvocation 的对象
    [invocation invoke];
    // 获取返回值
    id res = nil;
    
    //判断当前方法是否有返回值
    //    NSLog(@"methodReturnType = %s",signature.methodReturnType);
    //    NSLog(@"methodReturnTypeLength = %zd",signature.methodReturnLength);

    if (signature.methodReturnLength!=0) {
        [invocation getReturnValue:&res];
    }
    

    return res;

}
@end
