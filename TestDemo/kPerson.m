//
//  kPerson.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "kPerson.h"

@implementation kPerson
// retain  重写setter  方法
- (void)setName:(NSString *)name {
    
    if (name) {
        
        [_name release];
        [name retain];
        _name = name;
        
    }
    
    
}
// copy 重写Setter 方法
- (void)setNewName:(NSString *)YXLName {
    
    
    id str = [YXLName copy];
    
    [_YXLName release];
    
    _YXLName = str;
    
}


@end
