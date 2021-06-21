//
//  UIView+DefaultPageView.m
//  NavBar
//
//  Created by Doman on 2017/5/2.
//  Copyright © 2017年 Doman. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <objc/runtime.h>

#import "RefreshGifHeader.h"

#import "UIColor+Plugin.h"
#import "UIImage+Plugin.h"
#import "UILabel+size.h"
#import "UIView+DefaultPageView.h"


#pragma mark - DefaultPageView


@interface DefaultPageView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) RefreshGifHeader *header;
@property (nonatomic, assign) UIEdgeInsets inserts;

@end


@implementation DefaultPageView

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                        title:(NSString *)title
                         tips:(NSString *)tips
                   buttonText:(NSString *)buttonText
                      inserts:(UIEdgeInsets)inserts {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self showImage:image title:title tips:tips buttonText:buttonText inserts:inserts];
    }

    return self;
}

- (void)showImage:(UIImage *)image title:(NSString *)title tips:(NSString *)tips buttonText:(NSString *)buttonText inserts:(UIEdgeInsets)inserts {
    [_imageView removeFromSuperview];
    [_titleLabel removeFromSuperview];
    [_tipLabel removeFromSuperview];
    [_refreshButton removeFromSuperview];
    [_scrollView removeFromSuperview];

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.scrollEnabled = NO;
    [self addSubview:self.scrollView];

    _header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
    _header.indicatorStyle = IndicatorStyleRed;
    _header.automaticallyChangeAlpha = YES;
    self.scrollView.mj_header = _header;

    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:self.imageView];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView.mas_centerY).offset(-30);
        make.centerX.equalTo(self.scrollView.mas_centerX);
    }];

    if (title.length > 0) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.font = [UIFont systemFontOfSize:18.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#2D3132"];
        self.titleLabel.text = title;
        [self.scrollView addSubview:self.titleLabel];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.scrollView.mas_centerX);
            make.left.equalTo(self.scrollView.mas_left).offset(40.0);
            make.top.equalTo(self.imageView.mas_bottom).offset(16.0);
            make.height.mas_equalTo(28.0);
        }];
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8.0;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributeDic = @{
        NSFontAttributeName: [UIFont systemFontOfSize:14.0],
        NSParagraphStyleAttributeName: paragraphStyle,
        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#2D3132"]
    };

    NSString *formatTips = tips ? tips : @"";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:formatTips attributes:attributeDic];

    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.numberOfLines = 0;
    self.tipLabel.attributedText = attributedString;
    [self.scrollView addSubview:self.tipLabel];

    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.left.equalTo(self.scrollView.mas_left).offset(16.0);
        if (title.length > 0) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16.0);
        } else {
            make.top.equalTo(self.imageView.mas_bottom).offset(16.0);
        }
    }];

    if (buttonText.length > 0) {
        self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.refreshButton setTitle:buttonText forState:UIControlStateNormal];
        [self.refreshButton setTitleColor:[UIColor colorWithHexString:@"#E64C3D"] forState:UIControlStateNormal];
        [self.refreshButton setTitleColor:[UIColor colorWithHexString:@"#E64C3D" alpha:0.6] forState:UIControlStateHighlighted];
        [self.refreshButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FFFFFF"]] forState:UIControlStateNormal];
        [self.refreshButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.6]] forState:UIControlStateHighlighted];
        self.refreshButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        self.refreshButton.layer.cornerRadius = 19.0;
        self.refreshButton.layer.borderWidth = 1.0;
        self.refreshButton.layer.borderColor = [UIColor colorWithHexString:@"#E64C3D"].CGColor;
        self.refreshButton.clipsToBounds = YES;
        [self.scrollView addSubview:self.refreshButton];
        [self.refreshButton addTarget:self action:@selector(clickReloadButton) forControlEvents:UIControlEventTouchUpInside];

        CGFloat width = [UILabel labelSizehWithText:buttonText font:self.refreshButton.titleLabel.font].width;
        width = width < 84.0 ? 84.0 : width;

        [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.scrollView.mas_centerX);
            make.top.equalTo(self.tipLabel.mas_bottom).offset(16.0);
            make.height.mas_equalTo(38.0);
            make.width.mas_equalTo(width + 20.0);
        }];
    }
}

