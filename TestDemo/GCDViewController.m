//
//  GCDViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    
    [self testadadad];
    
    
    
    
    
}
- (void)testadadad {
    
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 100; i ++) {
        
        dispatch_async(queue, ^{
            //            for (int i = 0; i < 2; ++i) {
            //                NSLog(@"1------%@",[NSThread currentThread]);
            //            }
            NSLog(@"%@",[NSThread currentThread]);
            
            NSLog(@"2223r");
        });
    }
    
    
    //    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    //
    //    [queue setMaxConcurrentOperationCount:10000];
    //
    //    NSInvocationOperation * op  = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testqaaaa) object:nil];
    //
    //    [queue addOperation:op];
    
    
}


- (void)testqaaaa {
    
    
    NSLog(@"ddddd");
    
    
    
}

//dispatch_barrier_asyns 相当于一个锁
- (void)testdispatchBarrier {
    
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_async(queue, ^{
        
        NSLog(@"111111");
    });
    dispatch_async(queue, ^{
        
        sleep(4);
        NSLog(@"22222");
    });
    
    
    dispatch_barrier_async(queue, ^{
        
        NSLog(@"333333");
    });
    
    
    dispatch_async(queue, ^{
        
        NSLog(@"写一些文件");
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"555555");
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"6666666");
    });
    
    
    
}




// 使用dispatch enter ()和dispatch leaver
- (void)testEnterGroup {
    
    
    
    
    dispatch_group_t group = dispatch_group_create();
    // 如果不考虑任务的执行顺序话  可以 使用并行队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    // 如果3个子任务是按顺序执行的话 可以使用串行队列
    dispatch_queue_t selfQueue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    
    
    /*
     dispatch_group_async(group, globalQueue, ^{
     
     sleep(10);
     
     
     NSLog(@"任务11111");
     
     });
     
     dispatch_group_async(group, globalQueue, ^{
     
     NSLog(@"任务222222");
     
     });
     
     dispatch_group_async(group, globalQueue, ^{
     
     NSLog(@"任务33333");
     
     
     });
     
     // 如果前面三个任务是网络请求的话  在发出网络请求的时候 就执行完了 并不会等待回调 这对于多个网络请求是不满足请求的  需要在前面加上dispatch enter 和 dispatch leaver
     dispatch_group_notify(group, dispatch_get_main_queue(), ^{
     
     
     NSLog(@"%@任务都结束",[NSThread currentThread]);
     
     
     });
     */
    
    // 配合dispatch enter 和dispatch leaver
    
    
    dispatch_group_enter(group);
    dispatch_group_async(group, selfQueue, ^{
        
        sleep(10);
        
        if (1) {
            
            // 请求成功完成或者请求失败结束后都需要加
            dispatch_group_leave(group);
        }
        
        NSLog(@"任务11111");
        
    });
    
    
    dispatch_group_enter(group);
    dispatch_group_async(group, selfQueue, ^{
        
        if (1) {
            
            // 请求成功完成或者请求失败结束后都需要加
            dispatch_group_leave(group);
        }
        
        NSLog(@"任务222222");
        
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, selfQueue, ^{
        
        if (1) {
            
            // 请求成功完成或者请求失败结束后都需要加
            dispatch_group_leave(group);
        }
        
        NSLog(@"任务33333");
        
        
    });
    
    //dispatch enter 和 dispatch leaver
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        
        NSLog(@"%@任务都结束",[NSThread currentThread]);
        
        
    });
    
    
    
    
    
    
    
}

// 按顺序下载图片   为照片打水印  上传处理好的图片
- (void)testOperation {
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    
    NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"下载图片");
        
        dispatch_semaphore_signal(semaphore);
        
    }];
    
    
    
    NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"打水印");
        dispatch_semaphore_signal(semaphore);
        
        
    }];
    
    
    NSBlockOperation * operation3 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"上传图片");
        
        dispatch_semaphore_signal(semaphore);
        
        
    }];
    
    
    // 设置依赖
    [operation2 addDependency:operation1];
    
    [operation3 addDependency:operation2];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    
    [queue addOperations:@[operation1,operation2,operation3] waitUntilFinished:NO];
    
    
    
    
    
    
}



