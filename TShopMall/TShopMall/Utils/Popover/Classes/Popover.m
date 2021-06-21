//
//  Popover.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "Popover.h"

#import "UIColor+Plugin.h"

typedef NS_ENUM(NSInteger, PopType) {
    PopTypeToast = 0,
    PopTypeProgress = 1,
};

// 屏幕宽度
#define POPOVER_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define POPOVER_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// 背景颜色
#define MaskColor @"#000000"
static const CGFloat BgColorAlpha = 0.4;
// 默认停留时间
static const CGFloat DefaulToastyTinterval = 1.5;


@interface Popover ()

@property (nonatomic, assign) PopPosition popPosition;
@property (nonatomic, assign) PopType popType;
@property (nonatomic, assign) CGFloat topOffset; //指定距离顶部的间距

@property (nonatomic, strong) id contentView;

@property (nonatomic, assign) CGRect popoverVerticalFrame;
@property (nonatomic, assign) CGRect popoverHorizontalFrame;
@property (nonatomic, assign) CGRect contentViewVerticalFrame;
@property (nonatomic, assign) CGRect contentViewHorizontalFrame;

@end


@implementation Popover

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat verticalScreenW = POPOVER_SCREEN_WIDTH > POPOVER_SCREEN_HEIGHT ? POPOVER_SCREEN_HEIGHT : POPOVER_SCREEN_WIDTH;
        CGFloat verticalScreenH = POPOVER_SCREEN_WIDTH > POPOVER_SCREEN_HEIGHT ? POPOVER_SCREEN_WIDTH : POPOVER_SCREEN_HEIGHT;
        self.popoverVerticalFrame = CGRectMake(0, 0, verticalScreenW, verticalScreenH);

        CGFloat horizontalScreenW = POPOVER_SCREEN_WIDTH < POPOVER_SCREEN_HEIGHT ? POPOVER_SCREEN_HEIGHT : POPOVER_SCREEN_WIDTH;
        CGFloat horizontalScreenH = POPOVER_SCREEN_WIDTH < POPOVER_SCREEN_HEIGHT ? POPOVER_SCREEN_WIDTH : POPOVER_SCREEN_HEIGHT;
        self.popoverHorizontalFrame = CGRectMake(0, 0, horizontalScreenW, horizontalScreenH);

        [self addNotification];
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)orientationDidChange {
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        // 横屏
        [UIView animateWithDuration:0.2 animations:^{
            if ([self.contentView isKindOfClass:[Progress class]]) {
                Progress *view = (Progress *)self.contentView;
                view.frame = self.contentViewHorizontalFrame;
            } else if ([self.contentView isKindOfClass:[Toasty class]]) {
                Toasty *view = (Toasty *)self.contentView;
                [view changeFrame:self.contentViewHorizontalFrame maxWidth:CGRectGetWidth(self.popoverHorizontalFrame) - 80.0];
            }
        }];
    } else {
        // 竖屏
        [UIView animateWithDuration:0.2 animations:^{
            if ([self.contentView isKindOfClass:[Progress class]]) {
                Progress *view = (Progress *)self.contentView;
                view.frame = self.contentViewVerticalFrame;
            } else if ([self.contentView isKindOfClass:[Toasty class]]) {
                Toasty *view = (Toasty *)self.contentView;
                [view changeFrame:self.contentViewVerticalFrame maxWidth:CGRectGetWidth(self.popoverVerticalFrame) - 80.0];
            }
        }];
    }
}

#pragma mark - Toast Methods
#pragma mark - Public Methods
/// 显示Toast
+ (void)popToastOnWindowWithText:(NSString *)text {
    ToastyModel *model = [[ToastyModel alloc] init];
    model.type = ToastyTypeNormal;
    model.subTitle = text;
    [self popToastOnView:[self keyView] popPosition:PopPositionBottom toastyModel:model appearBlock:nil];
}

/// 显示 Toast 方法 (显示在指定UIView)
+ (void)popToastOnView:(UIView *)view text:(NSString *)text {
    ToastyModel *model = [[ToastyModel alloc] init];
    model.type = ToastyTypeNormal;
    model.subTitle = text;
    [self popToastOnView:view popPosition:PopPositionBottom toastyModel:model appearBlock:nil];
}

