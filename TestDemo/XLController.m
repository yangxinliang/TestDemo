//
//  XLController.m
//  UICollection卡片
//
//  Created by PingAnXL on 17/6/20.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "XLController.h"
#import "XLCarouselViewCell.h"


static NSString * const cellID = @"XLCell";

@interface XLController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**  **/
@property (nonatomic, strong) UICollectionView * collectionView;


@end

@implementation XLController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self _setUpCollection];
    
}

- (void)_setUpCollection {

    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.yout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor redColor];

    
    [self.collectionView registerClass:[XLCarouselViewCell class] forCellWithReuseIdentifier:cellID];
    
    [self.view addSubview:self.collectionView];
    



}

- (NSIndexPath *)curIndexPath {
    
    NSArray * indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath * curIndexPath = nil;
    NSInteger cuzIndex = 0;
    for (NSIndexPath * path in indexPaths.objectEnumerator) {
        
        
        UICollectionViewLayoutAttributes * attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        
        if (!curIndexPath) {
            curIndexPath = path;
            cuzIndex = attributes.zIndex;
            continue;
            
        }
        if (attributes.zIndex > cuzIndex) {
            
            curIndexPath = path;
            cuzIndex = attributes.zIndex;
            
        }
        
    }
    
    return curIndexPath;
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
    return NO;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {


    return 20;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XLCarouselViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 3]];

    

    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