- (void)testXinHaoliang {
    
    
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    
    dispatch_async(queue, ^{
        
        NSLog(@"我执行了吗");
        //          dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //          NSLog(@"11111信号量%ld", dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER));
        
        
        NSLog(@"任务开始======11111");
        sleep(2);
        NSLog(@"任务结束======111111");
        
        dispatch_semaphore_signal(semaphore);
        NSLog(@"111111dispatch_semaphore_signal信号量%ld",  dispatch_semaphore_signal(semaphore));
        
        
        
    });
    
    
    dispatch_async(queue, ^{
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"222222dispatch_semaphore_wait信号量%ld", dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER));
        
        NSLog(@"任务开始=====222222");
        
        sleep(2);
        
        
        NSLog(@"任务结束======22222");
        
        dispatch_semaphore_signal(semaphore);
        NSLog(@"22222222dispatch_semaphore_signal信号量%ld",  dispatch_semaphore_signal(semaphore));
        
        
        
        
    });
    
    
    dispatch_async(queue, ^{
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"3333333dispatch_semaphore_wait信号量%ld", dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER));
        
        NSLog(@"任务开始===33333333");
        
        sleep(2);
        
        
        NSLog(@"任务结束 ====33333333");
        
        dispatch_semaphore_signal(semaphore);
        NSLog(@"333333dispatch_semaphore_signal信号量%ld",  dispatch_semaphore_signal(semaphore));
        
        
        
        
    });
    
    
    dispatch_async(queue, ^{
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"4444444dispatch_semaphore_wait信号量%ld", dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER));
        
        
        NSLog(@"任务开始=====444444");
        
        
        sleep(10);
        
        NSLog(@"任务结束=====444444");
        
        dispatch_semaphore_signal(semaphore);
        NSLog(@"444444dispatch_semaphore_signal信号量%ld",  dispatch_semaphore_signal(semaphore));
        
        
        
        
    });
    
    
    dispatch_async(queue, ^{
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"555555dispatch_semaphore_wait信号量%ld", dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER));
        
        NSLog(@"任务开始=====555555");
        
        sleep(2);
        
        
        NSLog(@"任务结束=====555555");
        
        dispatch_semaphore_signal(semaphore);
        
        
        NSLog(@"555555dispatch_semaphore_signal信号量%ld",  dispatch_semaphore_signal(semaphore));
        
        
    });
    
    
    
    
    
}
//GCD：假设有8个异步线程，如何先并发三个，再执行一个，再并发后面4个。
- (void)testGCDQQQQQ {
    
    
    
    dispatch_queue_t   serQueue = dispatch_queue_create("serQueeue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t  concuretqueue = dispatch_queue_create("com.yxxl", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_semaphore_t seme = dispatch_semaphore_create(0);
    
    
    __block int conut = 3;
    dispatch_group_async(group,serQueue, ^{
        
        dispatch_async(concuretqueue, ^{
            
            [NSThread sleepForTimeInterval:1];
            
            NSLog(@"-----------1");
            
            conut --;
            
            if (conut == 0) {
                dispatch_semaphore_signal(seme);
                
            }
            
        });
        
        dispatch_async(concuretqueue, ^{
            
            NSLog(@"----------2");
            conut --;
            if (conut == 0) {
                dispatch_semaphore_signal(seme);
                
            }
            
        });
        
        dispatch_async(concuretqueue, ^{
            
            NSLog(@"----------3");
            
            conut --;
            
            if (conut == 0) {
                dispatch_semaphore_signal(seme);
                
            }
            
        });
        
        dispatch_semaphore_wait(seme, DISPATCH_TIME_FOREVER);
        
        
    });
    
    
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_async(concuretqueue, ^{
        
        NSLog(@"---------4");
        
        dispatch_semaphore_signal(seme);
        
        
    });
    dispatch_semaphore_wait(seme, DISPATCH_TIME_FOREVER);
    
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_async(group, serQueue, ^{
        
        
        dispatch_async(concuretqueue, ^{
            
            [NSThread sleepForTimeInterval:0.5];
            
            NSLog(@"-----------5");
            
            
            
        });
        
        dispatch_async(concuretqueue, ^{
            
            NSLog(@"----------6");
            
            
        });
        
        dispatch_async(concuretqueue, ^{
            
            NSLog(@"----------7");
            
        });
        
        dispatch_async(concuretqueue, ^{
            
            NSLog(@"----------8");
            
        });
        
        
        
    });
    
    
    
    
    
    
    //    dispatch_async(queue, ^{
    //
    //        NSLog(@"444444%@",[NSThread currentThread]);
    //
    //
    //    });
    //    dispatch_async(queue, ^{
    //
    //        NSLog(@"5555555%@",[NSThread currentThread]);
    //
    //
    //    });
    //    dispatch_async(queue, ^{
    //
    //        NSLog(@"66666666%@",[NSThread currentThread]);
    //
    //
    //    });
    //    dispatch_async(queue, ^{
    //
    //        NSLog(@"777777777%@",[NSThread currentThread]);
    //
    //
    //    });
    //    dispatch_async(queue, ^{
    //
    //        NSLog(@"888888888%@",[NSThread currentThread]);
    //
    //
    //    });
    //
    
    
    
    
    
}


- (void)testGroup {
    
    
    dispatch_queue_t queue = dispatch_queue_create("dasdasda", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"任务1");
    });
    dispatch_group_async(group, queue, ^{
        
        [NSThread sleepForTimeInterval:10];
        NSLog(@"任务2");
    });
    
    
    dispatch_barrier_async(queue, ^{
        
        
        NSLog(@"wwwwwww任务3");
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"任务3");
    });
    
    dispatch_group_async(group, queue, ^{
        
        
        NSLog(@"任务4");
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"任务5");
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"任务6");
    });
    
    
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        NSLog(@"%@",[NSThread currentThread]);
        
        NSLog(@"任务7");
        
    });
    
    
    NSLog(@"ds");
    
    
}

