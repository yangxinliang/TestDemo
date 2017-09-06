//
//  XLCarouselViewLayout.h
//  UICollection卡片
//
//  Created by PingAnXL on 17/6/19.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,XLCarouselAnim){
    XLCarouselAnimLinear,
    XLCarouselAnimRotary,
    XLCarouselAnimCarousel,
    XLCarouselAnimCarousel1,
    XLCarouselAnimCoverFlow,
 };

@interface XLCarouselViewLayout : UICollectionViewLayout


- (instancetype)initWithAnin:(XLCarouselAnim)anim;


/**  **/
@property (nonatomic, assign) CGSize itemSize;

/**  **/
@property (nonatomic, assign) NSInteger  visibleCount;
/**  **/
@property (nonatomic, assign) UICollectionViewScrollDirection  scrollDirection;


@end
