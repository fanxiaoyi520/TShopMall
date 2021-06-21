//
//  UILabel+size.h
//  TCLPlus
//
//  Created by OwenChen on 2020/7/17.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UILabel (size)

/// 获取 label 中文本高度
/// @param text 文本
/// @param width 固定宽度
/// @param font 字体
+ (CGFloat)labelHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;

/// 获取 label 中文本宽度
/// @param text 文本
/// @param height 固定高度
/// @param font 字体
+ (CGFloat)labelWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;

/// 获取 label 中文本size
/// @param text 文本
/// @param font 字体
+ (CGSize)labelSizehWithText:(NSString *)text font:(UIFont *)font;

/// 获取 label 中富文本高度
/// @param attributedString 文本
/// @param width 固定宽度
+ (CGFloat)labelHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width;

/// 获取 label 中富文本宽度
/// @param attributedString 文本
/// @param height 固定高度
+ (CGFloat)labelWidthWithAttributedString:(NSAttributedString *)attributedString height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
