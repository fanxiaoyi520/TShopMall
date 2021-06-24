//
//  UIButton.m
//  TCLPlus
//
//  Created by YanboLiang on 2020/8/11.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Badge)

@property (strong, nonatomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;

+ (instancetype)buttonWithBadgeTextColor:(UIColor *)badgeTextColor
                    badgeBackGroundColor:(UIColor *)badgeBackGroundColor
                                   image:(UIImage *)image
                          highlightImage:(UIImage *)highlightImage;

//扩大按钮的点击范围
- (void)jaf_setEnlargeEdgeWithTop:(CGFloat)top
                            right:(CGFloat)right
                           bottom:(CGFloat) bottom
                             left:(CGFloat) left;
/**
 * 自定义切圆角
 * corners : 需要切的方向
 * cornerRadiiSize : 切割的大小
 */
- (void)jaf_customFilletRectCorner:(UIRectCorner)corners
                       cornerRadii:(CGSize)cornerRadiiSize;
@end
