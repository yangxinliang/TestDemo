//
//  QuChong.h
//  面试题demo
//
//  Created by PingAnXL on 17/3/28.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

/**
 这个类主要写数组去重的几种方法
 */
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,typeDeft){

    typeFirst,
    typeSecond,
    typeThird,
    typeFour,
    typeFive
};

@interface QuChong : NSObject

/** dasda **/
@property (nonatomic, assign) typeDeft type;

- (void)testType:(typeDeft)type;



@end
