//
//  XLDictionary.h
//  链表实现数组和字典
//
//  Created by PingAnXL on 17/6/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLDictionary : NSObject

+ (instancetype)dictionary;

- (void)setValue:(id)value forKey:(NSString *)key;

- (id)valueForKey:(NSString *)key;

@end
