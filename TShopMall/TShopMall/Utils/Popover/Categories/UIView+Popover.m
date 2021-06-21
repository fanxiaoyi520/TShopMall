//
//  UIView+Popover.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "UIView+Popover.h"


@implementation UIView (Popover)

#pragma mark - Toast
/// 显示 Toast 方法 （显示在本身UIView）
- (void)popToastWithPopPosition:(PopPosition)popPosition toastyModel:(ToastyModel *)toastyModel appearBlock:(PopoverWillAppear)appearBlock {
    [Popover popToastOnView:self popPosition:popPosition toastyModel:toastyModel appearBlock:appearBlock];
}

/// 显示 Toast 方法 （显示在本身UIView）
- (void)popToastWithPopPosition:(PopPosition)popPosition text:(NSString *)text toastyType:(ToastyType)type appearBlock:(PopoverWillAppear)appearBlock {
    [Popover popToastOnView:self popPosition:popPosition text:text toastyType:type appearBlock:appearBlock];
}

#pragma mark - Progress
/// 显示 Progress 方法 （显示在本身UIView）
- (void)popProgressWithProgressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock {
    [Popover popProgressOnView:self progressModel:model appearBlock:appearBlock];
}

/// 显示 Progress 方法 （显示在本身UIView）
- (void)popProgressWithText:(NSString *)text appearBlock:(PopoverWillAppear)appearBlock {
    [Popover popProgressOnView:self text:text appearBlock:appearBlock];
}

@end
