//
//  Progress.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Lottie/Lottie.h>

#import "Progress.h"

#import "UIColor+Plugin.h"
#import "UILabel+Size.h"

// 内容距离上下左右的间隔，以及内容之间的纵向间隔
static const CGFloat LeftGap = 15.0;
static const CGFloat TopGap = 15.0;
static const CGFloat RightGap = 15.0;
static const CGFloat BottomGap = 15.0;
static const CGFloat VGap = 5.0;

// ProgressView
static const CGFloat ProgressViewWidth = 50.0;
static const CGFloat ProgressViewHeight = 50.0;
static const CGFloat AnimationViewWidth = 36.0;
static const CGFloat AnimationViewHeight = 36.0;

static const CGFloat ProgressMinWidth = 100.0;
static const CGFloat ProgressMinHeight = 100.0;

// 默认字体大小
static const CGFloat TitleFontSize = 12.0;

// 默认圆角
static const CGFloat DefaultCorner = 10.0;

//默认颜色
static const CGFloat BgColorAlpha = 1;
#define BgColor @"#FFFFFF"
#define TitleColor @"#2D3132"


@implementation ProgressModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.stay = YES;
        self.inProgress = YES;
        self.showMaskView = NO;
        self.topOffset = -1;
    }
    return self;
}

@end


@interface Progress ()


/// 进度视图
@property (nonatomic, strong) UIView *progressView;

/// 动画
@property (nonatomic, strong) LOTAnimationView *animationView;

/// 文字label
@property (nonatomic, strong) UILabel *titleLabel;

/// 模型
@property (nonatomic, strong) ProgressModel *model;

@end


@implementation Progress

/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame model:(ProgressModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        [self setUpDetailUI];
    }
    return self;
}

#pragma mark - UI Methods
- (void)setUpDetailUI {
    // bgColor
    self.bgColor = [UIColor colorWithHexString:BgColor alpha:BgColorAlpha];

    // cornerRadius
    self.cornerRadius = DefaultCorner;

    // 阴影
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = self.cornerRadius;

    // titleLabel
    if (_model.text.length > 0) {
        CGFloat X = (CGRectGetWidth(self.frame) - ProgressViewWidth) / 2;
        CGFloat Y = TopGap;
        self.progressView.frame = CGRectMake(X, Y, ProgressViewWidth, ProgressViewHeight);

        self.titleColor = [UIColor colorWithHexString:TitleColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:TitleFontSize];
        self.titleLabel.text = _model.text;
        UIFont *textFont = [UIFont boldSystemFontOfSize:TitleFontSize];
        CGSize textSize = [UILabel labelSizehWithText:_model.text font:textFont];
        self.titleLabel.frame =
            CGRectMake(LeftGap, CGRectGetMaxY(self.progressView.frame) + VGap, CGRectGetWidth(self.frame) - LeftGap - RightGap, textSize.height);
    } else {
        CGFloat X = (CGRectGetWidth(self.frame) - ProgressViewWidth) / 2;
        CGFloat Y = (CGRectGetHeight(self.frame) - ProgressViewHeight) / 2;
        self.progressView.frame = CGRectMake(X, Y, ProgressViewWidth, ProgressViewHeight);
    }

    self.animationView.frame = CGRectMake((CGRectGetWidth(self.progressView.frame) - AnimationViewWidth) / 2,
                                          (CGRectGetHeight(self.progressView.frame) - AnimationViewHeight) / 2, AnimationViewWidth, AnimationViewHeight);

    if (_model.inProgress) {
        [self start];
    }
}

#pragma mark - Setter Getter Methods

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = _bgColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (!titleColor) {
        return;
    }
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}

- (void)setProgressColor:(UIColor *)progressColor {
    if (!progressColor) {
        return;
    }
    _progressColor = progressColor;
    //    self.progressView.color = _progressColor;

    // 暂时只有红色的动画
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        [self addSubview:_progressView];
    }
    return _progressView;
}

- (LOTAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [LOTAnimationView animationNamed:@"ProgressAnimation"];
        _animationView.contentMode = UIViewContentModeScaleAspectFit;
        _animationView.animationSpeed = 1.5;
        _animationView.loopAnimation = YES;
        [self.progressView addSubview:_animationView];
    }
    return _animationView;
}

#pragma mark - Public Methods
/// 开始
- (void)start {
    [self.animationView play];
}

/// 停止
- (void)stop {
    [self.animationView stop];
}

#pragma mark - Size
/// 获取ProgressSize
+ (CGSize)ProgressSizeWithText:(NSString *)text {
    CGFloat width = 0;
    CGFloat height = 0;

    if (text.length > 0) {
        UIFont *textFont = [UIFont boldSystemFontOfSize:TitleFontSize];
        CGSize textSize = [UILabel labelSizehWithText:text font:textFont];
        CGFloat contentWidth = textSize.width > ProgressViewWidth ? textSize.width : ProgressViewWidth;

        width = LeftGap + contentWidth + RightGap;
        width = width > ProgressMinWidth ? width : ProgressMinWidth;

        height = TopGap + ProgressViewHeight + VGap + textSize.height + BottomGap;
        height = height > ProgressMinHeight ? height : ProgressMinHeight;
    } else {
        width = ProgressMinWidth;
        height = ProgressMinHeight;
    }

    return CGSizeMake(width, height);
}

@end
