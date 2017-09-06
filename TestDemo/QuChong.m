//
//  QuChong.m
//  面试题demo
//
//  Created by PingAnXL on 17/3/28.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "QuChong.h"

@implementation QuChong
- (void)testType:(typeDeft)type {

    
    switch (type) {
        case typeFirst:
            [self _firstMetod];
            break;
        case typeSecond:
            
            [self _secodeMetod];

            break;
        case typeThird:
            
            [self _secodeMetod];
            break;
        case typeFour:
            [self _fourMetod];
            break;
        case typeFive:
            [self _fourMetod];
            break;
            
        default:
            break;
    }
    
    

}
// 遍历数组
- (void)_firstMetod {

    NSArray * array = @[@"88",@"22",@"33",@"22",@"44",@"22",@"33",@"56"];
    
    NSMutableArray * secodArray = [[NSMutableArray alloc] init];
    
    for (NSString * item in array) {
        
        if (![secodArray containsObject:item]) {
            [secodArray addObject:item];
        }
    }
    
    NSLog(@"111111%@",secodArray);
    

}
// block 的方式
- (void)_secodeMetod {
    
    NSArray * array = @[@"88",@"22",@"33",@"22",@"44",@"22",@"33",@"56"];

     NSMutableArray * array2 = [[NSMutableArray alloc] init];
    
    //__block NSString * item; // 如果block 内部变量想赋值给外部变量的时候 需要加__block 修饰
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![array2 containsObject:obj]) {
            
            [array2 addObject:obj];
        }
        
    }];
    
    NSLog(@"%@",array2);
    
   
}
// 使用kvc 来去重
- (void)_thirdMetod {
    
    NSArray * array = @[@"88",@"22",@"33",@"22",@"44",@"22",@"33",@"56"];
    
    NSMutableArray * array2 = [[NSMutableArray alloc] init];
    
    array2 = [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    NSLog(@"%@",array2);
    

}
// 根据字典的 字典在设置key-value时，若已存在则更新值，若不存在则插入值
- (void)_fourMetod {

    NSArray * array = @[@"88",@"22",@"33",@"22",@"44",@"22",@"33",@"56"];
    
    NSMutableDictionary * resultDict = [[NSMutableDictionary alloc] init];
    /*
     *  setObject：forked：中object是不能够为nil的，不然会报错。
     setValue：forKey：中value能够为nil，但是当value为nil的时候，会自动调用removeObject：forKey方法
     setValue：forKey：中key的参数只能够是NSString类型，而setObject：forKey：的可以是任何类型
     *
     */
    for (NSString * item in array) {
//        [resultDict setValue:item forKey:item];
        [resultDict setObject:item forKey:item];
    }
    NSArray * resultArray = resultDict.allValues;
    NSLog(@"%@",resultArray);

    // 排序
    
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSString * item1 = obj1;
        NSString * item2 = obj2;
        
        return [item1 compare:item2 options:NSCaseInsensitiveSearch];
        
    }];
    
    NSLog(@"排序后的%@",resultArray);
    
    
}
// 使用集合去重
- (void)_fiveMetod {
    NSArray * array = @[@"88",@"22",@"33",@"22",@"44",@"22",@"33",@"56"];
    
    NSOrderedSet * orderSet = [NSOrderedSet orderedSetWithArray:array];
    NSArray * newArray = orderSet.array;
    
    NSLog(@"%@",newArray);
    
    
    

    
}

//- (void)_sixMetod {
//
//    NSArray * array = @[@"88",@"22",@"33",@"22",@"44",@"22",@"33",@"56"];
//
//
//
//}
//




@end
