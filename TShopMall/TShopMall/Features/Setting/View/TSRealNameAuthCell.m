//
//  TSRealNameAuthCell.m
//  TShopMall
//
//  Created by edy on 2021/6/22.
//

#import "TSRealNameAuthCell.h"

@interface TSRealNameAuthCell ()<UITextFieldDelegate>
/** 提示语的父视图  */
@property(nonatomic, weak) UIView *tipsView;
/** 提示语  */
@property(nonatomic, weak) UILabel *tipsLabel;
/** 标题  */
@property(nonatomic, weak) UILabel *titleLabel;
/** 副标题  */
@property(nonatomic, weak) UILabel *subtitleLabel;
/** 证件类型  */
@property(nonatomic, weak) UILabel *idTypeLabel;
/** 身份证  */
@property(nonatomic, weak) UILabel *idcardLabel;
/** 姓名  */
@property(nonatomic, weak) UILabel *realnameLabel;
/** 姓名输入框 */
@property(nonatomic, weak) UITextField *nameTextField;
/** 证件号 */
@property(nonatomic, weak) UILabel *idNumLabel;
/** 身份证输入框 */
@property(nonatomic, weak) UITextField *idNumTextField;
/** check按钮 */
@property(nonatomic, weak) UIButton *checkButton;
/** 已阅读并同意签署 */
@property(nonatomic, weak) UIButton *agreeButton;
/** 《实名认证服务协议》 */
@property(nonatomic, weak) UIButton *agreementButton;
/** remain签署协议提示语  */
@property(nonatomic, weak) UILabel *remainLabel;
/** 提交按钮 */
@property(nonatomic, weak) UIButton *commitButton;
@end

@implementation TSRealNameAuthCell


- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsView.mas_left).with.offset(16);
        make.centerY.equalTo(self.tipsView.mas_centerY).with.offset(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.top.equalTo(self.tipsView.mas_bottom).with.offset(16);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(3);
    }];
    [self.idTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.top.equalTo(self.subtitleLabel.mas_bottom).with.offset(33);
    }];
    [self.idcardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.centerY.equalTo(self.idTypeLabel.mas_centerY).with.offset(0);
    }];
    [self.realnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.top.equalTo(self.idTypeLabel.mas_bottom).with.offset(33);
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.left.equalTo(self.realnameLabel.mas_right).with.offset(-16);
        make.centerY.equalTo(self.realnameLabel.mas_centerY).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.idNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.top.equalTo(self.realnameLabel.mas_bottom).with.offset(33);
    }];
    [self.idNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.left.equalTo(self.idNumLabel.mas_right).with.offset(-16);
        make.centerY.equalTo(self.idNumLabel.mas_centerY).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(37);
        make.top.equalTo(self.idNumLabel.mas_bottom).with.offset(33);
        make.width.height.mas_equalTo(18);
    }];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkButton.mas_right).with.offset(5);
        make.centerY.equalTo(self.checkButton.mas_centerY).with.offset(0);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(17);
    }];
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.agreeButton.mas_right).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.centerY.equalTo(self.agreeButton.mas_centerY).with.offset(0);
        make.height.mas_equalTo(17);
    }];
    [self.remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.agreeButton.mas_left).with.offset(0);
        make.top.equalTo(self.agreeButton.mas_bottom).with.offset(2);
        make.right.equalTo(self.contentView.mas_right).with.offset(-34);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainLabel.mas_bottom).offset(40);
        make.left.equalTo(self.contentView.mas_left).with.offset(24);
        make.right.equalTo(self.contentView.mas_right).with.offset(-24);
        make.height.mas_equalTo(40);
    }];
    
}

- (UIView *)tipsView {
    if (_tipsView == nil) {
        UIView *tipsView = [[UIView alloc] init];
        _tipsView = tipsView;
        _tipsView.backgroundColor = KHexColor(@"#FEF6E9");
        [self.contentView addSubview: _tipsView];
    }
    return _tipsView;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"实名认证有助于提升账户安全，投资支持有保障。";
        _tipsLabel.textColor = KHexColor(@"#8A5F2A");
        _tipsLabel.font = KRegularFont(14);
        [self.tipsView addSubview: _tipsLabel];
    }
    return _tipsLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"请填写您真实的身份信息";
        _titleLabel.textColor = KHexColor(@"#2F2F2F");
        _titleLabel.font = KRegularFont(18);
        [self.contentView addSubview: _titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (_subtitleLabel == nil) {
        UILabel *subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel = subtitleLabel;
        _subtitleLabel.text = @"通过后信息不可更改";
        _subtitleLabel.textColor = KHexColor(@"#989898");
        _subtitleLabel.font = KRegularFont(12);
        [self.contentView addSubview: _subtitleLabel];
    }
    return _subtitleLabel;
}

- (UILabel *)idTypeLabel {
    if (_idTypeLabel == nil) {
        UILabel *idTypeLabel = [[UILabel alloc] init];
        _idTypeLabel = idTypeLabel;
        _idTypeLabel.text = @"证件类型";
        _idTypeLabel.textColor = KTextColor;
        _idTypeLabel.font = KRegularFont(14);
        [self.contentView addSubview: _idTypeLabel];
    }
    return _idTypeLabel;
}

- (UILabel *)idcardLabel {
    if (_idcardLabel == nil) {
        UILabel *idcardLabel = [[UILabel alloc] init];
        _idcardLabel = idcardLabel;
        _idcardLabel.text = @"身份证";
        _idcardLabel.textColor = KTextColor;
        _idcardLabel.font = KRegularFont(14);
        [self.contentView addSubview: _idcardLabel];
    }
    return _idcardLabel;
}

