//
//  TSWithdrawalPswSettingCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSWithdrawalPswSettingCell.h"
#import "TSTools.h"
#import <Toast.h>
#import "TSWithdrawalPswSetSectionModel.h"

typedef NS_ENUM(NSUInteger, WithdrawalPswSetClickType){
    WithdrawalPswSetClickTypeCommit = 1,///提交按钮
};

@interface TSWithdrawalPswSettingCell ()<UITextFieldDelegate>
/** 密码文字显示 */
@property(nonatomic, weak) UILabel *pswLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitTopView;
/** 分割线 */
@property(nonatomic, weak) UIView *splitBottomView;
/** 验证码输入框 */
@property(nonatomic, weak) UITextField *pswTextField;
/** 验证码按钮 */
@property(nonatomic, weak) UIButton *showPswButton;
/** 提交按钮 */
@property(nonatomic, weak) UIButton *saveButton;
/** 提示语 */
@property(nonatomic, weak) UILabel *tipsLabel;
/** 标题视图  */
@property(nonatomic, weak) UIView *topTitleView;
///提示语的标题
@property (nonatomic, weak) UILabel *tipTilteLabel;
///提示语
@property (nonatomic, weak) UILabel *tipsSubtitleLabel;

@end

@implementation TSWithdrawalPswSettingCell

@synthesize delegate = _delegate;

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    self.tipTilteLabel.text = [NSString stringWithFormat:@"请为账号%@", [TSTools getCipherPhone:[TSUserInfoManager userInfo].user.phone]];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(127);
    }];
    [self.tipTilteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topTitleView.mas_centerX).offset(0);
        make.top.equalTo(self.topTitleView.mas_top).offset(48);
    }];
    [self.tipsSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topTitleView.mas_centerX).offset(0);
        make.top.equalTo(self.tipTilteLabel.mas_bottom).offset(8);
    }];
    [self.splitTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.topTitleView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.33);
    }];
    [self.pswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(80);
        make.top.equalTo(self.splitTopView.mas_bottom).with.offset(0);
        make.right.equalTo(self.showPswButton.mas_left).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.pswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pswTextField.mas_centerY).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
    }];
    [self.showPswButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-24);
        make.width.height.mas_equalTo(24);
        make.centerY.equalTo(self.pswTextField.mas_centerY).with.offset(0);
    }];
    [self.splitBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.pswTextField.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.33);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.splitBottomView.mas_bottom).with.offset(24);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.tipsLabel.mas_bottom).with.offset(24);
        make.height.mas_equalTo(41);
    }];
}