- (void)test {
    
    
    dispatch_queue_t queue = dispatch_queue_create("dasdasda", DISPATCH_QUEUE_SERIAL);
    //    dispatch_queue_t queue = dispatch_queue_create("dasdasda", DISPATCH_QUEUE_CONCURRENT);
    
    
    
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        
        sleep(10);
        
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        
        NSLog(@"2");
        
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        
        NSLog(@"3");
        
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        
        NSLog(@"4");
        
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        
        NSLog(@"5");
        
    });
    
    
    
    //  dispatch_async(dispatch_get_main_queue(), ^{
    //
    //      NSLog(@"完成了");
    //
    //
    //  });
    
}

#pragma mark - 死锁的场景

/**
 主线程调用主线程
 */
- (void)deadLockCaseOne {
    
    NSLog(@"任务1");
    
    //    dispatch_sync(dispatch_get_main_queue(), ^{
    //
    //        NSLog(@"任务2");
    //
    //    });
    //    NSLog(@"任务3");
    
    // 对于这种情况 以下修改方案 异步执行
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        NSLog(@"任务2");
    //    });
    //
    //    NSLog(@"任务3");
    
    // 不在主线程中运行，二是放在子线程中执行
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务2");
        
        
    });
    NSLog(@"任务3");
    
}


/**
 同步串行队列嵌套自己
 */
- (void)deadLockCaseTwo {
    
    
    dispatch_queue_t aSerialQueue = dispatch_queue_create("dasdasdasdasd", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"任务1");
    
    dispatch_sync(aSerialQueue, ^{
        
        NSLog(@"任务2");
        dispatch_sync(aSerialQueue, ^{
            
            NSLog(@"任务3");
            
        });
        
        NSLog(@"任务4");
        
    });
    NSLog(@"任务5");
    
    // 将第二个GCD 改为异步执行  但是将第一个GCD 改为异步就不能解决问题了
    // 将以上两个GCD 都改为异步执行
    // 可以使用不同的串行队列
    
    
}


/**
 信号量阻塞主线程
 */
- (void)deadLockCaseThree {
    
    
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //    NSLog(@"semaphore create!");
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        dispatch_semaphore_signal(semaphore);
    //        NSLog(@"semaphore plus 1");
    //    });
    //    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //    NSLog(@"semaphore minus 1");
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"semaphore create!");
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(semaphore);
            NSLog(@"semaphore plus 1");
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"semaphore minus 1");
        
        
        
        
        
        
    });
    
    
    
}






