//
//  Progress.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgressModel : NSObject

/// 文字
@property (nonatomic, copy) NSString *text;
/// 时间间隔
@property (nonatomic, assign) CGFloat interval;
/// 动画状态
@property (nonatomic, assign) BOOL inProgress;
/// 是否要停留
@property (nonatomic, assign) BOOL stay;
/// 是否显示背景蒙板
@property (nonatomic, assign) BOOL showMaskView;
///指定距离顶部的间距
@property (nonatomic, assign) CGFloat topOffset;

@end


@interface Progress : UIView

/// 背景色
@property (nonatomic, strong) UIColor *bgColor;
/// 主标题颜色
@property (nonatomic, strong) UIColor *titleColor;
/// 副标题颜色
@property (nonatomic, strong) UIColor *progressColor;
/// 圆角
@property (nonatomic, assign) CGFloat cornerRadius;

/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame model:(ProgressModel *)model;

/// 开始
- (void)start;

/// 停止
- (void)stop;

/// 获取ProgressSize
+ (CGSize)ProgressSizeWithText:(NSString *)text;

@end
