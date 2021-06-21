//
//  UIImage+Plugin.h
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/31.
//  Copyright © 2019 TCLIOT. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {

    GradientTypeTopToBottom = 0, //从上到小

    GradientTypeLeftToRight = 1, //从左到右

    GradientTypeUpleftToLowright = 2, //左上到右下

    GradientTypeUprightToLowleft = 3, //右上到左下

};


@interface UIImage (Plugin)

+ (UIImage *)imageScreenShot;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

- (UIImage *)drawRectWithRoundedCorner:(CGFloat)radius Size:(CGSize)size;

+ (UIImage *)imageWithView:(UIView *)view Translucent:(BOOL)translucent;

/**
 给顶颜色数组渐变

 @param colors 要添加的图片数组
 @param gradientType 方向类型
 @param imgSize 图片尺寸
 @return 渐变的新图片
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray<UIColor *> *)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

/**
 给指定图片的正中添加图片

 @param image 要添加的图片
 @return 合成之后的新图片
 */
- (UIImage *)appendImageInCenterWithImage:(UIImage *)image;

/**
 缩放图片大小

 @param image 原图
 @param size 缩略图大小
 @return 缩略图
 */
+ (UIImage *)imageScaledFromImage:(UIImage *)image Size:(CGSize)size;

/// 根据图片的像素点获取该点颜色
/// @param point 点
- (UIColor *)colorAtPixel:(CGPoint)point;


/// 从Bundle中获得图片
/// @param imageName 图片名称
/// @param bundleName Bundle名称
+ (UIImage *)imageWithName:(NSString *)imageName Bundle:(NSString *)bundleName;

/// 图片置灰
/// @param sourceImage 图片
+ (UIImage *)grayImage:(UIImage *)sourceImage;

/// 裁剪图片
/// @param originalImage 原始图
/// @param rect 裁剪位置
+ (UIImage *)cutImage:(UIImage *)originalImage withRect:(CGRect)rect;

/// 拉伸图片中间位置
- (UIImage *)strechedInCenter;

@end

NS_ASSUME_NONNULL_END