- (UILabel *)pswLabel {
    if (_pswLabel == nil) {
        UILabel *pswLabel = [[UILabel alloc] init];
        _pswLabel = pswLabel;
        _pswLabel.text = @"密码";
        _pswLabel.textColor = KTextColor;
        _pswLabel.font = KRegularFont(16);
        [self.contentView addSubview:_pswLabel];
    }
    return _pswLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"*密码必须是6位数字组合";
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _tipsLabel.font = KRegularFont(12);
        [self.contentView addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

- (UIView *)splitTopView {
    if (_splitTopView == nil) {
        UIView *splitTopView = [[UIView alloc] init];
        _splitTopView = splitTopView;
        _splitTopView.backgroundColor = KHexColor(@"#F4F4F4");
        [self.contentView addSubview:_splitTopView];
    }
    return _splitTopView;
}

- (UIView *)splitBottomView {
    if (_splitBottomView == nil) {
        UIView *splitBottomView = [[UIView alloc] init];
        _splitBottomView = splitBottomView;
        _splitBottomView.backgroundColor = KHexColor(@"#F4F4F4");
        [self.contentView addSubview:_splitBottomView];
    }
    return _splitBottomView;
}

- (UIView *)topTitleView {
    if (_topTitleView == nil) {
        UIView *topTitleView = [[UIView alloc] init];
        _topTitleView = topTitleView;
        [self.contentView addSubview:_topTitleView];
    }
    return _topTitleView;
}

- (UIButton *)showPswButton {
    if (_showPswButton == nil) {
        UIButton *showPswButton = [[UIButton alloc] init];
        _showPswButton = showPswButton;
        _showPswButton.titleLabel.font = KRegularFont(16);
        [_showPswButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showPswButton setBackgroundImage:KImageMake(@"mall_setting_showpsw") forState:UIControlStateSelected];
        [_showPswButton setBackgroundImage:KImageMake(@"mall_setting_hiddenpsw") forState:UIControlStateNormal];
        [_showPswButton addTarget:self action:@selector(showOrHiddenPsw) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_showPswButton];
    }
    return _showPswButton;
}

- (UITextField *)pswTextField {
    if (_pswTextField == nil) {
        UITextField *pswTextField = [[UITextField alloc] init];
        _pswTextField = pswTextField;
        _pswTextField.keyboardType = UIKeyboardTypeNumberPad;
        _pswTextField.secureTextEntry = YES;
        _pswTextField.textColor = KHexColor(@"#2D3132");
        _pswTextField.font = KRegularFont(16);
        _pswTextField.delegate = self;
        _pswTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        [_pswTextField addTarget:self
                           action:@selector(textFieldDidChangeValue:)
                 forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_pswTextField];
    }
    return _pswTextField;
}

- (UIButton *)saveButton {
    if (_saveButton == nil) {
        UIButton *saveButton = [[UIButton alloc] init];
        _saveButton = saveButton;
        _saveButton.backgroundColor = KHexColor(@"#DDDDDD");
        _saveButton.layer.cornerRadius = 20.5;
        _saveButton.clipsToBounds = YES;
        _saveButton.titleLabel.font = KRegularFont(16);
        _saveButton.enabled = NO;
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_saveButton];
    }
    return _saveButton;
}

- (UILabel *)tipTilteLabel {
    if (_tipTilteLabel == nil) {
        UILabel *tipTilteLabel = [[UILabel alloc] init];
        _tipTilteLabel = tipTilteLabel;
        _tipTilteLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);;
        _tipTilteLabel.font = KRegularFont(14);
        [self.topTitleView addSubview: _tipTilteLabel];
    }
    return _tipTilteLabel;
}

- (UILabel *)tipsSubtitleLabel {
    if (_tipsSubtitleLabel == nil) {
        UILabel *tipsSubtitleLabel = [[UILabel alloc] init];
        _tipsSubtitleLabel = tipsSubtitleLabel;
        _tipsSubtitleLabel.text = @"设置新的提现密码";
        _tipsSubtitleLabel.font = KFont(PingFangSCMedium, 16);
        _tipsSubtitleLabel.textColor = KTextColor;
        [self.topTitleView addSubview: _tipsSubtitleLabel];
    }
    return _tipsSubtitleLabel;
}

#pragma mark - Actions

- (void)enabledButton:(BOOL)enabled {
    if ((self.saveButton.enabled && !enabled) || (!self.saveButton.enabled && enabled)) {
        self.saveButton.enabled = enabled;
        self.saveButton.backgroundColor = enabled ? KHexColor(@"#FF4D49") : KHexColor(@"#DDDDDD");
    }
}

- (void)showOrHiddenPsw {
    self.showPswButton.selected = !self.showPswButton.selected;
    self.pswTextField.secureTextEntry = !self.showPswButton.selected;
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    if ([TSTools isWithdrawalPsw:self.pswTextField.text]) {
        [self enabledButton:YES];
    } else {
        [self enabledButton:NO];
    }
}

- (void)commitAction {
    if (![TSTools isWithdrawalPsw:self.pswTextField.text]) {
        [self.contentView makeToast:@"请输入的提现密码为6位数字" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:NSStringFromClass([self class]) forKey:@"cellType"];
    [params setValue:@(WithdrawalPswSetClickTypeCommit) forKey:@"WithdrawalPswSetClickType"];
    ///提现密码
    [params setValue:self.pswTextField.text forKey:@"WithdrawalPsw"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    _delegate = delegate;
    TSWithdrawalPswSetSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    if (item.hasSet) {
        self.tipsLabel.text = @"*密码必须是6位数字组合\n*不可与旧密码重复";
    } else {
        self.topTitleView.hidden = YES;
        [self.topTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10);
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    } else if(textField.text.length >= 6) {
        return NO;
    }
    return YES;
}

@end