/// 显示 Toast 方法 (显示在指定UIView)
+ (void)popMiddleToastOnView:(UIView *)view text:(NSString *)text {
    ToastyModel *model = [[ToastyModel alloc] init];
    model.type = ToastyTypeNormal;
    model.subTitle = text;
    [self popToastOnView:view popPosition:PopPositionMiddle toastyModel:model appearBlock:nil];
}


/// 显示 Toast 方法 (显示在指定UIView，并且制定topOffset)
/// @param view super view
/// @param text Text
/// @param topOffset 距离顶部的间距
+ (void)popToastOnView:(UIView *)view text:(NSString *)text topOffset:(CGFloat)topOffset {
    ToastyModel *model = [[ToastyModel alloc] init];
    model.type = ToastyTypeNormal;
    model.subTitle = text;
    model.topOffset = topOffset;
    [self popToastOnView:view popPosition:PopPositionBottom toastyModel:model appearBlock:nil];
}

/// 显示 Toast 方法
+ (void)popToastOnWindowWithPopPosition:(PopPosition)popPosition toastyModel:(ToastyModel *)toastyModel appearBlock:(PopoverWillAppear)appearBlock {
    [self popToastOnView:[self keyView] popPosition:popPosition toastyModel:toastyModel appearBlock:appearBlock];
}

/// 显示 Toast 方法
+ (void)popToastOnWindowWithPopPosition:(PopPosition)popPosition text:(NSString *)text toastyType:(ToastyType)type appearBlock:(PopoverWillAppear)appearBlock {
    ToastyModel *model = [[ToastyModel alloc] init];
    model.type = type;
    model.subTitle = text;
    [self popToastOnView:[self keyView] popPosition:popPosition toastyModel:model appearBlock:appearBlock];
}

/// 显示 Toast 方法
+ (void)popToastOnView:(UIView *)view
           popPosition:(PopPosition)popPosition
                  text:(NSString *)text
            toastyType:(ToastyType)type
           appearBlock:(PopoverWillAppear)appearBlock {
    ToastyModel *model = [[ToastyModel alloc] init];
    model.type = type;
    model.subTitle = text;
    [self popToastOnView:view popPosition:popPosition toastyModel:model appearBlock:appearBlock];
}

