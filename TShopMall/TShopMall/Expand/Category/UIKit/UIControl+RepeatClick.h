//
//  UIControl+RepeatClick.h
//  TCLPlus
//
//  Created by tangzhiqiang on 2020/9/5.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
// 这个给按钮防止重复点击的分类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIControl (RepeatClick)

@property (nonatomic, assign) NSTimeInterval eventInterval;

@end

NS_ASSUME_NONNULL_END
