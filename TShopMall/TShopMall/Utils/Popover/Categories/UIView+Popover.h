//
//  UIView+Popover.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Popover.h"


@interface UIView (Popover)

#pragma mark - Toast
/// 显示 Toast 方法 （显示在本身UIView）
/// @param popPosition 显示位置
/// @param toastyModel toast 数据模型
/// @param appearBlock 显示回调
- (void)popToastWithPopPosition:(PopPosition)popPosition toastyModel:(ToastyModel *)toastyModel appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Toast 方法 （显示在本身UIView）
/// @param popPosition 显示位置
/// @param text 文字
/// @param appearBlock 显示回调
- (void)popToastWithPopPosition:(PopPosition)popPosition text:(NSString *)text toastyType:(ToastyType)type appearBlock:(PopoverWillAppear)appearBlock;

#pragma mark - Progress
/// 显示 Progress 方法 （显示在本身UIView）
/// @param model 文字数据模型
/// @param appearBlock 显示回调
- (void)popProgressWithProgressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock;

/// 显示 Progress 方法 （显示在本身UIView）
/// @param text 文字
/// @param appearBlock 显示回调
- (void)popProgressWithText:(NSString *)text appearBlock:(PopoverWillAppear)appearBlock;

@end
