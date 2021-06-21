//
//  UIView+UIKit.h
//  TCLPlus
//
//  Created by OwenChen on 2021/1/28.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIView (UIKit)

/// 设置四个角的圆角
/// @param leftTop 左上
/// @param rightTop 右上
/// @param bottemLeft 左下
/// @param bottemRight 右下
- (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rightTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight;

/// 设置阴影
/// @param offset 阴影偏移
/// @param radius 阴影半径
/// @param shadowColor 阴影颜色
/// @param shadowOpacity 阴影透明度
/// @param leftTop 左上
/// @param rightTop 右上
/// @param bottemLeft 左下
/// @param bottemRight 右下
- (void)setShadowWithOffset:(CGSize)offset
               shadowRadius:(CGFloat)radius
                shadowColor:(UIColor *)shadowColor
              shadowOpacity:(CGFloat)shadowOpacity
              leftTopCorner:(CGFloat)leftTop
             rightTopCorner:(CGFloat)rightTop
           bottomLeftCorner:(CGFloat)bottemLeft
          bottomRightCorner:(CGFloat)bottemRight;

@end

NS_ASSUME_NONNULL_END
