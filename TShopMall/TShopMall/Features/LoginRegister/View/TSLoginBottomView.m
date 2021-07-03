//
//  TSLoginBottomView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSLoginBottomView.h"

@interface TSLoginBottomView ()
/** 微信按钮 */
@property(nonatomic, weak) UIButton *wechatButton;
/** apple按钮 */
@property(nonatomic, weak) UIButton *appleButton;

@end

@implementation TSLoginBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints {
    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-60);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.equalTo(self);
    }];
    [self.appleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(60);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.equalTo(self);
    }];
}

- (UIButton *)wechatButton {
    if (_wechatButton == nil) {
        UIButton *wechatButton = [[UIButton alloc] init];
        _wechatButton = wechatButton;
        [_wechatButton setBackgroundImage:KImageMake(@"mall_login_wechat") forState:UIControlStateNormal];
        [_wechatButton addTarget:self action:@selector(goToWechat) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_wechatButton];
    }
    return _wechatButton;
}

- (UIButton *)appleButton {
    if (_appleButton == nil) {
        UIButton *appleButton = [[UIButton alloc] init];
        _appleButton = appleButton;
        [_appleButton setBackgroundImage:KImageMake(@"mall_login_apple") forState:UIControlStateNormal];
        [_appleButton addTarget:self action:@selector(goToApple) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_appleButton];
    }
    return _appleButton;
}

#pragma mark - Actions
- (void)goToWechat {
    if ([self.delegate respondsToSelector:@selector(goToWechat)]) {
        [self.delegate goToWechat];
    }
}

- (void)goToApple {
    if ([self.delegate respondsToSelector:@selector(goToApple)]) {
        [self.delegate goToApple];
    }
}

@end
