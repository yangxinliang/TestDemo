//
//  BlockObject.h
//  高级编程例子
//
//  Created by PingAnXL on 17/4/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^releceRetainBlock)(void);

@interface BlockObject : NSObject
{
    releceRetainBlock blk_;
   
}


- (void)execBlock;
@end
