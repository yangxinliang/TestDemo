//
//  YXLViewController.m
//  TouchTracker
//
//  Created by PingAnXL on 17/4/11.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "YXLViewController.h"
#import "YXLView.h"

@implementation YXLViewController

- (void)loadView {
   
    self.view = [[YXLView alloc] init];


}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.tabBarItem.title = @"多手触摸";
    }

    return self;

}

- (void)viewDidLoad {




}


@end