/// 显示 Toast 方法
+ (void)popToastOnView:(UIView *)view popPosition:(PopPosition)popPosition toastyModel:(ToastyModel *)toastyModel appearBlock:(PopoverWillAppear)appearBlock {
    CGFloat width = CGRectGetWidth(view.bounds);
    CGFloat height = CGRectGetHeight(view.bounds);
    if (!view || width == 0 || height == 0 || !toastyModel) {
        return;
    }

    for (id pop in view.subviews) {
        if ([pop isKindOfClass:[Popover class]]) {
            [pop removeFromSuperview];
        }
    }

    Popover *pop = [[Popover alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    pop.popPosition = popPosition;
    pop.backgroundColor = toastyModel.showMaskView ? [UIColor colorWithHexString:MaskColor alpha:BgColorAlpha] : [UIColor clearColor];
    pop.userInteractionEnabled = toastyModel.showMaskView;
    [view addSubview:pop];

    [pop showToastWithToastyModel:toastyModel appearBlock:appearBlock];
}

+ (UIView *)keyView {
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
    if (!keyView) {
        keyView = [[[UIApplication sharedApplication] windows] lastObject];
    }
    return keyView;
}

#pragma mark - Private Methods
- (void)showToastWithToastyModel:(ToastyModel *)model appearBlock:(PopoverWillAppear)appearBlock {
    self.popType = PopTypeToast;

    CGSize size = [Toasty toastySizeWithToastyModel:model maxWidth:CGRectGetWidth(self.frame) - 80.0];
    CGFloat X = (CGRectGetWidth(self.frame) - size.width) / 2;
    CGFloat Y = 0;

    CGSize verticalSize = [Toasty toastySizeWithToastyModel:model maxWidth:CGRectGetWidth(self.popoverVerticalFrame) - 80.0];
    CGFloat verticalX = (CGRectGetWidth(self.popoverVerticalFrame) - verticalSize.width) / 2;
    CGFloat verticalY = 0;

    CGSize horizontalSize = [Toasty toastySizeWithToastyModel:model maxWidth:CGRectGetWidth(self.popoverHorizontalFrame) - 80.0];
    CGFloat horizontalX = (CGRectGetWidth(self.popoverHorizontalFrame) - horizontalSize.width) / 2;
    CGFloat horizontalY = 0;

    if (model.topOffset >= 0) {
        Y = model.topOffset;
    } else {
        switch (self.popPosition) {
            case PopPositionTop: {
                Y = CGRectGetHeight(self.frame) / 5;
                verticalY = CGRectGetHeight(self.popoverVerticalFrame) / 5;
                horizontalY = CGRectGetHeight(self.popoverHorizontalFrame) / 5;
            } break;
            case PopPositionMiddle: {
                Y = (CGRectGetHeight(self.frame) - size.height) / 2;
                verticalY = (CGRectGetHeight(self.popoverVerticalFrame) - verticalSize.height) / 2;
                horizontalY = (CGRectGetHeight(self.popoverHorizontalFrame) - horizontalSize.height) / 2;
            } break;
            case PopPositionBottom: {
                Y = CGRectGetHeight(self.frame) - CGRectGetHeight(self.frame) / 5 - size.height;
                verticalY = CGRectGetHeight(self.popoverVerticalFrame) - CGRectGetHeight(self.popoverVerticalFrame) / 5 - verticalSize.height;
                horizontalY = CGRectGetHeight(self.popoverHorizontalFrame) - CGRectGetHeight(self.popoverHorizontalFrame) / 5 - horizontalSize.height;
            } break;
        }
    }

    self.contentViewVerticalFrame = CGRectMake(verticalX, verticalY, verticalSize.width, verticalSize.height);
    self.contentViewHorizontalFrame = CGRectMake(horizontalX, horizontalY, horizontalSize.width, horizontalSize.height);

    Toasty *toast = [[Toasty alloc] initWithFrame:CGRectMake(X, Y, size.width, size.height) toastyModel:model maxWidth:CGRectGetWidth(self.frame) - 80.0];
    [self addSubview:toast];
    self.contentView = toast;

    if (appearBlock) {
        appearBlock(toast);
    }

    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        if (!model.stay) {
            CGFloat time = model.interval > 0 ? model.interval : DefaulToastyTinterval;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
            });
        }
    }];
}

#pragma mark - Progress Methods
#pragma mark - Public Methods
/// 显示 Progress 方法 （显示在window）
+ (void)popProgressOnWindowWithText:(NSString *)text {
    ProgressModel *model = [[ProgressModel alloc] init];
    model.text = text;
    [self popProgressOnView:[self keyView] progressModel:model appearBlock:nil];
}

/// 显示 Toast 方法 (显示在指定UIView)
+ (void)popProgressOnView:(UIView *)view text:(NSString *)text {
    ProgressModel *model = [[ProgressModel alloc] init];
    model.text = text;
    [self popProgressOnView:view progressModel:model appearBlock:nil];
}

/// 显示 Toast 方法 (显示在指定UIView，并且制定topOffset)
+ (void)popProgressOnView:(UIView *)view text:(NSString *)text topOffset:(CGFloat)topOffset {
    ProgressModel *model = [[ProgressModel alloc] init];
    model.text = text;
    model.topOffset = topOffset;
    [self popProgressOnView:view progressModel:model appearBlock:nil];
}

/// 显示 Progress 方法 （显示在window）
+ (void)popProgressOnWindowWithProgressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock {
    [self popProgressOnView:[self keyView] progressModel:model appearBlock:appearBlock];
}

/// 显示 Progress 方法 （显示在window）
+ (void)popProgressOnWindowWithText:(NSString *)text appearBlock:(PopoverWillAppear)appearBlock {
    ProgressModel *model = [[ProgressModel alloc] init];
    model.text = text;
    [self popProgressOnView:[self keyView] progressModel:model appearBlock:appearBlock];
}

/// 显示 Toast 方法 (显示在指定UIView)
+ (void)popProgressOnView:(UIView *)view text:(NSString *)text appearBlock:(PopoverWillAppear)appearBlock {
    ProgressModel *model = [[ProgressModel alloc] init];
    model.text = text;
    [self popProgressOnView:view progressModel:model appearBlock:appearBlock];
}

