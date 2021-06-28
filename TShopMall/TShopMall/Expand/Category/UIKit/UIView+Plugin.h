//
//  UIView+Plugin.h
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/24.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ShadowPathSide) {
    ShadowPathSideLeft,   // 左边阴影
    ShadowPathSideRight,  // 右边阴影
    ShadowPathSideTop,    // 顶部阴影
    ShadowPathSideBottom, // 底部阴影
    ShadowPathSideAllSide // 每边都有阴影
};


@interface UIView (Plugin)

@property (nonatomic, assign) CGFloat frameCenterX;
@property (nonatomic, assign) CGFloat frameCenterY;
@property (nonatomic, assign) CGPoint frameCenter;
@property (nonatomic, assign) CGSize frameSize;

@property (nonatomic, assign) CGFloat frameX;
@property (nonatomic, assign) CGFloat frameY;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;


/// 获取安全区域
- (UIEdgeInsets)eh_safeAreaInsets;

/**
 截取当前View

 @return 当前View的截图
 */
- (UIImage *)snapShotImage;

/**
 为View添加下划线

 @param color 下划线颜色
 @param height 下划线高度
 */
- (void)setUnderLineWithColor:(UIColor *)color Height:(CGFloat)height;


/**
 为View添加圆角和阴影

 @param radius 圆角半径
 */
- (void)shadowlizedWithCornerRadius:(CGFloat)radius;


/// 快速设置阴影
/// @param shadowColor 阴影颜色
/// @param shadowOpacity 阴影透明度
/// @param shadowRadius 阴影半径
/// @param shadowPathSide 阴影出现的边
/// @param shadowPathWidth 阴影宽度
- (void)setShadowPathWith:(UIColor *)shadowColor
            shadowOpacity:(CGFloat)shadowOpacity
             shadowRadius:(CGFloat)shadowRadius
               shadowSide:(ShadowPathSide)shadowPathSide
          shadowPathWidth:(CGFloat)shadowPathWidth;

/// 设置圆角
/// @param cornerRadius 圆角半径
/// @param borderWidth 边宽
/// @param borderColor 边颜色
/// @param corners 角
- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor type:(UIRectCorner)corners;

- (void)drawLineWithWidth:(CGFloat)width color:(UIColor *)borderCol starPiont:(CGPoint)startPiont endPoint:(CGPoint)endPoint;

/**
 * 自定义切圆角
 * corners : 需要切的方向
 * cornerRadiiSize : 切割的大小
 */
- (void)jaf_customFilletRectCorner:(UIRectCorner)corners
                       cornerRadii:(CGSize)cornerRadiiSize;
@end

NS_ASSUME_NONNULL_END
