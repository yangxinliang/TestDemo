//
//  CollectionViewController.m
//  UICollection卡片
//
//  Created by PingAnXL on 17/6/19.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "CollectionViewController.h"
#import "XLCarouselViewCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
 
    [self.collectionView registerClass:[XLCarouselViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    [self.collectionView registerNib:[UINib nibWithNibName:@"ViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 3]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
