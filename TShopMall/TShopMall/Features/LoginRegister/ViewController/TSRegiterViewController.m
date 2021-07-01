//
//  TSRegiterViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSRegiterViewController.h"
#import "TSRegisterTopView.h"
#import "TSCheckedView.h"
#import <Toast.h>
#import "TSTools.h"
#import "NSTimer+TSBlcokTimer.h"
#import "TSHybridViewController.h"
#import "TSAgreementModel.h"

@interface TSRegiterViewController ()<TSRegisterTopViewDelegate, TSCheckedViewDelegate, TSHybridViewControllerDelegate>
/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 关闭 */
@property(nonatomic, weak) UIButton *closeButton;
/** 页面top部分视图 */
@property(nonatomic, weak) TSRegisterTopView *topView;
/** check视图 */
@property(nonatomic, weak) TSCheckedView *checkedView;
/** 验证码倒计时 */
@property(nonatomic, assign) NSInteger count;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation TSRegiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
}

- (void)fillCustomView {
    ///添加约束
    [self addConstraints];
}

- (void)setupBasic {
    self.count = 60;
    self.view.backgroundColor = UIColor.whiteColor;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self getAgreementInfo];
}

- (void)panAction: (UIPanGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

- (void)addConstraints {
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view).with.offset(0);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).offset(GK_STATUSBAR_HEIGHT + 4);
        make.width.height.mas_equalTo(30);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.closeButton.mas_bottom).with.offset(KRateH(66));
        make.bottom.equalTo(self.checkedView.mas_top).with.offset(0);
    }];
    [self.checkedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-KRateH(30));
        make.left.right.equalTo(self.view).with.offset(0);
//        make.height.mas_equalTo(48);
    }];
}

- (void)getAgreementInfo {
    NSArray *agreementModels = [TSGlobalManager shareInstance].agreementModels;
    if (agreementModels.count) {
        self.checkedView.agreementModels = agreementModels;
    } else {
        [[TSUserLoginManager shareInstance] fetchAgreementWithCompleted:^(NSArray<TSAgreementModel *> * _Nonnull agreementModels) {
            self.checkedView.agreementModels = agreementModels;
        }];
    }
}

#pragma mark - Lazy Method

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        UIButton *closeButton = [[UIButton alloc] init];
        _closeButton = closeButton;
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton setImage:KImageMake(@"mall_login_close") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_closeButton];
    }
    return _closeButton;
}

- (UIView *)topView {
    if (_topView == nil) {
        TSRegisterTopView *topView = [[TSRegisterTopView alloc] init];
        _topView = topView;
        _topView.delegate = self;
        [self.view addSubview:topView];
    }
    return _topView;
}

- (TSCheckedView *)checkedView {
    if (_checkedView == nil) {
        TSCheckedView *checkedView = [[TSCheckedView alloc] init];
        _checkedView = checkedView;
        _checkedView.delegate = self;
        [self.view addSubview:_checkedView];
    }
    return _checkedView;
}

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_login_bg");
        [self.view addSubview:_bgImgV];
    }
    return _bgImgV;
}

#pragma mark - TSRegisterTopViewDelegate
- (void)registerAction {
    NSString *phoneNumber = [self.topView getPhoneNumber];
    if (phoneNumber.length == 0) {
        [self.view makeToast:@"请输入手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (![TSTools isPhoneNumber: phoneNumber]) {
        [self.view makeToast:@"请输入正确的手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.topView getCode].length == 0) {
        [self.view makeToast:@"请输入验证码" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.topView getInvitationCode].length == 0) {
        [self.view makeToast:@"请输入邀请码" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    
    if (!self.checkedView.isChecked) {
        [self.view makeToast:@"请阅读并同意以下协议" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    [self.view endEditing:YES];
    @weakify(self);
    [[TSServicesManager sharedInstance].acconutService fetchRegisterMobile:phoneNumber validCode:[self.topView getCode] invitationCode:[self.topView getInvitationCode] complete:^(BOOL isSucess) {
        if (isSucess) {
            @strongify(self)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@0];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)sendCode {
    NSString *phoneNumber = [self.topView getPhoneNumber];
    if (phoneNumber.length == 0) {
        [self.view makeToast:@"请输入手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (![TSTools isPhoneNumber: phoneNumber]) {
        [self.view makeToast:@"请输入正确的手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer ts_scheduledTimerWithTimeInterval:1 block:^{
         [weakSelf goToRun];
    } repeats:YES];
    
    [[TSServicesManager sharedInstance].acconutService fetchRegisterSMSCodeMobile:phoneNumber complete:^(BOOL isSucess) {
        if (isSucess) {
            [Popover popToastOnWindowWithText:@"验证码已成功发送"];
        }else{
            [Popover popToastOnWindowWithText:@"验证码请求失败"];
            weakSelf.count = 60;
            [weakSelf.timer invalidate];
            [weakSelf.topView setCodeButtonTitleAndColor:@"重发验证码" isResend:YES enabled:YES];
        }
    }];
}

- (void)inputDoneAction {
    if (self.checkedView.isChecked) {
        [self.topView setRegisterBtnEnable:YES];
    }
}

#pragma mark - Actions
- (void)goToRun {
    if (self.count <= 1) {
        self.count = 60;
        [self.timer invalidate];
        [self.topView setCodeButtonTitleAndColor:@"重发验证码" isResend:YES enabled:YES];
    } else {
        self.count--;
        [self.topView setCodeButtonTitleAndColor:[NSString stringWithFormat:@"重发 %ld", (long)self.count] isResend:NO enabled:NO];
    }
}

- (void)closePage {
    if (self.navigationController && self.navigationController.childViewControllers.count >= 2) {
            [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TSCheckedViewDelegate
/** 跳转查看协议 */
- (void)goToH5WithAgreementModel:(TSAgreementModel *)agreementModel {
    TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:[agreementModel.serverUrl stringByAppendingString:@"&mode=webview"]];
    web.delegate = self;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)checkedAction:(BOOL)isChecked {
    [self.topView setRegisterBtnEnable:isChecked];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


@end