- (void)setDidPulledDownBlock:(void (^)(void))didPulledDownBlock {
    _didPulledDownBlock = didPulledDownBlock;

    if (_didPulledDownBlock) {
        self.scrollView.scrollEnabled = YES;
    }
}

- (void)clickReloadButton {
    if (_didClickReloadBlock) {
        _didClickReloadBlock();
    }
}

- (void)pullDown {
    if (_didPulledDownBlock) {
        _didPulledDownBlock();
    }
}

@end

#pragma mark - UIView (DefaultPageView)


@interface UIView ()

@property (nonatomic, copy) void (^reloadAction)(void);

@property (nonatomic, copy) void (^pullDownAction)(void);

@end


@implementation UIView (DefaultPageView)

- (void)setReloadAction:(void (^)(void))reloadAction {
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))reloadAction {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPullDownAction:(void (^)(void))pullDownAction {
    objc_setAssociatedObject(self, @selector(pullDownAction), pullDownAction, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))pullDownAction {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDefaultPageView:(DefaultPageView *)defaultPageView {
    [self willChangeValueForKey:NSStringFromSelector(@selector(defaultPageView))];
    objc_setAssociatedObject(self, @selector(defaultPageView), defaultPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(defaultPageView))];
}

- (DefaultPageView *)defaultPageView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)configReloadAction:(void (^)(void))block {
    self.reloadAction = block;
    if (self.defaultPageView && self.reloadAction) {
        self.defaultPageView.didClickReloadBlock = self.reloadAction;
    }
}

- (void)configPullDownAction:(void (^)(void))block {
    self.pullDownAction = block;
    if (self.defaultPageView && self.pullDownAction) {
        self.defaultPageView.didPulledDownBlock = self.pullDownAction;
    }
}

- (void)showDefaultPageView {
    [self showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"无可用网络，点击重试" buttonText:@"刷新"];
}

- (void)showDefaultPageViewWithImage:(UIImage *)image tips:(NSString *)tips {
    [self showDefaultPageViewWithImage:image title:nil tips:tips buttonText:nil inserts:UIEdgeInsetsZero];
}

- (void)showDefaultPageViewWithImage:(UIImage *)image tips:(NSString *)tips buttonText:(NSString *)buttonText inserts:(UIEdgeInsets)inserts {
    [self showDefaultPageViewWithImage:image title:nil tips:tips buttonText:buttonText inserts:inserts];
}

- (void)showDefaultPageViewWithImage:(UIImage *)image tips:(NSString *)tips buttonText:(NSString *)buttonText {
    [self showDefaultPageViewWithImage:image title:nil tips:tips buttonText:buttonText inserts:UIEdgeInsetsZero];
}

- (void)showDefaultPageViewWithImage:(UIImage *)image
                               title:(NSString *)title
                                tips:(NSString *)tips
                          buttonText:(NSString *)buttonText
                             inserts:(UIEdgeInsets)inserts {
    if (!self.defaultPageView) {
        CGRect defaultPageViewFrame = CGRectMake(inserts.left, inserts.top, CGRectGetWidth(self.frame) - inserts.left - inserts.right,
                                                 CGRectGetHeight(self.frame) - inserts.top - inserts.bottom);
        self.defaultPageView = [[DefaultPageView alloc] initWithFrame:defaultPageViewFrame image:image title:title tips:tips buttonText:buttonText
                                                              inserts:inserts];
        if (self.reloadAction) {
            self.defaultPageView.didClickReloadBlock = self.reloadAction;
        }

        if (self.pullDownAction) {
            self.defaultPageView.didPulledDownBlock = self.pullDownAction;
        }
    } else {
        [self.defaultPageView showImage:image title:title tips:tips buttonText:buttonText inserts:inserts];
    }
    [self addSubview:self.defaultPageView];
    [self bringSubviewToFront:self.defaultPageView];
}

- (void)hideDefaultPageView {
    if (self.defaultPageView) {
        [self.defaultPageView removeFromSuperview];
        self.defaultPageView = nil;
    }
}

@end
