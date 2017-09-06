//
//  XLArray.h
//  链表实现数组和字典
//
//  Created by PingAnXL on 17/6/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLArray : NSObject

/**  **/
@property (nonatomic, assign) NSUInteger size; // 数组的长度

- (void)addObject:(NSObject *)obj;  // 添加元素

- (void)remove:(NSObject *)obj;    // 移除指定元素

- (void)removeAtIndex:(NSInteger)index;  // 移除指定索引元素

- (NSObject *)objectAtIndex:(NSInteger)index; //获取指定位置的值
+ (instancetype)array; // 初始化数组


@end

@interface Node : NSObject

/**  **/
@property (nonatomic, strong) Node * previous;  // 上个节点

/**  **/
@property (nonatomic, strong) Node * next;  // 下个节点

/**  **/
@property (nonatomic, strong) id  content;  // 当前节点内容





@end
