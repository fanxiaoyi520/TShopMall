//
//  TSRememberPwdViewController.m
//  TShopMall
//
//  Created by edy on 2021/7/5.
//

#import "TSRememberPwdViewController.h"
#import "TSPhoneNumVeriViewController.h"
#import "TSPayPwdViewController.h"
#import "TSTools.h"

@interface TSRememberPwdViewController ()
///提示语的标题
@property (nonatomic, weak) UILabel *tipTilteLabel;
///提示语
@property (nonatomic, weak) UILabel *tipsLabel;
/** 手机号显示 */
@property(nonatomic, weak) UILabel *phoneNumLabel;
/** 取消 */
@property(nonatomic, weak) UIButton *cancelButton;
/** 确认按钮 */
@property(nonatomic, weak) UIButton *confirmButton;

@end

@implementation TSRememberPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KWhiteColor;
    self.gk_navTitle = @"修改提现密码";
    self.phoneNumLabel.text = [TSTools getCipherPhone:[TSUserInfoManager userInfo].user.phone];
}

- (void)setupBasic {
    [self.tipTilteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(GK_STATUSBAR_NAVBAR_HEIGHT + KRateH(48));
        make.right.equalTo(self.view.mas_centerX).with.offset(-3);
    }];
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tipTilteLabel.mas_centerY).with.offset(0);
        make.left.equalTo(self.view.mas_centerX).with.offset(3);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.top.equalTo(self.phoneNumLabel.mas_bottom).with.offset(8);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(KRateW(24));
        make.width.equalTo(self.confirmButton.mas_width).with.offset(0);
        make.top.equalTo(self.tipsLabel.mas_bottom).with.offset(KRateW(56));
        make.height.mas_equalTo(40);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right).with.offset(11);
        make.right.equalTo(self.view.mas_right).with.offset(-KRateW(24));
        make.width.equalTo(self.cancelButton.mas_width).with.offset(0);
        make.centerY.equalTo(self.cancelButton.mas_centerY).with.offset(0);
        make.height.mas_equalTo(40);
    }];
}

- (UILabel *)tipTilteLabel {
    if (_tipTilteLabel == nil) {
        UILabel *tipTilteLabel = [[UILabel alloc] init];
        _tipTilteLabel = tipTilteLabel;
        _tipTilteLabel.text = @"您是否记得账号";
        _tipTilteLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        _tipTilteLabel.font = KRegularFont(14);
        [self.view addSubview: _tipTilteLabel];
    }
    return _tipTilteLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"当前使用的密码";
        _tipsLabel.font = KRegularFont(14);
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        [self.view addSubview: _tipsLabel];
    }
    return _tipsLabel;
}

- (UILabel *)phoneNumLabel {
    if (_phoneNumLabel == nil) {
        UILabel *phoneNumLabel = [[UILabel alloc] init];
        _phoneNumLabel = phoneNumLabel;
        _phoneNumLabel.textColor = KTextColor;
        _phoneNumLabel.font = KFont(PingFangSCMedium, 16);
        [self.view addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *cancelButton = [[UIButton alloc] init];
        _cancelButton = cancelButton;
        _cancelButton.titleLabel.font = KRegularFont(16);
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 20;
        _cancelButton.clipsToBounds = YES;
        _cancelButton.layer.borderWidth = 0.5;
        _cancelButton.layer.borderColor = KHexColor(@"#535558").CGColor;
        [_cancelButton setTitleColor:KTextColor forState:UIControlStateNormal];
        [_cancelButton setTitle:@"不记得" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        UIButton *confirmButton = [[UIButton alloc] init];
        _confirmButton = confirmButton;
        _confirmButton.titleLabel.font = KRegularFont(16);
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 20;
        _confirmButton.backgroundColor = KHexColor(@"#FF4D49");
        [_confirmButton setTitle:@"同意并进入" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (void)confirmAction {
    TSPayPwdViewController *payPwdVC = [[TSPayPwdViewController alloc] init];
    [self.navigationController pushViewController:payPwdVC animated:YES];
}

- (void)cancelAction {
    TSPhoneNumVeriViewController *phoneNumVeriVC = [[TSPhoneNumVeriViewController alloc] init];
    phoneNumVeriVC.hasSet = YES;
    [self.navigationController pushViewController:phoneNumVeriVC animated:YES];
}

@end
