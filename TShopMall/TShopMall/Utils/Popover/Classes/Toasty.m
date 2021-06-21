//
//  Toasty.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "Toasty.h"

#import "UIColor+Plugin.h"
#import "UILabel+Size.h"

// 内容距离上下左右的间隔，以及内容之间的横向和纵向间隔
static const CGFloat LeftGap = 24.0;
static const CGFloat TopGap = 7.0;
static const CGFloat RightGap = 24.0;
static const CGFloat BottomGap = 7.0;
static const CGFloat HGap = 6.0;
static const CGFloat VGap = 5.0;

// 图片宽高
static const CGFloat ImageWidth = 18.0;
static const CGFloat ImageHeight = 18.0;

// 默认字体大小
static const CGFloat TitleFontSize = 15.0;
static const CGFloat SubTitleFontSize = 14.0;

//默认颜色
static const CGFloat BgColorAlpha = 0.6;
#define BgColor @"#000000"
#define TitleColor @"#FFFFFF"
#define SubTitleColor @"#FFFFFF"


@implementation ToastyModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.topOffset = -1;
    }
    return self;
}

- (void)setType:(ToastyType)type {
    _type = type;

    switch (_type) {
        case ToastyTypeNormal:
            break;
        case ToastyTypeSuccess: {
            self.image = [UIImage imageNamed:@"Toast_Success"];
        } break;
        case ToastyTypeFailure: {
            self.image = [UIImage imageNamed:@"Toast_Failure"];
        } break;
        case ToastyTypeInformation: {
            self.image = [UIImage imageNamed:@"Toast_Info"];
        } break;
    }
}

@end


@interface Toasty ()

@property (nonatomic, assign) CGFloat maxWidth;

/// 主标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 副标题
@property (nonatomic, strong) UILabel *subTitleLabel;
/// 图片控件
@property (nonatomic, strong) UIImageView *imageView;

/// 模型
@property (nonatomic, strong) ToastyModel *model;

@end


@implementation Toasty

#pragma mark - Init Methods
/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame toastyModel:(ToastyModel *)toastyModel maxWidth:(CGFloat)maxWidth {
    self = [super initWithFrame:frame];
    if (self) {
        _maxWidth = maxWidth;
        _model = toastyModel;
        [self setUpDetailUI];
    }
    return self;
}

/// 改变布局
- (void)changeFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth {
    self.frame = frame;
    _maxWidth = maxWidth;
    if (_model) {
        [self setUpDetailUI];
    }
}

