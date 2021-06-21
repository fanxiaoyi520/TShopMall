//
//  TSQuickLoginTopView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSQuickLoginTopView.h"

@interface TSQuickLoginTopView ()
/** logo */
@property(nonatomic, weak) UIImageView *logoImgV;
/** phoneNumber 手机号 */
@property(nonatomic, weak) UILabel *phoneNumberLabel;
/** 快捷登录按钮 */
@property(nonatomic, weak) UIButton *quickLoginButton;
/** 其它登录方式 */
@property(nonatomic, weak) UIButton *otherLoginButton;
@end

@implementation TSQuickLoginTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints {
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.height.mas_equalTo(KRateW(96));
        make.width.mas_equalTo(KRateW(96));
    }];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.top.equalTo(self.logoImgV.mas_bottom).with.offset(8);
    }];
    [self.quickLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.top.equalTo(self.phoneNumberLabel.mas_bottom).with.offset(KRateH(80));
        make.height.mas_equalTo(KRateW(40));
    }];
    [self.otherLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.top.equalTo(self.quickLoginButton.mas_bottom).with.offset(16);
    }];
}

- (UIImageView *)logoImgV {
    if (_logoImgV == nil) {
        UIImageView *logoImgV = [[UIImageView alloc] init];
        _logoImgV = logoImgV;
        _logoImgV.image = KImageMake(@"mall_login_logo");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)phoneNumberLabel {
    if (_phoneNumberLabel == nil) {
        UILabel *phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel = phoneNumberLabel;
        _phoneNumberLabel.text = @"+86 185 2057 2715";
        _phoneNumberLabel.font = KRegularFont(18);
        _phoneNumberLabel.textColor = KTextColor;
        [self addSubview:_phoneNumberLabel];
    }
    return _phoneNumberLabel;
}

- (UIButton *)quickLoginButton {
    if (_quickLoginButton == nil) {
        UIButton *quickLoginButton = [[UIButton alloc] init];
        _quickLoginButton = quickLoginButton;
        _quickLoginButton.backgroundColor = KHexColor(@"#FF4D49");
        _quickLoginButton.layer.cornerRadius = KRateW(20);
        _quickLoginButton.clipsToBounds = YES;
        _quickLoginButton.titleLabel.font = KRegularFont(16);
        [_quickLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_quickLoginButton addTarget:self action:@selector(quickLogin) forControlEvents:UIControlEventTouchUpInside];
        [_quickLoginButton setTitle:@"本机号码一键登录" forState:UIControlStateNormal];
        
        [self addSubview:_quickLoginButton];
    }
    return _quickLoginButton;
}

- (UIButton *)otherLoginButton {
    if (_otherLoginButton == nil) {
        UIButton *otherLoginButton = [[UIButton alloc] init];
        _otherLoginButton = otherLoginButton;
        _otherLoginButton.titleLabel.font = KRegularFont(14);
        [_otherLoginButton setTitleColor:KHexAlphaColor(@"#2D3132", 0.6) forState:UIControlStateNormal];
        [_otherLoginButton setTitle:@"其它手机号登录" forState:UIControlStateNormal];
        [_otherLoginButton addTarget:self action:@selector(otherLogin) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_otherLoginButton];
    }
    return _otherLoginButton;
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = phoneNumber;
    self.phoneNumberLabel.text = phoneNumber;
}

#pragma mark - Actions
- (void)quickLogin {
    if ([self.quickDelegate respondsToSelector:@selector(quickLogin)]) {
        [self.quickDelegate quickLogin];
    }
}

- (void)otherLogin {
    if ([self.quickDelegate respondsToSelector:@selector(otherLogin)]) {
        [self.quickDelegate otherLogin];
    }
}

@end