/// 显示 Toast 方法 (显示在指定UIView)
+ (void)popProgressOnView:(UIView *)view progressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock {
    CGFloat width = CGRectGetWidth(view.bounds);
    CGFloat height = CGRectGetHeight(view.bounds);
    if (!view || width == 0 || height == 0) {
        return;
    }

    for (id pop in view.subviews) {
        if ([pop isKindOfClass:[Popover class]]) {
            [pop removeFromSuperview];
        }
    }

    Popover *pop = [[Popover alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    pop.popPosition = PopPositionMiddle;
    pop.backgroundColor = model.showMaskView ? [UIColor colorWithHexString:MaskColor alpha:BgColorAlpha] : [UIColor clearColor];
    [view addSubview:pop];
    [pop showProgressWithProgressModel:model appearBlock:appearBlock];
}

#pragma mark - Private Methods
- (void)showProgressWithProgressModel:(ProgressModel *)model appearBlock:(PopoverWillAppear)appearBlock {
    self.popType = PopTypeProgress;

    CGSize size = [Progress ProgressSizeWithText:model.text];
    CGFloat X = (CGRectGetWidth(self.frame) - size.width) / 2;
    CGFloat Y = 0;
    CGFloat verticalX = (CGRectGetWidth(self.popoverVerticalFrame) - size.width) / 2;
    CGFloat verticalY = 0;

    CGFloat horizontalX = (CGRectGetWidth(self.popoverHorizontalFrame) - size.width) / 2;
    CGFloat horizontalY = 0;

    if (model.topOffset >= 0) {
        Y = model.topOffset;
    } else {
        switch (self.popPosition) {
            case PopPositionTop: {
                Y = CGRectGetHeight(self.frame) / 5;
                verticalY = CGRectGetHeight(self.popoverVerticalFrame) / 5;
                horizontalY = CGRectGetHeight(self.popoverHorizontalFrame) / 5;
            } break;
            case PopPositionMiddle: {
                Y = (CGRectGetHeight(self.frame) - size.height) / 2;
                verticalY = (CGRectGetHeight(self.popoverVerticalFrame) - size.height) / 2;
                horizontalY = (CGRectGetHeight(self.popoverHorizontalFrame) - size.height) / 2;
            } break;
            case PopPositionBottom: {
                Y = CGRectGetHeight(self.frame) - CGRectGetHeight(self.frame) / 5 - size.height;
                verticalY = CGRectGetHeight(self.popoverVerticalFrame) - CGRectGetHeight(self.popoverVerticalFrame) / 5 - size.height;
                horizontalY = CGRectGetHeight(self.popoverHorizontalFrame) - CGRectGetHeight(self.popoverHorizontalFrame) / 5 - size.height;
            } break;
        }
    }

    self.contentViewVerticalFrame = CGRectMake(verticalX, verticalY, size.width, size.height);
    self.contentViewHorizontalFrame = CGRectMake(horizontalX, horizontalY, size.width, size.height);

    Progress *progress = [[Progress alloc] initWithFrame:CGRectMake(X, Y, size.width, size.height) model:model];
    [self addSubview:progress];
    self.contentView = progress;

    if (appearBlock) {
        appearBlock(progress);
    }

    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        if (!model.stay) {
            CGFloat time = model.interval > 0 ? model.interval : DefaulToastyTinterval;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
            });
        }
    }];
}

#pragma mark - Common Publick
/// 移除Window上的所有Popover
+ (void)removePopoverOnWindow {
    [self removePopoverOnView:[self keyView]];
}

/// /// 移除指定View上的所有Popover
+ (void)removePopoverOnView:(UIView *)view {
    for (id subview in view.subviews) {
        if ([subview isKindOfClass:[Popover class]]) {
            Popover *pop = (Popover *)subview;
            [UIView animateWithDuration:0.2 animations:^{
                pop.alpha = 0;
            } completion:^(BOOL finished) {
                [pop removeFromSuperview];
            }];
        }
    }
}

///  移除指定View上的所有Progress
/// @param view 父视图
+ (void)removeProgressOnView:(UIView *)view {
    for (id subview in view.subviews) {
        if ([subview isKindOfClass:[Popover class]]) {
            Popover *pop = (Popover *)subview;
            if (pop.popType == PopTypeProgress) {
                [UIView animateWithDuration:0.2 animations:^{
                    pop.alpha = 0;
                } completion:^(BOOL finished) {
                    [pop removeFromSuperview];
                }];
            }
        }
    }
}

@end