#pragma mark - GCD的使用

- (void)concurrentGCD {
    
    dispatch_queue_t queue = dispatch_queue_create("qwertyui", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"我是A%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"我是B%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"我是C%@",[NSThread currentThread]);
        
    });
    
    
}

//
- (void)serialGCD {
    
    
    dispatch_queue_t queue = dispatch_queue_create("qwertyui", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        NSLog(@"我是A%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"我是B%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"我是C%@",[NSThread currentThread]);
        
    });
    
    
}

// 造成死锁

- (void)deildLock {
    
    //    dispatch_sync(dispatch_get_main_queue(), ^{
    //
    //        NSLog(@"11111");
    //
    //    });
    //
    //    NSLog(@"222");
    
    
    //    dispatch_queue_t queue = dispatch_queue_create("abcdasdasdsadsad", DISPATCH_QUEUE_SERIAL);
    //
    //    dispatch_sync(queue, ^{
    //
    //        NSLog(@"111111");
    //
    //
    ////        dispatch_sync(queue, ^{
    ////
    ////            NSLog(@"1111");
    ////
    ////        });
    //
    //    });
    //
    
    
    
    
}

// dispatch_apply

- (void)dispatchApply {
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(10, queue, ^(size_t index) {
        
        
        NSLog(@"%ld",index);
        
        
    });
    
    NSLog(@"done");
    
    
    
}


// dispatch_enter 和 dispatch_leave
- (void)enterWithLeave {
    
    
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSLog(@"异步执行A");
        
        dispatch_group_leave(group);
        
    });
    dispatch_group_enter(group);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSLog(@"这里是异步执行B");
        
        dispatch_group_leave(group);
        
    });
    
    
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        
        
        NSLog(@"wwwwwww");
        
    });
    
    
    
    
}


// dispatch Group
- (void)dispatchGroup {
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //    dispatch_queue_t queue = d
    
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"我是A");
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"我是B");
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"我是C");
    });
    
    
    //    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    
    NSLog(@"都完成了");
    
    
    //    });
    
}



// GCD 延迟加载
- (void)afterGCD {
    
    //dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC);
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        NSLog(@"我延迟了几秒");
        
        
    });
    
}


// GCD  队列
- (void)queueGCD {
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSLog(@"这里做的好像是耗时操作");
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            NSLog(@"回到主线程刷新UI ");
            
        });
        
    });
    
    
}




#pragma mark - 创建信号量

- (void)creatGcd {
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"我想执行的第一个任务");
        
        
        dispatch_semaphore_signal(semaphore);
        
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"我想执行的第二个任务");
        
        dispatch_semaphore_signal(semaphore);
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"我想执行的第三个任务");
        
        dispatch_semaphore_signal(semaphore);
    });
    
    
    dispatch_group_notify(group, queue, ^{
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"我想执行的任务全部完成");
        
        
    });
    
    
    
    
    //    dispatch_semaphore_t semaphore2 = dispatch_semaphore_create(1);
    //
    //    dispatch_queue_t queue2 = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //
    //    dispatch_group_t group2 = dispatch_group_create();
    //
    //
    //    dispatch_group_async(group2, queue2, ^{
    //
    //
    //        NSLog(@"我是A2");
    //
    //        dispatch_semaphore_signal(semaphore2);
    //
    //    });
    //
    //    dispatch_group_async(group2, queue2, ^{
    //
    //        NSLog(@"我是B2");
    //        dispatch_semaphore_signal(semaphore2);
    //    });
    //
    //
    //    dispatch_group_notify(group2, queue2, ^{
    //
    //        dispatch_semaphore_wait(semaphore2, DISPATCH_TIME_FOREVER);
    //
    //        dispatch_semaphore_wait(semaphore2, DISPATCH_TIME_FOREVER);
    //        
    //        NSLog(@"A2 B2 全部执行完毕");
    //    });
    //    
    //    
    
}




- (void)testSemaphore {
    
    
    // 创建一个group
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    
    dispatch_group_async(group, queue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        sleep(5);
        
        NSLog(@"任务一");
        
        dispatch_semaphore_signal(semaphore);
    });
    
    
    dispatch_group_async(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"任务二");
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        //        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"全部结束");
        
        
    });
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
