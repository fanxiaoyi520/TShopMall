//
//  TSLoginViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSLoginViewController.h"
#import "TSQuickLoginTopView.h"
#import "TSLoginTopView.h"
#import "TSCheckedView.h"
#import "TSQuickCheckView.h"
#import "TSLoginBottomView.h"
#import "TSTools.h"
#import <Toast.h>
#import "TSRegiterViewController.h"
#import "NSTimer+TSBlcokTimer.h"
#import "TSLoginRegisterDataController.h"
#import <NTESQuickPass/NTESQuickPass.h>
#import "NTESQLHomePageCustomUIModel.h"
#import "TSHybridViewController.h"
#import "TSBaseNavigationController.h"
#import "WechatManager.h"
#import "TSAccountConst.h"
#import "AuthAppleIDManager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "TSAgreementModel.h"
//#import "TSFirstEnterAgreementView.h"

@interface TSLoginViewController ()<TSQuickLoginTopViewDelegate, TSLoginTopViewDelegate, TSLoginBottomViewDelegate, TSCheckedViewDelegate, TSQuickCheckViewDelegate, TSHybridViewControllerDelegate>
/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 关闭 */
@property(nonatomic, weak) UIButton *closeButton;
/** 页面top部分视图 */
@property(nonatomic, weak) TSLoginTopView *topView;
/** 一键登录的视图 */
@property(nonatomic, weak) TSQuickLoginTopView *quickView;
/** check视图 */
@property(nonatomic, weak) TSCheckedView *checkedView;
/** 快捷登录check视图 */
@property(nonatomic, weak) TSQuickCheckView *quickCheckView;
/** 底部视图 */
@property(nonatomic, weak) TSLoginBottomView *bottomView;
/** 验证码倒计时 */
@property(nonatomic, assign) NSInteger count;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) TSLoginRegisterDataController *dataController;

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    //[self showFirstEnterAlert];
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc {
    [self.timer invalidate];
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    } else {
        // Fallback on earlier versions
    }

}

- (void)fillCustomView {
    ///添加约束
    [self addConstraints];
    [self otherLogin];
    
}

- (void)setupBasic {
    self.count = 60;
    self.view.backgroundColor = UIColor.whiteColor;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    self.closeButton.hidden = !self.needClose;
    [self getAgreementInfo];
}

- (void)panAction: (UIPanGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

- (void)addConstraints {
    
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).offset(GK_STATUSBAR_HEIGHT + 4);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.closeButton.mas_bottom).with.offset(KRateH(46));
        make.bottom.equalTo(self.bottomView.mas_top).with.offset(0);
    }];
    [self.quickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.closeButton.mas_bottom).with.offset(KRateH(81));
        make.bottom.equalTo(self.bottomView.mas_top).with.offset(0);
    }];
    [self.checkedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-KRateH(30));
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(66);
    }];
    [self.quickCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-KRateH(30));
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(66);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.checkedView.mas_top).with.offset(-KRateW(20));
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(KRateW(35));
    }];
}

- (void)getAgreementInfo {
    NSArray *agreementModels = [TSGlobalManager shareInstance].agreementModels;
    if (agreementModels.count) {
        self.checkedView.agreementModels = agreementModels;
        self.quickCheckView.agreementModels = agreementModels;
    } else {
        [[TSUserLoginManager shareInstance] fetchAgreementWithCompleted:^(NSArray<TSAgreementModel *> * _Nonnull agreementModels) {
            self.checkedView.agreementModels = agreementModels;
            self.quickCheckView.agreementModels = agreementModels;
        }];
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

#pragma mark - TSQuickLoginTopViewDelegate
/** 一键登录 */
- (void)quickLogin {
    if (!self.quickCheckView.isChecked) {
        [self.view makeToast:@"请阅读并同意以下协议" duration:3.0 position:CSToastPositionCenter];
        return;
    }
}

/** 其它登录方式 */
- (void)otherLogin {
    self.quickView.hidden = YES;
    self.quickCheckView.hidden = YES;
    self.checkedView.hidden = NO;
    self.topView.hidden = NO;
}

#pragma mark - TSLoginTopViewDelegate
/** 发送验证码 */
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
    
    [self.view endEditing:YES];
    
    NSString *mobile = [self.topView getPhoneNumber];
    
    __weak typeof(self) weakSelf = self;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.dataController fetchLoginSMSCodeMobile:mobile complete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            strongSelf.timer = [NSTimer ts_scheduledTimerWithTimeInterval:1 block:^{
                 [weakSelf goToRun];
            } repeats:YES];
            
            [Popover popToastOnWindowWithText:@"获取验证码成功"];
            
        }else{
            [strongSelf.view makeToast:self.dataController.smsModel.failCause duration:2.0 position:CSToastPositionBottom];
        }
    }];
    
}