- (UILabel *)realnameLabel {
    if (_realnameLabel == nil) {
        UILabel *realnameLabel = [[UILabel alloc] init];
        _realnameLabel = realnameLabel;
        _realnameLabel.text = @"姓名";
        _realnameLabel.textColor = KTextColor;
        _realnameLabel.font = KRegularFont(14);
        [self.contentView addSubview: _realnameLabel];
    }
    return _realnameLabel;
}

- (UILabel *)idNumLabel {
    if (_idNumLabel == nil) {
        UILabel *idNumLabel = [[UILabel alloc] init];
        _idNumLabel = idNumLabel;
        _idNumLabel.text = @"证件号";
        _idNumLabel.textColor = KTextColor;
        _idNumLabel.font = KRegularFont(14);
        [self.contentView addSubview: _idNumLabel];
    }
    return _idNumLabel;
}

- (UITextField *)nameTextField {
    if (_nameTextField == nil) {
        UITextField *nameTextField = [[UITextField alloc] init];
        _nameTextField = nameTextField;
        _nameTextField.delegate = self;
        _nameTextField.returnKeyType = UIReturnKeyNext;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.textColor = KHexColor(@"#2D3132");
        _nameTextField.font = KRegularFont(14);
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.4)}];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        [_nameTextField addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_idNumTextField];
        [self.contentView addSubview:_nameTextField];
    }
    return _nameTextField;
}

- (UITextField *)idNumTextField {
    if (_idNumTextField == nil) {
        UITextField *idNumTextField = [[UITextField alloc] init];
        _idNumTextField = idNumTextField;
        _idNumTextField.delegate = self;
        _idNumTextField.returnKeyType = UIReturnKeyDone;
        _idNumTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _idNumTextField.textColor = KHexColor(@"#2D3132");
        _idNumTextField.font = KRegularFont(14);
        _idNumTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.4)}];
        _idNumTextField.textAlignment = NSTextAlignmentRight;
        [_idNumTextField addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_idNumTextField];
    }
    return _idNumTextField;
}

- (UIButton *)checkButton {
    if (_checkButton == nil) {
        UIButton *checkButton = [[UIButton alloc] init];
        _checkButton = checkButton;
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_uncheck") forState:UIControlStateNormal];
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_checked") forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_checkButton];
    }
    return _checkButton;
}

- (UIButton *)agreeButton {
    if (_agreeButton == nil) {
        UIButton *agreeButton = [[UIButton alloc] init];
        _agreeButton = agreeButton;
        _agreeButton.titleLabel.font = KRegularFont(12);
        [_agreeButton setTitleColor:KHexColor(@"#989898") forState:UIControlStateNormal];
        [_agreeButton setTitle:@"我已阅读并同意签署" forState:(UIControlStateNormal)];
        [_agreeButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_agreeButton];
    }
    return _agreeButton;
}

- (UIButton *)agreementButton {
    if (_agreementButton == nil) {
        UIButton *agreementButton = [[UIButton alloc] init];
        _agreementButton = agreementButton;
        _agreementButton.titleLabel.font = KRegularFont(12);
        _agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_agreementButton setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [_agreementButton setTitle:@"《实名认证服务协议》" forState:(UIControlStateNormal)];
        [_agreementButton addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_agreementButton];
    }
    return _agreementButton;
}

- (UILabel *)remainLabel {
    if (_remainLabel == nil) {
        UILabel *remainLabel = [[UILabel alloc] init];
        _remainLabel = remainLabel;
        _remainLabel.text = @"根据中国人民银行及相关监督机构要求需要您填写以上信息，请您如实完善相关信息";
        _remainLabel.textColor = KHexColor(@"#989898");
        _remainLabel.numberOfLines = 0;
        _remainLabel.font = KRegularFont(12);
        [self.contentView addSubview: _remainLabel];
    }
    return _remainLabel;
}

- (UIButton *)commitButton {
    if (_commitButton == nil) {
        UIButton *commitButton = [[UIButton alloc] init];
        _commitButton = commitButton;
        _commitButton.backgroundColor = KHexColor(@"#DDDDDD");
        [_commitButton setCorners:UIRectCornerAllCorners radius:KRateW(20)];
        _commitButton.clipsToBounds = YES;
        _commitButton.titleLabel.font = KRegularFont(16);
        _commitButton.enabled = NO;
        [_commitButton setTitle:@"开始认证" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commitButton];
    }
    return _commitButton;
}

- (void)setCommitButtonStatus:(BOOL)enabled {
    if ((self.commitButton.enabled && !enabled) || (!self.commitButton.enabled && enabled)) {
        self.commitButton.enabled = enabled;
        self.commitButton.backgroundColor = enabled ? KHexColor(@"#FF4D49") : KHexColor(@"#DDDDDD");
    }
}

#pragma mark - Actions
- (void)checkAction {
    self.checkButton.selected = !self.checkButton.isSelected;
    if (self.nameTextField.text.length && self.idNumTextField.text.length && self.checkButton.isSelected) {
        [self setCommitButtonStatus:YES];
    } else {
        [self setCommitButtonStatus:NO];
    }
}

- (void)agreementAction {
    
}

- (void)commitAction {
    
}

#pragma mark- <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.nameTextField == textField) {
        [self.idNumTextField becomeFirstResponder];
    }
    return [textField resignFirstResponder];
}


#pragma mark - UIControlEventEditingChanged
- (void)textFieldDidChangeValue:(UITextField *)textfield {
    if (self.nameTextField.text.length && self.idNumTextField.text.length && self.checkButton.isSelected) {
        [self setCommitButtonStatus:YES];
    } else {
        [self setCommitButtonStatus:NO];
    }
}

@end
