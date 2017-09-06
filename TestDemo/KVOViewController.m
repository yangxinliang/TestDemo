//
//  KVOViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "KVOViewController.h"
#import "NSObject+KVO.h"
@interface Message : NSObject

/** <#注释#> **/
@property (nonatomic, copy) NSString * text;


@end

@implementation Message

@end

@interface KVOViewController ()

/** dsadas **/
@property (nonatomic, strong) UITextField * textField;

/** dsad **/
@property (nonatomic, strong) UIButton * button;

/** qwqw **/
@property (nonatomic, strong) Message * message;


@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    
    
    self.button.backgroundColor = [UIColor redColor];
    
    [self.button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30,100, 40)];
    self.textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textField];
    
    self.message = [[Message alloc] init];
    
    [self.message YX_addObserver:self foKey:NSStringFromSelector(@selector(text)) withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        
        NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textField.text = newValue;
        });
    }];


}

- (void)btn {
    
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
