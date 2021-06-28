//
//  TSLoginTopView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSLoginTopView.h"
#import "TSTools.h"

@interface TSLoginTopView ()<UITextFieldDelegate>
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 副标题 */
@property(nonatomic, weak) UILabel *subtitleLabel;
/** 注册按钮 */
@property(nonatomic, weak) UIButton *registerButton;
/** 手机号输入框 */
@property(nonatomic, weak) UITextField *phoneInput;
/** 验证码输入框 */
@property(nonatomic, weak) UITextField *codeInput;
/** 验证码按钮 */
@property(nonatomic, weak) UIButton *codeButton;
/** 分隔线 */
@property(nonatomic, weak) UIView *splitPhoneView;
/** 分割线 */
@property(nonatomic, weak) UIView *splitCodeView;
/** 登录按钮 */
@property(nonatomic, weak) UIButton *loginButton;

@end

@implementation TSLoginTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraints];
    }
    return self;
}


- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.mas_top).with.offset(10);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subtitleLabel.mas_centerY).with.offset(0);
        make.left.equalTo(self.subtitleLabel.mas_right).with.offset(8);
    }];
    [self.phoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.subtitleLabel.mas_bottom).with.offset(KRateW(40));
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateW(53));
    }];
    [self.splitPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.phoneInput.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateW(0.33));
    }];
    [self.codeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.splitPhoneView.mas_bottom).with.offset(0);
        make.right.equalTo(self.codeButton.mas_left).with.offset(0);
        make.height.mas_equalTo(KRateW(53));
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.width.mas_equalTo(KRateW(67));
        make.height.mas_equalTo(KRateW(23));
        make.centerY.equalTo(self.codeInput.mas_centerY).with.offset(0);
    }];
    [self.splitCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.codeInput.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateH(0.33));
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.top.equalTo(self.splitCodeView.mas_bottom).with.offset(KRateH(60));
        make.height.mas_equalTo(KRateW(40));
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"欢迎登录TCL之家";
        _titleLabel.font = [UIFont font:PingFangSCMedium size:24];
        _titleLabel.textColor = KHexColor(@"#2D3132");
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (_subtitleLabel == nil) {
        UILabel *subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel = subtitleLabel;
        _subtitleLabel.text = @"没有TCL之家账号？";
        _subtitleLabel.font = [UIFont font:PingFangSCRegular size:16];
        _subtitleLabel.textColor = KHexColor(@"#2D3132");
        [self addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        UIButton *registerButton = [[UIButton alloc] init];
        _registerButton = registerButton;
        [_registerButton setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        _registerButton.titleLabel.font = KRegularFont(16);
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerButton];
    }
    return _registerButton;
}

- (UITextField *)phoneInput {
    if (_phoneInput == nil) {
        UITextField *phoneInput = [[UITextField alloc] init];
        _phoneInput = phoneInput;
        _phoneInput.keyboardType = UIKeyboardTypePhonePad;
        _phoneInput.textColor = KHexColor(@"#2D3132");
        _phoneInput.font = KRegularFont(16);
        _phoneInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        [_phoneInput addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_phoneInput];
    }
    return _phoneInput;
}

- (UITextField *)codeInput {
    if (_codeInput == nil) {
        UITextField *codeInput = [[UITextField alloc] init];
        _codeInput = codeInput;
        _codeInput.keyboardType = UIKeyboardTypeNumberPad;
        _codeInput.returnKeyType = UIReturnKeyDone;
        _codeInput.textColor = KHexColor(@"#2D3132");
        _codeInput.font = KRegularFont(16);
        _codeInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        _codeInput.delegate = self;
        [_codeInput addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_codeInput];
    }
    return _codeInput;
}

- (UIButton *)codeButton {
    if (_codeButton == nil) {
        UIButton *codeButton = [[UIButton alloc] init];
        _codeButton = codeButton;
        _codeButton.clipsToBounds = YES;
        _codeButton.enabled = NO;
        _codeButton.titleLabel.font = KRegularFont(11);
        [_codeButton setCorners:UIRectCornerAllCorners radius:2.5];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton setBackgroundColor:KHexColor(@"#D7D8D8")];
        [_codeButton setTitleColor:KWhiteColor forState:UIControlStateDisabled];
        [_codeButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_codeButton];
    }
    return _codeButton;
}

