//
//  TSBindMobileCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBindMobileCell.h"

@interface TSBindMobileCell ()
/** 已绑定的手机号文字显示 */
@property(nonatomic, weak) UILabel *phoneLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitTopView;
/** 手机号显示 */
@property(nonatomic, weak) UILabel *phoneNumLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitBottomView;
/** 新手机号输入框 */
@property(nonatomic, weak) UITextField *mobileTextField;
/** 验证码输入框 */
@property(nonatomic, weak) UITextField *codeTextField;
/** 验证码按钮 */
@property(nonatomic, weak) UIButton *codeButton;
/** 提交按钮 */
@property(nonatomic, weak) UIButton *commitButton;
/** 提示语 */
@property(nonatomic, weak) UILabel *tipsLabel;
/** 垂直分割线 */
@property(nonatomic, weak) UIView *verticalSplitView;
/** 出错提示 */
@property(nonatomic, weak) UILabel *errorTipsLabel;

@end


@implementation TSBindMobileCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(48);
    }];
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.phoneLabel.mas_bottom).with.offset(8);
    }];
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.top.equalTo(self.phoneNumLabel.mas_bottom).with.offset(24);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.height.mas_equalTo(56);
    }];
    [self.splitTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.mobileTextField.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.top.equalTo(self.splitTopView.mas_bottom).with.offset(0);
        make.right.equalTo(self.codeButton.mas_left).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.width.mas_equalTo(111);
        make.centerY.equalTo(self.codeTextField.mas_centerY).with.offset(0);
    }];
    [self.splitBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.codeTextField.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.errorTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.top.equalTo(self.splitBottomView.mas_bottom).with.offset(7);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.splitBottomView.mas_bottom).with.offset(41);
        make.height.mas_equalTo(41);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.commitButton.mas_bottom).with.offset(24);
    }];
    [self.verticalSplitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.codeButton.mas_left).with.offset(0);
        make.centerY.equalTo(self.codeButton.mas_centerY).with.offset(0);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(0.5);
    }];
}

- (UILabel *)phoneNumLabel {
    if (_phoneNumLabel == nil) {
        UILabel *phoneNumLabel = [[UILabel alloc] init];
        _phoneNumLabel = phoneNumLabel;
        _phoneNumLabel.text = @"133-7869-2380";
        _phoneNumLabel.textColor = KTextColor;
        _phoneNumLabel.font = KRegularFont(24);
        [self.contentView addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UILabel *)phoneLabel {
    if (_phoneLabel == nil) {
        UILabel *phoneLabel = [[UILabel alloc] init];
        _phoneLabel = phoneLabel;
        _phoneLabel.text = @"已绑定手机号";
        _phoneLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        _phoneLabel.font = KRegularFont(14);
        [self.contentView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"若验证码错误超过5次，24小时内将无法继续绑定。当前号码相关资料将迁移至新绑定号码，更换后原号码将无任何资料。";
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _tipsLabel.font = KRegularFont(12);
        _tipsLabel.numberOfLines = 0;
        [self.contentView addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

- (UILabel *)errorTipsLabel {
    if (_errorTipsLabel == nil) {
        UILabel *errorTipsLabel = [[UILabel alloc] init];
        _errorTipsLabel = errorTipsLabel;
        _errorTipsLabel.text = @"手机号已注册";
        _errorTipsLabel.textColor = KHexColor(@"#F7AF34");
        _errorTipsLabel.font = KRegularFont(12);
        _errorTipsLabel.numberOfLines = 0;
        [self.contentView addSubview:_errorTipsLabel];
    }
    return _errorTipsLabel;
}

- (UIView *)splitTopView {
    if (_splitTopView == nil) {
        UIView *splitTopView = [[UIView alloc] init];
        _splitTopView = splitTopView;
        _splitTopView.backgroundColor = KHexColor(@"#E6E6E6");
        [self.contentView addSubview:_splitTopView];
    }
    return _splitTopView;
}

- (UIView *)splitBottomView {
    if (_splitBottomView == nil) {
        UIView *splitBottomView = [[UIView alloc] init];
        _splitBottomView = splitBottomView;
        _splitBottomView.backgroundColor = KHexColor(@"#E6E6E6");
        [self.contentView addSubview:_splitBottomView];
    }
    return _splitBottomView;
}

- (UIButton *)codeButton {
    if (_codeButton == nil) {
        UIButton *codeButton = [[UIButton alloc] init];
        _codeButton = codeButton;
        _codeButton.titleLabel.font = KRegularFont(16);
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton setTitleColor:KHexColor(@"#FF4D49") forState:UIControlStateNormal];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_codeButton];
    }
    return _codeButton;
}

- (UITextField *)mobileTextField {
    if (_mobileTextField == nil) {
        UITextField *mobileTextField = [[UITextField alloc] init];
        _mobileTextField = mobileTextField;
        _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
        _mobileTextField.textColor = KHexColor(@"#2D3132");
        _mobileTextField.font = KRegularFont(16);
        _mobileTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"新手机号" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        [_mobileTextField addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_mobileTextField];
    }
    return _mobileTextField;
}

- (UITextField *)codeTextField {
    if (_codeTextField == nil) {
        UITextField *codeTextField = [[UITextField alloc] init];
        _codeTextField = codeTextField;
        _codeTextField.keyboardType = UIKeyboardTypeDefault;
        _codeTextField.textColor = KHexColor(@"#2D3132");
        _codeTextField.font = KRegularFont(16);
        _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        [_codeTextField addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_codeTextField];
    }
    return _codeTextField;
}


- (UIButton *)commitButton {
    if (_commitButton == nil) {
        UIButton *commitButton = [[UIButton alloc] init];
        _commitButton = commitButton;
        _commitButton.backgroundColor = KHexColor(@"#DDDDDD");
        _commitButton.layer.cornerRadius = 20.5;
        _commitButton.clipsToBounds = YES;
        _commitButton.titleLabel.font = KRegularFont(16);
        _commitButton.enabled = NO;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commitButton];
    }
    return _commitButton;
}

- (UIView *)verticalSplitView {
    if (_verticalSplitView == nil) {
        UIView *verticalSplitView = [[UIView alloc] init];
        _verticalSplitView = verticalSplitView;
        _verticalSplitView.backgroundColor = KHexColor(@"#DDDDDD");
        [self.contentView addSubview:_verticalSplitView];
    }
    return _verticalSplitView;
}

#pragma mark - Actions
- (void)sendCode {
    
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    
}

- (void)commitAction {
    
}

//- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
//    TSPhoneNumSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
//    self.phoneNumLabel.text = item.phoneNum;
//}

@end
