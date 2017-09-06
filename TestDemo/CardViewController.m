//
//  CardViewController.m
//  TestDemo
//
//  Created by PingAnXL on 2017/8/21.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "CardViewController.h"
#import "XLCarouselViewLayout.h"
#import "CollectionViewController.h"

#import "XLController.h"

static NSString * cellID = @"cell";

@interface CardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * array;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = @[@"linear",@"rorary",@"Carousel",@"Carousel1",@"CoverFlow",@"Horizontal"];
    
    [self _setUpUI];
}

- (void)_setUpUI {
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80.0f;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    cell.textLabel.text = self.array[indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XLCarouselViewLayout *layout = nil;
    switch (indexPath.row) {
        case 0:
            layout = [[XLCarouselViewLayout alloc] initWithAnin:XLCarouselAnimLinear];
            //            layout.visibleCount = 3;
            break;
        case 1:
            layout = [[XLCarouselViewLayout alloc] initWithAnin:XLCarouselAnimRotary];
            break;
        case 2:
            layout = [[XLCarouselViewLayout alloc] initWithAnin:XLCarouselAnimCarousel];
            break;
        case 3:
            layout = [[XLCarouselViewLayout alloc] initWithAnin:XLCarouselAnimCarousel1];
            break;
        case 4:
            layout = [[XLCarouselViewLayout alloc] initWithAnin:XLCarouselAnimCoverFlow];
            break;
        default:
            layout = [[XLCarouselViewLayout alloc] initWithAnin:XLCarouselAnimLinear];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            
            break;
    }
    
    
    layout.itemSize = CGSizeMake(250,250);
    XLController *vc = [[XLController alloc]init];
    vc.yout = layout;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.title = cell.textLabel.text;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
