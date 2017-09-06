//
//  NSObject+performSelector.h
//  对象发送消息
//
//  Created by PingAnXL on 17/4/24.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (performSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

@end
