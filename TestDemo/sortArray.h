//
//  sortArray.h
//  面试题demo
//
//  Created by PingAnXL on 17/3/29.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,sortNrayType){

    sortNrayType1,
    sortNrayType2,
    sortNrayType3,
    sortNrayType4

};

@interface sortArray : NSObject

/** 枚举 **/
@property (nonatomic, assign) sortNrayType sortType;

- (void)sortArray:(sortNrayType)sorType;

@end
