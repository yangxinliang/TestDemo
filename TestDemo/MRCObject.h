//
//  MRCObject.h
//  高级编程例子
//
//  Created by PingAnXL on 17/4/18.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCObject : NSObject

- (void)print;

// 生成的对象自持有 因为以 alloc 开头
- (id)allocObjct;

// 手动实现自己生成持有对象 
- (id)objct;

@end
