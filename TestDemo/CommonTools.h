//
//  CommonTools.h
//  Tools(公共的方法)
//
//  Created by PingAnXL on 2017/7/3.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface CommonTools : NSObject


/**
    动画切换window的根控制器

 @param RootViewController 传入的是初始化的控制器
 */
+(void)getAnmitionWithController:(UIViewController *)RootViewController;

/**
   去除数组中重复的对象

 @param oldArray 传入的数组
 @return 返回处理后的数组
 */
+ (NSArray *)removeRepetition:(NSArray *)oldArray;

/**
   颜色转图片

 @param color 入参是颜色
 @return返回处理后的图片
 */
+ (UIImage *)XL_imageWithColor:(UIColor *)color;

/**
 获取当前window

 */
+ (UIWindow *)getWindow;

/**
获取当前系统的型号

 */
+ (NSString *)getDeviceInfo;


/**
 image画圆角
 */
+ (UIImage *)circleImage:(UIImage *)image WithTransparency:(BOOL)isTransparency;


/**
  JSON 字符串转字典
 */
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

/**
   身份证号验证
 */
+ (BOOL)validateIdentityCard:(NSString *)str;

/**
 拿到正在显示的控制器，不管是push 还是present进去的都能拿到

*/
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController*)vc;


/**
 iOS 8.0 以上

 @param str1 第一个字符串
 @param str2 第二个字符串
 @return yes 表示包含， No 表示不包含
 */
+ (BOOL)string:(NSString *)str1 withSecondeStr:(NSString *)str2;


/**
    移除字符串的空格和换行
 @param str  传入字符串
 @return 处理后的字符串
 */
+ (NSString *)removeSpaceAndeNewLine:(NSString *)str;


/**
  判读字符串中是否含有空格
 */
+ (BOOL)isBlank:(NSString *)str;

/**
   字符串是否为空
 */
+ (BOOL)isEqualToNil:(NSString *)str;

/**
 view 背景颜色渐变

 @param view view
 @param color color
 @param fromColor  fromColor
 */
+ (void)CaGradientLayerView:(UIView *)view withBlackColor:(UIColor *)color withFromColor:(UIColor *)fromColor;

/**
 为view 某个方向添加圆角

 @param view view对象
 @param corner  天骄圆角的方向
 @param size 圆角的大小
 */
+ (void)addMaskView:(UIView *)view withCorner:(UIRectCorner)corner withFrame:(CGSize)size;



@end
