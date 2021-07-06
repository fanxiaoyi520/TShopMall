//
//  UIButton+TSLayout.h
//
//
//  Created by sway on 2020/11/12.
//  Copyright © 2020 CMS. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, TSButtonEdgeInsetsStyle) {
    TSButtonEdgeInsetsStyleTop, // image在上，label在下
    TSButtonEdgeInsetsStyleLeft, // image在左，label在右
    TSButtonEdgeInsetsStyleBottom, // image在下，label在上
    TSButtonEdgeInsetsStyleRight // image在右，label在左
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TSLayout)
/// 设置button的titleLabel和imageView的布局样式，及间距
/// @param style titleLabel和imageView的布局样式
/// @param space titleLabel和imageView的间距
- (void)ts_layoutWithEdgeInsetsStyle:(TSButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
