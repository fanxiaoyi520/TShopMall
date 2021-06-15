//
//  TSCheckedView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSCheckedView.h"

@interface TSCheckedView ()

/** 阅读并同意按钮 */
@property(nonatomic, weak) UIButton *protocolButton;
/** check按钮 */
@property(nonatomic, weak) UIButton *checkButton;
/** 服务协议 */
@property(nonatomic, weak) UIButton *seviceButton;
/** 隐私协议 */
@property(nonatomic, weak) UIButton *privateButton;
/** 注册协议 */
@property(nonatomic, weak) UIButton *registerProtocolButton;
@end

@implementation TSCheckedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints {
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(10);
    }];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.protocolButton.mas_centerY).with.offset(0);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        make.right.equalTo(self.protocolButton.mas_left).with.offset(-6);
    }];
    [self.privateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(20);
        make.top.equalTo(self.protocolButton.mas_bottom).with.offset(-5);
    }];
    [self.seviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.privateButton.mas_centerY).with.offset(0);
        make.right.equalTo(self.privateButton.mas_left).with.offset(0);
    }];
    [self.registerProtocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.privateButton.mas_centerY).with.offset(0);
        make.left.equalTo(self.privateButton.mas_right).with.offset(0);
    }];
}

- (UIButton *)checkButton {
    if (_checkButton == nil) {
        UIButton *checkButton = [[UIButton alloc] init];
        _checkButton = checkButton;
        _checkButton.selected = YES;
        _checked = YES;
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_uncheck") forState:UIControlStateNormal];
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_checked") forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(checkingAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UIButton *)protocolButton {
    if (_protocolButton == nil) {
        UIButton *protocolButton = [[UIButton alloc] init];
        _protocolButton = protocolButton;
        _protocolButton.titleLabel.font = KRegularFont(14);
        [_protocolButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
        [_protocolButton setTitle:@"登录表示您已阅读并同意" forState:UIControlStateNormal];
        [self addSubview:_protocolButton];
    }
    return _protocolButton;
}

- (UIButton *)seviceButton {
    if (_seviceButton == nil) {
        UIButton *seviceButton = [[UIButton alloc] init];
        _seviceButton = seviceButton;
        _seviceButton.titleLabel.font = [UIFont font:PingFangSCMedium size:14];
        [_seviceButton setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [_seviceButton setTitle:@"服务协议、" forState:UIControlStateNormal];
        [_seviceButton addTarget:self action:@selector(goToServiceProtocol) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_seviceButton];
    }
    return _seviceButton;
}

- (UIButton *)privateButton {
    if (_privateButton == nil) {
        UIButton *privateButton = [[UIButton alloc] init];
        _privateButton = privateButton;
        _privateButton.titleLabel.font = [UIFont font:PingFangSCMedium size:14];
        [_privateButton setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [_privateButton setTitle:@"隐私政策、" forState:UIControlStateNormal];
        [_privateButton addTarget:self action:@selector(goToPrivatePolicy) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_privateButton];
    }
    return _privateButton;
}

- (UIButton *)registerProtocolButton {
    if (_registerProtocolButton == nil) {
        UIButton *registerProtocolButton = [[UIButton alloc] init];
        _registerProtocolButton = registerProtocolButton;
        _registerProtocolButton.titleLabel.font = [UIFont font:PingFangSCMedium size:14];
        [_registerProtocolButton setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [_registerProtocolButton setTitle:@"注册协议" forState:UIControlStateNormal];
        [_registerProtocolButton addTarget:self action:@selector(goToRegisterProtocol) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerProtocolButton];
    }
    return _registerProtocolButton;
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    self.checkButton.selected = checked;
    if ([self.delegate respondsToSelector:@selector(checkedAction:)]) {
        [self.delegate checkedAction:checked];
    }
}

#pragma mark - Public Method


#pragma mark - Actions

- (void)checkingAction {
    self.checkButton.selected = !self.checkButton.isSelected;
    _checked = self.checkButton.isSelected;
    if ([self.delegate respondsToSelector:@selector(checkedAction:)]) {
        [self.delegate checkedAction:self.isChecked];
    }
}

- (void)goToServiceProtocol {
    if ([self.delegate respondsToSelector:@selector(goToServiceProtocol)]) {
        [self.delegate goToServiceProtocol];
    }
}

- (void)goToPrivatePolicy {
    if ([self.delegate respondsToSelector:@selector(goToPrivatePolicy)]) {
        [self.delegate goToPrivatePolicy];
    }
}

- (void)goToRegisterProtocol {
    if ([self.delegate respondsToSelector:@selector(goToRegisterProtocol)]) {
        [self.delegate goToRegisterProtocol];
    }
}
@end
