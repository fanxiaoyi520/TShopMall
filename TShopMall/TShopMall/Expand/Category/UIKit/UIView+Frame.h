//
//  UIView+Frame.h
//  TSale
//
//  Created by Daisy  on 2020/12/7.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat tcl_top;

@property (nonatomic, assign) CGFloat tcl_bottom;

@property (nonatomic, assign) CGFloat tcl_left;

@property (nonatomic, assign) CGFloat tcl_right;

@property (nonatomic, assign) CGFloat tcl_x;

@property (nonatomic, assign) CGFloat tcl_y;

@property (nonatomic, assign) CGFloat tcl_centerX;

@property (nonatomic, assign) CGFloat tcl_centerY;

@property (nonatomic, assign) CGFloat tcl_width;

@property (nonatomic, assign) CGFloat tcl_height;

@property (nonatomic, assign) CGSize tcl_size;

@property (nonatomic, assign) CGPoint tcl_origin;

-(BOOL)intersectWithView:(UIView *)view;

/**
 * 找到view的父视图
 */
-(UIViewController *)tcl_findViewContrlloer;

/**
 *  给view切圆角
 *  corners : 哪个角
 *  cornerRadii : 圆角size
 */
-(instancetype)tcl_scornerByRoundCorners:(UIRectCorner)corners  cornerRadius:(CGFloat)cornerRadius;

/**
 *  给view所有角切圆角
 *  cornerRadii : 圆角size
 */
- (instancetype)tcl_cornerAllCornersWithCornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
