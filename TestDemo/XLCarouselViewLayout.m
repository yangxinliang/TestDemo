//
//  XLCarouselViewLayout.m
//  UICollection卡片
//
//  Created by PingAnXL on 17/6/19.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "XLCarouselViewLayout.h"

#define INTERSPACEPARAM  0.8

@interface XLCarouselViewLayout ()
{
    CGFloat _viewHeight;
    CGFloat _itemHeight;
  
}

/**  **/
@property (nonatomic) XLCarouselAnim  carouselAnim;

@end

@implementation XLCarouselViewLayout

- (instancetype)initWithAnin:(XLCarouselAnim)anim {
    
    if (self = [super init]) {
        self.carouselAnim = anim;
        

    }
    
    return self;
}

//  这个函数的用处
- (void)prepareLayout {

    [super prepareLayout];

    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }

    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        _viewHeight = CGRectGetHeight(self.collectionView.frame);
        _itemHeight = self.itemSize.height;
        
        NSLog(@"%f %f",_viewHeight,_itemHeight);
        
        self.collectionView.contentInset = UIEdgeInsetsMake((_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2, 0);
    }else{
    
        _viewHeight = CGRectGetWidth(self.collectionView.frame);
        _itemHeight = self.itemSize.width;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2);
    }
 
}

- (CGSize)collectionViewContentSize {
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return CGSizeMake(CGRectGetWidth(self.collectionView.frame), cellCount * _itemHeight);
    }
    return CGSizeMake(cellCount * _itemHeight, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat centerY = (self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x) + _viewHeight / 2;
    
    NSInteger index = centerY / _itemHeight;
    
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    
    NSLog(@"%ld  %ld",minIndex,maxIndex);
    
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = minIndex;i < maxIndex ; i ++ ) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [array addObject:attributes];
     }
    
    return array;

}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cY = (self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x) + _viewHeight / 2;
    
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    
    attributes.zIndex = -ABS(attributesY - cY);
    CGFloat delta = cY - attributesY;
    CGFloat ratio = -delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerY = attributesY;
    
    switch (self.carouselAnim) {
        case XLCarouselAnimRotary:
            attributes.transform = CGAffineTransformRotate(attributes.transform, - ratio * M_PI_4);
            
            centerY += sin(ratio * M_PI_2) * _itemHeight / 2;
            
            break;
            
         case XLCarouselAnimCarousel:
            centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
            
            break;
            
          case XLCarouselAnimCarousel1:
            
            centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
            if (delta > 0 && delta <= _itemHeight / 2) {
                attributes.transform = CGAffineTransformIdentity;
             
                CGRect rect = attributes.frame;
            if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    rect.origin.x = CGRectGetWidth(self.collectionView.frame) / 2 - _itemSize.width * scale / 2;
                    rect.origin.y = centerY - _itemHeight * scale / 2;
                    rect.size.width = _itemSize.width * scale;
                    CGFloat parm = delta / (_itemHeight / 2);
                    rect.size.height = _itemHeight * scale * (1 - parm) + sin(0.25 * M_PI_2) * _itemHeight * INTERSPACEPARAM * 2 * parm;
                }else {
                    rect.origin.x = centerY - _itemHeight * scale / 2;
                    rect.origin.y = CGRectGetHeight(self.collectionView.frame) / 2 - _itemSize.height * scale / 2;
                    rect.size.height = _itemSize.height * scale;
                    CGFloat parm = delta / (_itemHeight / 2);
                    rect.size.width = _itemHeight * scale * (1 - parm) + sin(0.25 * M_PI_2) * _itemHeight * INTERSPACEPARAM * 2 * parm;
                
                }
                attributes.frame = rect;
                return  attributes;
                
            }
            
            break;
        case XLCarouselAnimCoverFlow: {
            CATransform3D trasnsform = CATransform3DIdentity;
            
            trasnsform.m34 = - 1.0 / 400.0f;
            trasnsform = CATransform3DRotate(trasnsform, ratio * M_PI_4, 1, 0, 0);
            attributes.transform3D = trasnsform;
        
        }
            
            
            break;
            
        default:
            break;
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        attributes.center = CGPointMake(CGRectGetWidth(self.collectionView.frame)/2, centerY);
    }else {
    
        attributes.center = CGPointMake(centerY , CGRectGetHeight(self.collectionView.frame)/2);
    }

    return attributes;

}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    CGFloat index = roundf(((self.scrollDirection == UICollectionViewScrollDirectionVertical ? proposedContentOffset.y : proposedContentOffset.x) + _viewHeight / 2 - _itemHeight / 2) / _itemHeight);
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        proposedContentOffset.y = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    } else {
        proposedContentOffset.x = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    }
    return proposedContentOffset;

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);

}










@end
