//
//  TSPayPwdViewController.m
//  TShopMall
//
//  Created by edy on 2021/7/3.
//

#import "TSPayPwdViewController.h"
#import "TSPayPasswordInputView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "RSA.h"
#import "TSTools.h"
#import "TSWithdrawalPswSetController.h"

@interface TSPayPwdViewController ()<TSPayPasswordInputViewDelegate>
///提示语的标题
@property (nonatomic, weak) UILabel *tipTilteLabel;
///提示语
@property (nonatomic, weak) UILabel *tipsLabel;
/** 密码输入视图  */
@property(nonatomic, weak) TSPayPasswordInputView *payPwdInputView;

@end

@implementation TSPayPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *maneger = [IQKeyboardManager sharedManager];
    maneger.shouldResignOnTouchOutside = NO;
    [self.payPwdInputView showKeyboard];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    IQKeyboardManager *maneger = [IQKeyboardManager sharedManager];
    maneger.shouldResignOnTouchOutside = YES;
}
- (void)setupBasic {
    self.gk_navTitle = @"修改提现密码";
    self.view.backgroundColor = KWhiteColor;
    [self.tipTilteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.view.mas_top).offset(GK_STATUSBAR_NAVBAR_HEIGHT + 48);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.tipTilteLabel.mas_bottom).offset(48);
    }];
    [self.payPwdInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(KRateW(50));
        make.right.equalTo(self.view.mas_right).offset(-KRateW(50));
        make.height.mas_equalTo(84);
    }];
}

- (UILabel *)tipTilteLabel {
    if (_tipTilteLabel == nil) {
        UILabel *tipTilteLabel = [[UILabel alloc] init];
        _tipTilteLabel = tipTilteLabel;
        _tipTilteLabel.text = @"验证提现密码";
        _tipTilteLabel.textColor = KTextColor;
        _tipTilteLabel.font = KRegularFont(24);
        [self.view addSubview: _tipTilteLabel];
    }
    return _tipTilteLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"请输入当前提现密码，以验证身份";
        _tipsLabel.font = KRegularFont(16);
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        [self.view addSubview: _tipsLabel];
    }
    return _tipsLabel;
}

- (TSPayPasswordInputView *)payPwdInputView {
    if (_payPwdInputView == nil) {
        TSPayPasswordInputView *payPwdInputView = [[TSPayPasswordInputView alloc] init];
        _payPwdInputView = payPwdInputView;
        _payPwdInputView.delegate = self;
        [self.view addSubview: _payPwdInputView];
    }
    return _payPwdInputView;
}

#pragma mark - <TSPayPasswordInputViewDelegate>
- (void)inputDoneActionWithPwd:(NSString *)pwd {
    [Popover popProgressOnWindowWithText:@"正在校验密码..."];
    [[TSServicesManager sharedInstance].acconutService fetchAccountPublicKeyComplete:^(NSString * _Nonnull publicKey) {
        ///利用公钥对密码进行加密
        NSString *rsaPwd = [RSA encryptString:pwd publicKey:publicKey];
        NSString *base64String = [TSTools base64EncodedString:rsaPwd];
        [[TSServicesManager sharedInstance].userInfoService checkWithrawalPwd:base64String success:^{
            [Popover popToastOnWindowWithText:@"提现密码校验成功"];
            TSWithdrawalPswSetController *withrawalVC = [[TSWithdrawalPswSetController alloc] init];
            withrawalVC.hasSet = YES;
            [self.navigationController pushViewController:withrawalVC animated:YES];
        } failure:^(NSString * _Nonnull errorMsg) {
            ///清理密码框
            [self.payPwdInputView clear];
            [Popover popToastOnWindowWithText:errorMsg];
        }];
    }];
}


@end
