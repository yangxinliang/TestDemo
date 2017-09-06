//
//  NSObject+KVO.h
//  KVO实现原理
//
//  Created by PingAnXL on 17/4/28.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YXObsevingBlock)(id observedObject, NSString * observedKey,id oldValue,id newValue);

@interface NSObject (KVO)

- (void)YX_addObserver:(NSObject *)observer foKey:(NSString *)key withBlock:(YXObsevingBlock)block;

- (void)YX_removeObserver:(NSObject *)observer foKey:(NSString *)key;


@end
