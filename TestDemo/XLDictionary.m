//
//  XLDictionary.m
//  链表实现数组和字典
//
//  Created by PingAnXL on 17/6/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "XLDictionary.h"
#import "XLArray.h"

@interface KeyValueCache : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) id  value;


@end
@implementation KeyValueCache

+ (instancetype)key:(NSString *)key value:(id)value {

    
    KeyValueCache * model = [[self alloc] init];
    model.key = key;
    model.value = value;
    return model;

}


@end


@interface XLDictionary ()


@end
@implementation XLDictionary
{
   
    XLArray * _keyValues[999];
}

+ (instancetype)dictionary{

    return [[self alloc] init];
}

// 赋值
- (void)setValue:(id)value forKey:(NSString *)key {

    NSUInteger hash = key.hash;
    
    NSUInteger realCode = hash % (sizeof(_keyValues) / 8);
    
    XLArray * linkArr = _keyValues[realCode];
    if (linkArr) {
        
        for (NSInteger index = 0; index < linkArr.size; index ++) {
            
            KeyValueCache * keyValue = (KeyValueCache *)[linkArr objectAtIndex:index];
            
            if ([keyValue.key isEqualToString:key]) {
                keyValue.value = value;
                return;
            }
            
        }
        KeyValueCache * newkeyValue = [KeyValueCache key:key value:value];
        [linkArr addObject:newkeyValue];
    }else {
   
        XLArray * newLinkArray = [XLArray array];
        KeyValueCache * newKeyValue = [KeyValueCache key:key value:value];
        [newLinkArray addObject:newKeyValue];
        _keyValues[realCode]        = newLinkArray;

    
    }
    

}

- (id)valueForKey:(NSString *)key {

    if (!key.length)  return nil;
    NSUInteger hash = key.hash;
    NSUInteger realCode = hash % 999;
    
    XLArray * linkArr = _keyValues[realCode];
    if (linkArr) {
        
        for (NSInteger index = 0; index < linkArr.size; index ++) {
            
            KeyValueCache * keyValue = (KeyValueCache *)[linkArr objectAtIndex:index];
            
            if ([keyValue.key isEqualToString:key]) {
                
                return keyValue.value;
            }
        }
    }
    return nil;
}





@end
