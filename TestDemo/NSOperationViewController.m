//
//  NSOperationViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "NSOperationViewController.h"

@interface NSOperationViewController ()

@property (nonatomic, strong) NSThread * thread;

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //    [self addOperationToQueue];
    
    
    //    [self getMainQueue];
    
    // 这个方法容易引起循环引用
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(runDo) object:nil];
    
    [self.thread start];
  
    NSLog(@"self.thread%p",self.thread);

    
    NSLog(@"viewDidLoad%p",[NSThread currentThread]);


  

}


- (void)runDo {
    
    
    NSLog(@"dsadasdasda");
    
    [[NSRunLoop currentRunLoop] addPort:[NSPort  port] forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] run];
    
    
    NSLog(@"这个可以走吗");
    
    
    
}

// 使用runloop 可以来保证一个线程的生命周期  一般情况下子线程使用完之后 就会销毁线程，可以使用runloop 来保证子线程在当前页面不销毁
- (void)action {
    
    
    NSLog(@"action%p",[NSThread currentThread]);
    NSLog(@"常驻线程做的事情");
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    [self performSelector:@selector(action) onThread:self.thread withObject:nil waitUntilDone:NO];

}

- (void)addOperationToQueue {
    
    
    //    // 创建队列
    //    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    //
    //
    //    NSInvocationOperation * op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doWork) object:nil];
    //
    //
    //    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
    //        NSLog(@"%@",[NSThread currentThread]);
    //    }];
    //
    //    [queue addOperation:op1];
    //
    //    [queue addOperation:op2];
    
    
    //
    //    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    //    queue.maxConcurrentOperationCount = 3; // 如果最大并发数为1 的话 就变成了串行队列
    //
    //    [queue addOperationWithBlock:^{
    //
    //        NSLog(@"1-----%@", [NSThread currentThread]);
    //        [NSThread sleepForTimeInterval:0.01];
    //
    //    }];
    //
    //    [queue addOperationWithBlock:^{
    //
    //        NSLog(@"2-----%@", [NSThread currentThread]);
    //        [NSThread sleepForTimeInterval:0.01];
    //
    //    }];
    //
    //    [queue addOperationWithBlock:^{
    //        NSLog(@"3-----%@", [NSThread currentThread]);
    //        [NSThread sleepForTimeInterval:0.01];
    //    }];
    //
    //    [queue addOperationWithBlock:^{
    //        NSLog(@"4-----%@", [NSThread currentThread]);
    //        [NSThread sleepForTimeInterval:0.01];
    //    }];
    //
    //    [queue addOperationWithBlock:^{
    //        NSLog(@"5-----%@", [NSThread currentThread]);
    //        [NSThread sleepForTimeInterval:0.01];
    //
    //
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //            NSLog(@"%@所有任务都执行完", [NSThread currentThread]);
    //        }];
    //
    //    }];
    //
    
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"111111%@",[NSThread currentThread]);
        
    }];
    
    
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        NSLog(@"22222222%@",[NSThread currentThread]);
        
    }];
    NSLog(@"dasdasda");
    
    [op2 addDependency:op1];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    
    
}
- (void)doWork {
    
    NSLog(@"%@",[NSThread currentThread]);
    
    
    
    
    
}
- (void)_setOpention {
    
    
    // 使用NSInvocationOperation 只能在主线程中运行，没有开启新的线程的能力
    //    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doSomething) object:nil];
    //
    //    [op start];
    
    // 使用 NSBlockOperation 也是在主线程执行操作，也没有开启新的线程能力
    NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        
    }];
    
    [op addExecutionBlock:^{
        
        NSLog(@"1111%@",[NSThread currentThread]);
        
        
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"2222%@",[NSThread currentThread]);
        
        
    }];
    
    [op addExecutionBlock:^{
        
        NSLog(@"33333%@",[NSThread currentThread]);
        
    }];
    
    
    [op start];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
