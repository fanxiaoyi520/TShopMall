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
#import <AuthenticationServices/AuthenticationServices.h>


@interface TSLoginViewController ()<TSQuickLoginTopViewDelegate, TSLoginTopViewDelegate, TSLoginBottomViewDelegate, TSCheckedViewDelegate, TSQuickCheckViewDelegate, NTESQuickLoginManagerDelegate, TSHybridViewControllerDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
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

@property (nonatomic, strong) NTESQuickLoginModel *customModel;

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    
    [self registerQuickLogin];
    [self getPhoneNumber];
    
    // 注册通知
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
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
//    [self addConstraints];
    
}

- (void)setupBasic {
    self.count = 60;
    self.view.backgroundColor = UIColor.whiteColor;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
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
        make.height.mas_equalTo(56);
    }];
    [self.quickCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-KRateH(30));
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.checkedView.mas_top).with.offset(-KRateW(20));
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(KRateW(35));
    }];
}

#pragma mark - 使用易盾
- (void)registerQuickLogin {
    [NTESQuickLoginManager sharedInstance].delegate = self;
    [[NTESQuickLoginManager sharedInstance] registerWithBusinessID:QuickLoginBusinessID];
}

- (void)getPhoneNumber{
   
    
    @weakify(self);
    [[NTESQuickLoginManager sharedInstance] getPhoneNumberCompletion:^(NSDictionary * _Nonnull resultDic1) {
        @strongify(self)
        NSNumber *boolNum = [resultDic1 objectForKey:@"success"];
        BOOL success = [boolNum boolValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self setCustomUI];
                
                [[NTESQuickLoginManager sharedInstance] CUCMCTAuthorizeLoginCompletion:^(NSDictionary * _Nonnull resultDic2) {
                        NSNumber *boolNum = [resultDic2 objectForKey:@"success"];
                        BOOL success = [boolNum boolValue];
                        if (success) {
                            [self.dataController fetchOneStepLoginToken:[resultDic1 objectForKey:@"token"] accessToken:[resultDic2 objectForKey:@"accessToken"] complete:^(BOOL isSucess) {
                                [Popover removePopoverOnWindow];
                                if (isSucess) {
                                    [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
                                        [self dismissViewControllerAnimated:YES completion:^{
                                            if (self.loginBlock) {
                                                self.loginBlock();
                                            }
                                        }];
                                    }];
                                }
                                
                            }];
                        } else {
                             // 取号失败
                        }
                      }];
            } else {
                [self addConstraints];
                [self otherLogin];
            }
          });
      }];
}

/// 授权页面自定义
- (void)setCustomUI {
    @weakify(self);
    NTESQLHomePageCustomUIModel *uiModel = [NTESQLHomePageCustomUIModel getInstance];
    self.customModel = [uiModel configCustomUIModel:NTESPresentDirectionPush withType:0 faceOrientation:UIInterfaceOrientationPortrait];
    self.customModel.currentVC = self;
    uiModel.otherLoginBlock = ^{
        @strongify(self)
        [self addConstraints];
        [self otherLogin];
    };
    uiModel.appleLoginBlock = ^{
        @strongify(self)
        [self authorizationAppleID];
    };
    uiModel.weChatLoginBlock = ^{
        @strongify(self)
        [self sendWXAuthReq];
    };
    self.customModel.backActionBlock = ^{
        @strongify(self)
        [Popover removePopoverOnWindow];
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    self.customModel.pageCustomBlock = ^(int privacyType) {
        NSLog(@"privacyType:%d", privacyType);
        @strongify(self)
      
        TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:@"https://www.baidu.com"];
        web.delegate = self;
        [self.navigationController pushViewController:web animated:YES];
        [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
            

        }];
    };
    
    [[NTESQuickLoginManager sharedInstance] setupModel:self.customModel];
}


#pragma mark - Actions
- (void)goToRun {
    if (self.count <= 1) {
        self.count = 60;
        [self.timer invalidate];
        [self.topView setCodeButtonTitleAndColor:@"重新验证码" isResend:YES enabled:YES];
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
        registerVC.regiterBlock = ^{
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.loginBlock) {
                    self.loginBlock();
                }
            }];
        };
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
            
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.loginBlock) {
                    self.loginBlock();
                }
                
            }];
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
    
}

- (void)goToApple {
    
}

#pragma mark - TSCheckedViewDelegate
- (void)goToServiceProtocol {
    
}

- (void)goToPrivatePolicy {
    
}

- (void)goToRegisterProtocol {
    
}

- (void)checkedAction:(BOOL)isChecked{
    [self.topView setLoginButtonEnable:isChecked];
}

#pragma mark - TSQuickCheckViewDelegate
/** 认证信息 */
- (void)openAuthenticationProtocol {
    
}
/** 服务协议 */
- (void)openServiceProtocol {
    
}
/** 隐私政策 */
- (void)openPrivateProtocol {
    
}

#pragma mark - TSHybridViewControllerDelegate
-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param{
    [Popover popProgressOnWindowWithProgressModel:[Popover defaultConfig] appearBlock:^(id frontView) {
        
    }];
    
    [self getPhoneNumber];
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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)sendWXAuthReq{
    @weakify(self);
    WechatManager * payManager =[WechatManager shareInstance];
    payManager.WXFail = ^{
//        @strongify(self)
        //失败回调
        
    };
    payManager.WXSuccess = ^{
//        @strongify(self)
        //成功回调;
        
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

#pragma mark- 授权苹果ID
- (void)authorizationAppleID {
    
    if (@available(iOS 13.0, *)) {
        
        ASAuthorizationAppleIDProvider * appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest * authAppleIDRequest = [appleIDProvider createRequest];
        ASAuthorizationPasswordRequest * passwordRequest = [[[ASAuthorizationPasswordProvider alloc] init] createRequest];

        NSMutableArray <ASAuthorizationRequest *> * array = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [array addObject:authAppleIDRequest];
        }
//        if (passwordRequest) {
//            [array addObject:passwordRequest];
//        }
        NSArray <ASAuthorizationRequest *> * requests = [array copy];
        
        ASAuthorizationController * authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
        
    } else {
        // 处理不支持系统版本
        NSLog(@"系统不支持Apple登录");
    }
}

#pragma mark- ASAuthorizationControllerDelegate
// 授权成功
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        ASAuthorizationAppleIDCredential * credential = authorization.credential;
        
        // 苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString * userID = credential.user;
        
        // 苹果用户信息 如果授权过，可能无法再次获取该信息
        NSPersonNameComponents * fullName = credential.fullName;
        NSString * email = credential.email;
        
        // 服务器验证需要使用的参数
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        
        // 用于判断当前登录的苹果账号是否是一个真实用户，取值有：unsupported、unknown、likelyReal
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"appleID"];
        
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
    }
    else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        
        // 用户登录使用现有的密码凭证
        ASPasswordCredential * passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString * user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString * password = passwordCredential.password;
        
        NSLog(@"userID: %@", user);
        NSLog(@"password: %@", password);
        
    } else {
        
    }
}

// 授权失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    
    NSString *errorMsg = nil;
    
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    NSLog(@"%@", errorMsg);
}

#pragma mark- ASAuthorizationControllerPresentationContextProviding
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    
    return self.view.window;
}

#pragma mark- apple授权状态 更改通知
- (void)handleSignInWithAppleStateChanged:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
}

@end
