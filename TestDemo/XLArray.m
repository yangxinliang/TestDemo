//
//  XLArray.m
//  链表实现数组和字典
//
//  Created by PingAnXL on 17/6/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "XLArray.h"

@interface XLArray ()

/** <#注释#> **/
@property (nonatomic, strong) Node * first;  // 首个节点

/**  **/
@property (nonatomic, strong) Node * last;  // 最后节点

@end

@implementation XLArray


- (void)addObject:(NSObject *)obj {
 
    if (!obj) return;
    _size ++;
    Node * node = [[Node alloc] init];
    if (!_first) {
        _first = node;
        _last = node;
        node.previous = nil;
        node.next = nil;
        node.content = obj;
        return;
    }
  // 数组中 有值
    
    node.previous = _last;
    node.next = nil;
    node.content = obj;
    _last = node;
    _last.next = node;

}

// 移除元素
- (void)remove:(NSObject *)obj {
  
    if (!obj || !_size)  return;
    
    Node * tmpNode = _first;
    for (NSInteger index = 0; index < _size; index ++) {
        
        if ([tmpNode.content isEqual:obj]) {
    
            [self _removeNode:tmpNode];
            break;
        }
    }
    
}
// 根据索引移除元素
- (void)removeAtIndex:(NSInteger)index {
   
    if (index < 0 || index >= _size)  return;
    
    Node * temNode = _first;
    for (NSInteger i = 0; i < _size; i ++) {
        
        
        if (i == index) {
            [self _removeNode:temNode]; // 移除节点
            break;
        }
        
        temNode = temNode.next;
        
    }

}

// 获取指定索引元素

- (NSObject *)objectAtIndex:(NSInteger)index {
    if (index < 0 || index >= _size) return nil;
    
    Node * tmpNode = _first;
    for (NSInteger i = 0; i < _size; i ++) {
        
        if (i == index) {
            
            return tmpNode.content;
        }
        
        tmpNode = tmpNode.next;
    }

    return nil;
}



- (void)_removeNode:(Node *)node {
  
    // 连接上下节点
    
    Node * preNode = node.previous;
    Node * nextNode = node.next;
    preNode.next = nextNode;
    nextNode.previous = preNode;
    node.content = nil; // 清空被移除节点内容
    
    _size --;

}

+ (instancetype)array {

    return [[self alloc] init];

}


@end


@implementation Node



@end