- (UIView *)splitPhoneView {
    if (_splitPhoneView == nil) {
        UIView *splitPhoneView = [[UIView alloc] init];
        _splitPhoneView = splitPhoneView;
        _splitPhoneView.backgroundColor = KHexColor(@"#E6E6E6");
        [self addSubview:_splitPhoneView];
    }
    return _splitPhoneView;
}

- (UIView *)splitCodeView {
    if (_splitCodeView == nil) {
        UIView *splitCodeView = [[UIView alloc] init];
        _splitCodeView = splitCodeView;
        _splitCodeView.backgroundColor = KHexColor(@"#E6E6E6");
        [self addSubview:_splitCodeView];
    }
    return _splitCodeView;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        UIButton *loginButton = [[UIButton alloc] init];
        _loginButton = loginButton;
        _loginButton.enabled = NO;
        _loginButton.backgroundColor = KHexColor(@"#DDDDDD");
        [_loginButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_loginButton setTitleColor:KWhiteColor forState:UIControlStateDisabled];
        [_loginButton setCorners:(UIRectCornerAllCorners) radius:KRateW(20)];
        _loginButton.clipsToBounds = YES;
        _loginButton.titleLabel.font = KRegularFont(16);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginButton];
    }
    return _loginButton;
}

#pragma mark - Public Method
- (void)setCodeButtonTitleAndColor:(NSString *)codeTitle isResend:(BOOL)isResend enabled:(BOOL)enabled {
    if (isResend) {
        self.codeButton.enabled = YES;
        self.codeButton.backgroundColor = KHexColor(@"#F9AB50");
        [self.codeButton setTitle:codeTitle forState:UIControlStateNormal];
    } else {
        if ((self.codeButton.isEnabled && !enabled) || (!self.codeButton.isEnabled && enabled)) {
            self.codeButton.backgroundColor = enabled ? KHexColor(@"#41A98F") : KHexColor(@"#D7D8D8");
            self.codeButton.enabled = enabled;
        }
        [self.codeButton setTitle:codeTitle forState:UIControlStateNormal];
    }
}

- (NSString *)getPhoneNumber {
    return self.phoneInput.text;
}

- (NSString *)getCode {
    return self.codeInput.text;
}

#pragma mark - Action
- (void)goToRegister {
    if ([self.delegate respondsToSelector:@selector(goToRegister)]) {
        [self.delegate goToRegister];
    }
}

- (void)login {
    if ([self.delegate respondsToSelector:@selector(login)]) {
        [self.delegate login];
    }
}

- (void)sendCode {
    if ([self.delegate respondsToSelector:@selector(sendCode)]) {
        [self.delegate sendCode];
    }
}

- (void)setLoginButtonEnable:(BOOL)isEnable {
    BOOL enable = isEnable && [TSTools isPhoneNumber: self.phoneInput.text] && self.codeInput.text.length;
    self.loginButton.enabled = enable;
    if (enable) {
        self.loginButton.backgroundColor = KHexColor(@"#FF4D49");
    } else {
        self.loginButton.backgroundColor = KHexColor(@"#DDDDDD");
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
}

#pragma mark - UIControlEventEditingChanged
- (void)textFieldDidChangeValue:(UITextField *)textfield {
    if ([TSTools isPhoneNumber:self.phoneInput.text] && textfield == self.phoneInput) {
        [self setCodeButtonTitleAndColor:@"获取验证码" isResend:NO enabled:YES];
    } else if ([TSTools isPhoneNumber:self.phoneInput.text] && textfield == self.codeInput) {
        if (self.codeInput.text.length && [self.delegate respondsToSelector:@selector(inputDoneAction)]) {
            if (!self.loginButton.enabled) {
                [self.delegate inputDoneAction];
            }
        } else {
            [self setLoginButtonEnable: NO];
        }
    } else {
        [self setCodeButtonTitleAndColor:@"获取验证码" isResend:NO enabled:NO];
        [self setLoginButtonEnable: NO];
    }

}

@end