#pragma mark - UI Methods
- (void)setUpDetailUI {
    // bgColor
    self.bgColor = [UIColor colorWithHexString:BgColor alpha:BgColorAlpha];

    // cornerRadius
    self.cornerRadius = CGRectGetHeight(self.frame) / 2;

    // titleLabel
    if (_model.title.length > 0) {
        self.titleColor = [UIColor colorWithHexString:TitleColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:TitleFontSize];
        self.titleLabel.text = _model.title;
    }

    // subTitleLabel
    if (_model.subTitle.length > 0) {
        self.subTitleColor = [UIColor colorWithHexString:SubTitleColor];
        self.subTitleLabel.font = [UIFont systemFontOfSize:SubTitleFontSize];
        self.subTitleLabel.text = _model.subTitle;
    }

    // imageView
    if (_model.image) {
        self.imageView.image = _model.image;
    }

    switch (_model.imageTextPosition) {
        case ImageLeftTextRight: {
            CGFloat X = LeftGap;
            CGFloat Y = TopGap;
            if (_model.image) {
                self.imageView.frame = CGRectMake(X, (CGRectGetHeight(self.frame) - ImageHeight) / 2, ImageWidth, ImageHeight);
                X += (ImageWidth + HGap);
            }
            if (_model.title.length > 0) {
                UIFont *titleFont = [UIFont boldSystemFontOfSize:TitleFontSize];
                CGFloat titleWidth = CGRectGetWidth(self.frame) - X - RightGap;
                CGFloat titleHeight = [UILabel labelHeightWithText:_model.title width:titleWidth font:titleFont];

                if (_model.subTitle.length == 0) {
                    Y = (CGRectGetHeight(self.frame) - titleHeight) / 2;
                }
                self.titleLabel.frame = CGRectMake(X, Y, titleWidth, titleHeight);
                Y += (titleHeight + VGap);
            }
            if (_model.subTitle.length > 0) {
                UIFont *subtitleFont = [UIFont boldSystemFontOfSize:SubTitleFontSize];
                CGFloat subtitleWidth = CGRectGetWidth(self.frame) - X - RightGap;
                CGFloat subtitleHeight = [UILabel labelHeightWithText:_model.subTitle width:subtitleWidth font:subtitleFont];

                if (_model.title.length == 0) {
                    Y = (CGRectGetHeight(self.frame) - subtitleHeight) / 2;
                }
                self.subTitleLabel.frame = CGRectMake(X, Y, subtitleWidth, subtitleHeight);
            }
        } break;
        case ImageRightTextLeft: {
            CGFloat X = LeftGap;
            CGFloat Y = TopGap;
            if (_model.title.length > 0) {
                UIFont *titleFont = [UIFont boldSystemFontOfSize:TitleFontSize];
                CGFloat titleWidth = CGRectGetWidth(self.frame) - LeftGap - RightGap;
                if (_model.image) {
                    titleWidth = titleWidth - ImageWidth - HGap;
                }
                CGFloat titleHeight = [UILabel labelHeightWithText:_model.title width:titleWidth font:titleFont];

                if (_model.subTitle.length == 0) {
                    Y = (CGRectGetHeight(self.frame) - titleHeight) / 2;
                }
                self.titleLabel.frame = CGRectMake(X, Y, titleWidth, titleHeight);
                Y += (titleHeight + VGap);
            }
            if (_model.subTitle.length > 0) {
                UIFont *subtitleFont = [UIFont boldSystemFontOfSize:SubTitleFontSize];
                CGFloat subtitleWidth = CGRectGetWidth(self.frame) - LeftGap - RightGap;
                if (_model.image) {
                    subtitleWidth = subtitleWidth - ImageWidth - HGap;
                }
                CGFloat subtitleHeight = [UILabel labelHeightWithText:_model.subTitle width:subtitleWidth font:subtitleFont];

                if (_model.title.length == 0) {
                    Y = (CGRectGetHeight(self.frame) - subtitleHeight) / 2;
                }
                self.subTitleLabel.frame = CGRectMake(X, Y, subtitleWidth, subtitleHeight);
            }
            if (_model.image) {
                self.imageView.frame =
                    CGRectMake(CGRectGetWidth(self.frame) - ImageWidth - RightGap, (CGRectGetHeight(self.frame) - ImageHeight) / 2, ImageWidth, ImageHeight);
            }
        } break;
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

- (void)setSubTitleColor:(UIColor *)subTitleColor {
    if (!subTitleColor) {
        return;
    }
    _subTitleColor = subTitleColor;
    self.subTitleLabel.textColor = _subTitleColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.clipsToBounds = YES;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.numberOfLines = 0;
        [self addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark - Size
/// 获取ToastSize
+ (CGSize)toastySizeWithToastyModel:(ToastyModel *)toastyModel maxWidth:(CGFloat)maxWidth {
    CGFloat width = 0;
    CGFloat height = 0;

    UIFont *titleFont = [UIFont boldSystemFontOfSize:TitleFontSize];
    CGSize titleLabelSize = [UILabel labelSizehWithText:toastyModel.title font:titleFont];

    UIFont *subTitleFont = [UIFont systemFontOfSize:SubTitleFontSize];
    CGSize subTitleLabelSize = [UILabel labelSizehWithText:toastyModel.subTitle font:subTitleFont];

    width = titleLabelSize.width > subTitleLabelSize.width ? titleLabelSize.width : subTitleLabelSize.width;
    width += (LeftGap + RightGap);

    if (toastyModel.image) {
        width += (ImageWidth + HGap);
    }

    if (width > maxWidth) {
        width = maxWidth;

        CGFloat textWidth = 0;

        if (toastyModel.image) {
            textWidth = width - (ImageWidth + HGap);
        }

        textWidth = width - (LeftGap + RightGap);

        if (toastyModel.title.length > 0) {
            height += [UILabel labelHeightWithText:toastyModel.title width:textWidth font:titleFont];
        }

        if (toastyModel.subTitle.length > 0) {
            height += [UILabel labelHeightWithText:toastyModel.subTitle width:textWidth font:subTitleFont];
        }
    } else {
        if (toastyModel.title.length > 0) {
            height += titleLabelSize.height;
        }
        if (toastyModel.subTitle.length > 0) {
            height += subTitleLabelSize.height;
        }
    }

    if (toastyModel.title.length > 0 && toastyModel.subTitle.length > 0) {
        height += VGap;
    }

    height = height > ImageHeight ? height : ImageHeight;
    height += (TopGap + BottomGap);

    return CGSizeMake(width, height);
}

@end
