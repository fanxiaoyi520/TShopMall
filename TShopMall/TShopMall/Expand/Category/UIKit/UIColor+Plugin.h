//
//  UIColor+Plugin.h
//  TCLPlus
//
//  Created by OwenChen on 2021/1/25.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIColor (Plugin)

/**
 通过点语法直接从颜色中取出一个10 * 10大小的纯色图片
 */
@property (nonatomic, strong, readonly) UIImage *image;

/**
 通过Hex值取颜色

 @param hex hex字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hex;


/**
 hex颜色并可以设置透明度

 @param hex hex值
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;


/**
 通过RGB值获得颜色

 @param red 红色
 @param green 绿色
 @param blue 蓝色
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha;


/**
 RGB值相同时的便利构造方法

 @param rgbValue RGB值
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithRGB:(CGFloat)rgbValue Alpha:(CGFloat)alpha;


/// RGBHex值转颜色
/// @param hex RGBHex值
+ (UIColor *)colorWithRGBHex:(int)hex;


/// RGBHex值转颜色 带透明度
/// @param hex 颜色的十六进制编码
/// @param alpha 透明度
+ (UIColor *)colorWithRGBHex:(int)hex alpha:(CGFloat)alpha;

/// 将RGB数值转化为16进制字符串
/// @param red R
/// @param green G
/// @param blue B
+ (NSString *)hexStringWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;

/// 十进制数转换成16进制数字符串
/// @param intValue 十进制数
+ (NSString *)hexStringWithInt:(int)intValue;

/// 导航栏动态颜色渐变，从color2到color1渐变
/// @param color1 最终颜色
/// @param color2 开始颜色
/// @param ratio 临界点
+ (UIColor *)mixColor1:(UIColor *)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio;

@end

NS_ASSUME_NONNULL_END
