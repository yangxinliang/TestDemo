//
//  ViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "ViewController.h"
#import "ForWordController.h"
#import "GCDViewController.h"



static NSString * cellID = @"cell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** uitable **/
@property (nonatomic, strong) UITableView * tableView;

/** 数组 **/
@property (nonatomic, strong) NSArray * soreArray;

@property (nonatomic, strong) NSArray * nameArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试demo";
    self.view.backgroundColor = [UIColor whiteColor];

    [self getSoreData];
    [self setUpUI];
    
}

// 获取数据
- (void)getSoreData {

    self.soreArray = @[@"消息机制",@"GCD",@"二维码生产",@"NSOperation",@"RunTime",@"strong和copy",@"链表实现数组和字典",@"UIView的刷新",@"collection",@"KVO实现原理",@"iOS本地通知",@"OCKnowledge",@"TouchTracker",@"动画"];
    
    
    self.nameArray = @[@"ForWordController",@"GCDViewController",@"ScanQRViewController",@"NSOperationViewController",@"RunTimeViewController",@"StrongAndCopyViewController",@"DicViewController",@"ReFreshViewController",@"CardViewController",@"KVOViewController",@"NotificationViewController",@"KnowledViewController",@"CoustomController",@"CoantionViewController"];

}

- (void)setUpUI {

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
    

}

#pragma mark - UITableView 的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.soreArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = self.soreArray[indexPath.row];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Class class = NSClassFromString(self.nameArray[indexPath.row]);
     UIViewController * vc = (UIViewController *)[class new];
    vc.title = self.nameArray[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
   

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
