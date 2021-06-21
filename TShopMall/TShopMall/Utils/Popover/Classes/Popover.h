//
//  Popover.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Progress.h"
#import "Toasty.h"

typedef NS_ENUM(NSInteger, PopPosition) {
    PopPositionMiddle = 0, //显示在中间
    PopPositionTop = 1,    //显示在上面
    PopPositionBottom = 2, // 显示在底部
};

typedef void (^PopoverWillAppear)(id frontView);


@interface Popover : UIView

#pragma mark - Toast Public Methods

/// 显示Toast
/// @param text text
+ (void)popToastOnWindowWithText:(NSString *)text;

/// 显示 Toast 方法 (显示在指定UIView)
/// @param view super view
/// @param text Text
+ (void)popToastOnView:(UIView *)view text:(NSString *)text;


/// 显示 Toast 方法 (显示在指定UIView)
/// 显示在中间
+ (void)popMiddleToastOnView:(UIView *)view text:(NSString *)text;

/// 显示 Toast 方法 (显示在指定UIView，并且制定topOffset)
/// @param view super view
/// @param text Text
/// @param topOffset 距离顶部的间距
+ (void)popToastOnView:(UIView *)view text:(NSString *)text topOffset:(CGFloat)topOffset;

/// 显示 Toast 方法 （显示在window）
/// @param popPosition 显示位置
/// @param toastyModel toast 数据模型
/// @param appearBlock 显示回调
+ (void)popToastOnWindowWithPopPosition:(PopPosition)popPosition toastyModel:(ToastyModel *)toastyModel appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Toast 方法 (显示在指定UIView)
/// @param view super view
/// @param popPosition 显示位置
/// @param toastyModel toast 数据模型
/// @param appearBlock 显示回调
+ (void)popToastOnView:(UIView *)view popPosition:(PopPosition)popPosition toastyModel:(ToastyModel *)toastyModel appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Toast 方法 （显示在window）
/// @param popPosition 显示位置
/// @param text 文字
/// @param type 类型
/// @param appearBlock 显示回调
+ (void)popToastOnWindowWithPopPosition:(PopPosition)popPosition text:(NSString *)text toastyType:(ToastyType)type appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Toast 方法 (显示在指定UIView)
/// @param view super view
/// @param popPosition 显示位置
/// @param text 文字
/// @param type 类型
/// @param appearBlock 显示回调
+ (void)popToastOnView:(UIView *)view
           popPosition:(PopPosition)popPosition
                  text:(NSString *)text
            toastyType:(ToastyType)type
           appearBlock:(PopoverWillAppear)appearBlock;

#pragma mark - Progress Public Methods
/// 显示 Progress 方法 （显示在window）
/// @param text 文字
+ (void)popProgressOnWindowWithText:(NSString *)text;

/// 显示 Toast 方法 (显示在指定UIView)
/// @param view super view
/// @param text 文字
+ (void)popProgressOnView:(UIView *)view text:(NSString *)text;

/// 显示 Toast 方法 (显示在指定UIView，并且制定topOffset)
/// @param view super view
/// @param text 文字
/// @param topOffset 距离顶部的间距
+ (void)popProgressOnView:(UIView *)view text:(NSString *)text topOffset:(CGFloat)topOffset;

/// 显示 Progress 方法 （显示在window）
/// @param model 文字数据模型
/// @param appearBlock 显示回调
+ (void)popProgressOnWindowWithProgressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Toast 方法 (显示在指定UIView)
/// @param view super view
/// @param model 文字数据模型
/// @param appearBlock 显示回调
+ (void)popProgressOnView:(UIView *)view progressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Progress 方法 （显示在window）
/// @param text 文字
/// @param appearBlock 显示回调
+ (void)popProgressOnWindowWithText:(NSString *)text appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Toast 方法 (显示在指定UIView)
/// @param view super view
/// @param text 文字
/// @param appearBlock 显示回调
+ (void)popProgressOnView:(UIView *)view text:(NSString *)text appearBlock:(PopoverWillAppear)appearBlock;

#pragma mark - Common Public Methods
/// 移除Window上的所有Popover
+ (void)removePopoverOnWindow;

/// 移除指定View上的所有Popover
/// @param view 父视图
+ (void)removePopoverOnView:(UIView *)view;

///  移除指定View上的所有Progress
/// @param view 父视图
+ (void)removeProgressOnView:(UIView *)view;


@end
