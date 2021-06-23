//
//  TSRegisterTopView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSRegisterTopView.h"

@interface TSRegisterTopView ()<UITextFieldDelegate>
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 副标题 */
@property(nonatomic, weak) UILabel *subtitleLabel;
/** 手机号输入框 */
@property(nonatomic, weak) UITextField *phoneInput;
/** 验证码输入框 */
@property(nonatomic, weak) UITextField *codeInput;
/** 邀请码输入框 */
@property(nonatomic, weak) UITextField *invitedCodeInput;
/** 验证码按钮 */
@property(nonatomic, weak) UIButton *codeButton;
/** 分隔线 */
@property(nonatomic, weak) UIView *splitPhoneView;
/** 分割线 */
@property(nonatomic, weak) UIView *splitCodeView;
/** 分割线 */
@property(nonatomic, weak) UIView *splitInvitedCodeView;
/** 注册按钮 */
@property(nonatomic, weak) UIButton *registerButton;

@end

@implementation TSRegisterTopView

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
    [self.phoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.subtitleLabel.mas_bottom).with.offset(KRateH(40));
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateW(53));
    }];
    [self.splitPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.phoneInput.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateH(0.33));
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
    [self.invitedCodeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.splitCodeView.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateW(53));
    }];
    [self.splitInvitedCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.invitedCodeInput.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(KRateH(0.33));
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.top.equalTo(self.splitInvitedCodeView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(KRateW(40));
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"手机号码注册";
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
        _subtitleLabel.text = @"欢迎注册TCL账号。";
        _subtitleLabel.font = [UIFont font:PingFangSCRegular size:16];
        _subtitleLabel.textColor = KHexColor(@"#2D3132");
        [self addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
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
        _codeInput.textColor = KHexColor(@"#2D3132");
        _codeInput.font = KRegularFont(16);
        _codeInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        [_codeInput addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_codeInput];
    }
    return _codeInput;
}

- (UITextField *)invitedCodeInput {
    if (_invitedCodeInput == nil) {
        UITextField *invitedCodeInput = [[UITextField alloc] init];
        _invitedCodeInput = invitedCodeInput;
        _invitedCodeInput.textColor = KHexColor(@"#2D3132");
        _invitedCodeInput.font = KRegularFont(16);
        _invitedCodeInput.returnKeyType = UIReturnKeyDone;
        _invitedCodeInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        [_invitedCodeInput addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        _invitedCodeInput.delegate = self;
        [self addSubview:_invitedCodeInput];
    }
    return _invitedCodeInput;
}

- (UIButton *)codeButton {
    if (_codeButton == nil) {
        UIButton *codeButton = [[UIButton alloc] init];
        _codeButton = codeButton;
        _codeButton.titleLabel.font = KRegularFont(11);
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton setBackgroundColor:KHexColor(@"#41A98F")];
        [_codeButton setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateDisabled];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setCorners:UIRectCornerAllCorners radius:2.5];
        _codeButton.clipsToBounds = YES;
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

- (UIView *)splitInvitedCodeView {
    if (_splitInvitedCodeView == nil) {
        UIView *splitInvitedCodeView = [[UIView alloc] init];
        _splitInvitedCodeView = splitInvitedCodeView;
        _splitInvitedCodeView.backgroundColor = KHexColor(@"#E6E6E6");
        [self addSubview:_splitInvitedCodeView];
    }
    return _splitInvitedCodeView;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        UIButton *registerButton = [[UIButton alloc] init];
        _registerButton = registerButton;
        _registerButton.backgroundColor = KHexColor(@"#DDDDDD");
        _registerButton.layer.cornerRadius = KRateW(20);
        _registerButton.clipsToBounds = YES;
        _registerButton.titleLabel.font = KRegularFont(16);
        _registerButton.enabled = NO;
        [_registerButton setTitle:@"同意协议并注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerButton];
    }
    return _registerButton;
}

#pragma mark - Public Method
- (void)setCodeButtonTitleAndColor:(NSString *)codeTitle isResend:(BOOL)isResend {
    if (isResend) {
        self.codeButton.enabled = YES;
        self.codeButton.backgroundColor = KHexColor(@"#F9AB50");
    } else {
        if (self.codeButton.isEnabled) {
            self.codeButton.backgroundColor = KHexColor(@"#D7D8D8");
            self.codeButton.enabled = NO;
        }
    }
    [self.codeButton setTitle:codeTitle forState:UIControlStateNormal];
}

- (NSString *)getPhoneNumber {
    return self.phoneInput.text;
}

- (NSString *)getCode {
    return self.codeInput.text;
}

- (void)setRegisterBtnEnable: (BOOL)isEnable {
    BOOL enable = isEnable && self.phoneInput.text.length && self.codeInput.text.length && self.invitedCodeInput.text.length;
    self.registerButton.enabled = enable;
    if (enable) {
        self.registerButton.backgroundColor = KHexColor(@"#FF4D49");
    } else {
        self.registerButton.backgroundColor = KHexColor(@"#DDDDDD");
    }
}

- (NSString *)getInvitationCode{
    return self.invitedCodeInput.text;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
}

#pragma mark - Actions
- (void)registerAction {
    if ([self.delegate respondsToSelector:@selector(registerAction)]) {
        [self.delegate registerAction];
    }
}

- (void)sendCode {
    if ([self.delegate respondsToSelector:@selector(sendCode)]) {
        [self.delegate sendCode];
    }
}

#pragma mark - UIControlEventEditingChanged
- (void)textFieldDidChangeValue:(UITextField *)textfield {
    if (self.phoneInput.text.length && self.codeInput.text.length && self.invitedCodeInput.text.length) {
        if ([self.delegate respondsToSelector:@selector(inputDoneAction)] && !self.registerButton.isEnabled) {
            [self.delegate inputDoneAction];
        }
    } else {
        if (self.registerButton.isEnabled) {
            [self setRegisterBtnEnable:NO];
        }
    }
}

@end