- (void)goToRegister {
    if (self.navigationController) {
        TSRegiterViewController *registerVC = [[TSRegiterViewController alloc] init];
        registerVC.dataController = self.dataController;
        [self.navigationController pushViewController:registerVC animated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)login {
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
    if (!self.checkedView.isChecked) {
        [self.view makeToast:@"请阅读并同意以下协议" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *inputCode = [self.topView getCode];
    NSString *rightCode = self.dataController.smsModel.text;
    
    if (![inputCode isEqualToString:rightCode]) {//验证码输入错误
        [Popover popToastOnWindowWithText:@"验证码输入有误"];
    }
    [self.view endEditing:YES];
    
    [Popover popProgressOnWindowWithProgressModel:[Popover defaultConfig] appearBlock:^(id frontView) {
        
    }];
    
    @weakify(self);
    [self.dataController fetchQuickLoginUsername:[self.topView getPhoneNumber]
                                       validCode:[self.topView getCode]
                                        complete:^(BOOL isSucess) {
        @strongify(self)
        if (isSucess) {
            [Popover removePopoverOnWindow];
            
            if (self.loginBlock) {
                self.loginBlock();
            }
        }
        
    }];
}

- (void)inputDoneAction {
    if (self.checkedView.isChecked) {
        [self.topView setLoginButtonEnable:YES];
    }
}

- (void)closePage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TSLoginBottomViewDelegate
- (void)goToWechat {
   
    [self sendWXAuthReq];
}

- (void)goToApple {
    @weakify(self);
   
    AuthAppleIDManager *manager = [AuthAppleIDManager sharedInstance];
    [manager authorizationAppleID];
    manager.loginByTokenBlock = ^(NSString * _Nonnull token) {
        @strongify(self)
        [self.dataController fetchLoginByToken:token platformId:@"15" sucess:^(BOOL isHaveMobile, NSString * _Nonnull token) {
            if (isHaveMobile) {
                /// 完成登录
                if (self.loginBlock) {
                    self.loginBlock();
                }
            }
            else{
                [[NTESQuickLoginManager sharedInstance] closeAuthController:^{

                 }];
                [self dismissViewControllerAnimated:NO completion:^{
                    if (self.bindBlock) {
                        self.bindBlock();
                    }
                }];
            }
        }];
    };
}

#pragma mark - TSCheckedViewDelegate
/** 跳转查看协议 */
- (void)goToH5WithAgreementModel:(TSAgreementModel *)agreementModel {
    TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:[agreementModel.serverUrl stringByAppendingString:@"&mode=webview"]];
    web.delegate = self;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)checkedAction:(BOOL)isChecked{
    [self.topView setLoginButtonEnable:isChecked];
}

#pragma mark - TSQuickCheckViewDelegate


#pragma mark - TSHybridViewControllerDelegate
-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param{
    
    
}

#pragma mark - Lazy Method
- (UIView *)topView {
    if (_topView == nil) {
        TSLoginTopView *topView = [[TSLoginTopView alloc] init];
        _topView = topView;
        _topView.delegate = self;
        _topView.hidden = YES;
        [self.view addSubview:topView];
    }
    return _topView;
}

- (UIView *)quickView {
    if (_quickView == nil) {
        TSQuickLoginTopView *quickView = [[TSQuickLoginTopView alloc] init];
        _quickView = quickView;
        _quickView.quickDelegate = self;
        [self.view addSubview:_quickView];
    }
    return _quickView;
}

- (TSCheckedView *)checkedView {
    if (_checkedView == nil) {
        TSCheckedView *checkedView = [[TSCheckedView alloc] init];
        _checkedView = checkedView;
        _checkedView.hidden = YES;
        _checkedView.delegate = self;
        [self.view addSubview:_checkedView];
    }
    return _checkedView;
}

- (TSQuickCheckView *)quickCheckView {
    if (_quickCheckView == nil) {
        TSQuickCheckView *quickCheckView = [[TSQuickCheckView alloc] init];
        _quickCheckView = quickCheckView;
        _quickCheckView.delegate = self;
        [self.view addSubview:_quickCheckView];
    }
    return _quickCheckView;
}

- (TSLoginBottomView *)bottomView {
    if (_bottomView == nil) {
        TSLoginBottomView *bottomView = [[TSLoginBottomView alloc] init];
        _bottomView = bottomView;
        _bottomView.delegate = self;
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

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

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_login_bg");
        [self.view addSubview:_bgImgV];
    }
    return _bgImgV;
}

-(TSLoginRegisterDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSLoginRegisterDataController alloc] init];
    }
    return _dataController;
}

#pragma mark- 微信登录
- (void)sendWXAuthReq{
    @weakify(self);
    WechatManager * payManager = [WechatManager shareInstance];
    payManager.WXFail = ^{

    };
    payManager.WXSuccess = ^(NSString *code){
        @strongify(self)
        if (code) {
            [self.dataController fetchLoginByAuthCode:code platformId:@"3" sucess:^(BOOL isHaveMobile, NSString * _Nonnull token) {
                if (isHaveMobile) {
                    /// 完成登录
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.loginBlock) {
                            self.loginBlock();
                        }
                        
                    }];
                }
                else{
                    /// 跳转绑定手机号
                    [self dismissViewControllerAnimated:NO completion:^{
                        if (self.bindBlock) {
                            self.bindBlock();
                        }
                    }];
                }
            }];
        }
    };
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        //唤起微信
        [WechatManager hangleWechatAuthWith:req];
        
    }else{
        [Popover popToastOnWindowWithText:@"未安装微信应用或版本过低"];
    }
}

#pragma mark- apple授权状态 更改通知
- (void)handleSignInWithAppleStateChanged:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
}

@end
