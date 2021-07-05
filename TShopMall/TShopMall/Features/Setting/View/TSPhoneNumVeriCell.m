//
//  TSPhoneNumVeriCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSPhoneNumVeriCell.h"
#import "TSPhoneNumSectionModel.h"
#import "NSTimer+TSBlcokTimer.h"
#import "TSTools.h"
#import <Toast.h>

@interface TSPhoneNumVeriCell ()
/** 手机号 */
@property(nonatomic, weak) UILabel *phoneLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitTopView;
/** 手机号显示 */
@property(nonatomic, weak) UILabel *phoneNumLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitBottomView;
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
/** 验证码倒计时 */
@property(nonatomic, assign) NSInteger count;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TSPhoneNumVeriCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.count = 60;
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
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
    [self.splitTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.phoneNumLabel.mas_bottom).with.offset(24);
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
        ///_phoneNumLabel.text = @"133-7869-2380";
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
        _phoneLabel.text = @"手机号";
        _phoneLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _phoneLabel.font = KRegularFont(14);
        [self.contentView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"若验证码错误超过5次，24小时内将无法继续设置。";
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
        [_codeButton setTitleColor:KHexAlphaColor(@"#2D3132", 0.2) forState:UIControlStateDisabled];
        [_codeButton setTitleColor:KHexColor(@"#FF4D49") forState:UIControlStateNormal];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_codeButton];
    }
    return _codeButton;
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
        [_commitButton setTitleColor:KWhiteColor forState:(UIControlStateNormal)];
        [_commitButton setTitleColor:KWhiteColor forState:(UIControlStateDisabled)];
        [_commitButton setTitleColor:KWhiteColor forState:(UIControlStateHighlighted)];
        [_commitButton setTitleColor:KHexAlphaColor(@"#2D3132", 0.4) forState:(UIControlStateDisabled)];
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
    NSString *phoneNumber = self.phoneNumLabel.text;
    if ([self.phoneNumLabel.text containsString:@"-"]) {
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if (![TSTools isPhoneNumber: phoneNumber]) {
        [self.contentView makeToast:@"请输入正确的手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    self.codeButton.enabled = NO;
    if ([self.actionDelegate respondsToSelector:@selector(sendCodeWithMobile:codeButton:cell:)]) {
        [self.actionDelegate sendCodeWithMobile:phoneNumber codeButton:self.codeButton cell:self];
    }
}

- (void)startTimer {
    [self.timer invalidate];
    self.timer = nil;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer ts_scheduledTimerWithTimeInterval:1 block:^{
         [weakSelf goToRun];
    } repeats:YES];
}

- (void)goToRun {
    if (self.count <= 1) {
        self.count = 60;
        [self.timer invalidate];
        self.codeButton.enabled = YES;
        [self.codeButton setTitle:@"重发验证码" forState:UIControlStateNormal];
    } else {
        self.count--;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%lds", (long)self.count] forState:UIControlStateNormal];
    }
}

- (void)enabledButton:(BOOL)enabled {
    if ((self.commitButton.enabled && !enabled) || (!self.commitButton.enabled && enabled)) {
        self.commitButton.enabled = enabled;
        self.commitButton.backgroundColor = enabled ? KHexColor(@"#FF4D49") : KHexColor(@"#DDDDDD");
    }
}

- (void)textFieldDidChangeValue:(UITextField *)textField {
    if (self.codeTextField.text.length) {
        [self enabledButton: YES];
    } else {
        [self enabledButton: NO];
    }
}

- (void)commitAction {
    NSString *phoneNumber = self.phoneNumLabel.text;
    if ([self.phoneNumLabel.text containsString:@"-"]) {
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if (self.codeTextField.text.length == 0) {
        [self.contentView makeToast:@"请输入验证码" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    self.commitButton.enabled = NO;
    if ([self.actionDelegate respondsToSelector:@selector(commitActionWithCode:mobile:commitButton:)]) {
        [self.actionDelegate commitActionWithCode:self.codeTextField.text mobile:phoneNumber commitButton:self.commitButton];
    }
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSPhoneNumSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.phoneNumLabel.text = item.phoneNum;
}

@end
