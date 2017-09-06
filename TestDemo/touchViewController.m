//
//  touchViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "touchViewController.h"

@interface touchViewController ()
@property (nonatomic, strong) NSThread * thread;

@end

@implementation touchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.thread= [[NSThread alloc] initWithBlock:^{
        
        NSLog(@"dsadasdasda");
        
        [[NSRunLoop currentRunLoop] addPort:[NSPort  port] forMode:NSDefaultRunLoopMode];
        
        [[NSRunLoop currentRunLoop] run];
        
    }];
    [self.thread start];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        [self performSelector:@selector(action) onThread:self.thread withObject:nil waitUntilDone:NO];
        
    });
    

}

- (void)runDo {
    
    
    
    NSLog(@"这个可以走吗");
    
    
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    
    
    //           [self performSelector:@selector(action) onThread:self.thread withObject:nil waitUntilDone:NO];
    
    //        });
    
    [self performSelector:@selector(action) onThread:self.thread withObject:nil waitUntilDone:NO];
    
    
    
    
}

- (void)action {
    
    
    NSLog(@"常驻线程做的事情第二个页面");
    
    
}

- (void)dealloc {
    
    
    
    NSLog(@"%@",NSStringFromClass([self class]));
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
