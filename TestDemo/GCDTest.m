//
//  GCDTest.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "GCDTest.h"

@implementation GCDTest

// 信号量
- (void)semaphoreGCD {
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        
        dispatch_async(queue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [array addObject:[NSNumber numberWithInt:i]];
            
            dispatch_semaphore_signal(semaphore);
            
        });
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        
        long result = dispatch_semaphore_wait(semaphore, time);
        
        if (result == 0) {
            
            NSLog(@"dasda");
        }else{
            
            NSLog(@"done");
            
        }
        
    }
    
    
    
    
}

// dispatch apply 该函数按指定的次数将指定的block 追加到 dispatch queue中
- (void)ApplyGCD {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_apply(10, queue, ^(size_t index) {
    //        NSLog(@"%zu",index);
    //    });
    //    NSLog(@"done");
    
    NSArray * array = @[@"1",@"10",@"3",@"2",@"1"];
    
    // 使用这个函数可以遍历数组
    dispatch_async(queue, ^{
        dispatch_apply([array count], queue, ^(size_t index) {
            
            
            NSLog(@"%zu  %@",index,[array objectAtIndex:index]);
            
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"done");
            
        });
        
        
    });
    
    
    
    
    
    
}

// 多个 Dispatch Queue 结束后处理  可以使用Dispatch Group
- (void)GroupGCD {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"blk0");
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"blk1");
    });
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"blk2");
    });
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"blk3");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        NSLog(@"done");
        
    });
    
    
}

- (void)GCDTimer {
    
    
    //    dispatch_walltime(DISPATCH_TIME_NOW, <#int64_t delta#>)
    // 相对时间
    // 第一种写法
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        NSLog(@"我是三秒后执行的");
        
    });
    
    
    // 第二种写法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"我是三秒后执行的");
        
        
    });
    
    
}

- (void)GCDTest {
    
    
    // 创建一个子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 在这里做一些比较耗时的网络操作 比如网络请求 ， 数据库的读取 AR画像的识别
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /*
             *  只在主线程可以执行的处理 比如处理界面的更新
             *
             */
            
        });
        
    });
    
    
    
    
    
    
}
// perform的
- (void)performTest {
    // 创建一个子线
    [self performSelectorInBackground:@selector(doWork) withObject:nil];
}

- (void)doWork {
    /*
     *   在这里做一些比较耗时的操纵
     */
    [self performSelectorOnMainThread:@selector(doneWork) withObject:nil waitUntilDone:NO];
}

- (void)doneWork {
    /*
     * 主线程执行在这， 比如更新界面等
     */
}

@end
