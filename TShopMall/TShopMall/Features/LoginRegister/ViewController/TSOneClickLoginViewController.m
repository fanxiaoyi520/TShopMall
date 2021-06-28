//
//  TSOneClickLoginViewController.m
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "TSOneClickLoginViewController.h"
#import <NTESQuickPass/NTESQuickPass.h>
#import "NTESQLHomePageCustomUIModel.h"
#import "TSHybridViewController.h"
#import "WechatManager.h"
#import "TSAccountConst.h"
#import "AuthAppleIDManager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "TSLoginRegisterDataController.h"
#import "TSBindMobileController.h"

@interface TSOneClickLoginViewController ()<TSHybridViewControllerDelegate, NTESQuickLoginManagerDelegate>
@property (nonatomic, strong) NTESQuickLoginModel  *customModel;
@property(nonatomic, strong) TSLoginRegisterDataController *dataController;

@end

@implementation TSOneClickLoginViewController
- (void)dealloc
{
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getPhoneNumber];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
    
//    [NTESQuickLoginManager sharedInstance].delegate = self;
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = KWhiteColor;
    
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
                                if (isSucess) {
                                    [[NTESQuickLoginManager sharedInstance] closeAuthController:^{

                                     }];
                                    [self dismissViewControllerAnimated:YES completion:^{
                                        if (self.loginBlock) {
                                            self.loginBlock();
                                        }
                                        
                                    }];
                                }
                            }];
                            
                        } else {
                             // 取号失败
                        }
                      }];
            } else {
                
            }
          });
      }];
}

/// 授权页面自定义
- (void)setCustomUI {
   
    NTESQLHomePageCustomUIModel *uiModel = [NTESQLHomePageCustomUIModel getInstance];
    self.customModel = [uiModel configCustomUIModel:NTESPresentDirectionPush withType:0 faceOrientation:UIInterfaceOrientationPortrait];
    self.customModel.currentVC = self;
    
    [[NTESQuickLoginManager sharedInstance] setupModel:self.customModel];
    @weakify(self);
    
    uiModel.otherLoginBlock = ^{
        @strongify(self)
        [[NTESQuickLoginManager sharedInstance] closeAuthController:^{

         }];
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.otherLoginBlock) {
                self.otherLoginBlock();
            }
        }];
    };
    uiModel.appleLoginBlock = ^{
        @strongify(self)
        AuthAppleIDManager *manager = [AuthAppleIDManager sharedInstance];
        [manager authorizationAppleID];
        manager.loginByTokenBlock = ^(NSString * _Nonnull token) {
            [self.dataController fetchLoginByToken:token platformId:@"15" sucess:^(BOOL isHaveMobile, NSString * _Nonnull token) {
                [[NTESQuickLoginManager sharedInstance] closeAuthController:^{

                 }];
                if (isHaveMobile) {
                    /// 完成登录
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.loginBlock) {
                            self.loginBlock();
                        }
                        
                    }];
                }
                else{
                    [self dismissViewControllerAnimated:NO completion:^{
                        if (self.bindBlock) {
                            self.bindBlock();
                        }
                    }];
                }
            }];
        };
    };
    uiModel.weChatLoginBlock = ^{
        @strongify(self)
        [self sendWXAuthReq];
    };
    self.customModel.backActionBlock = ^{
        @strongify(self)
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    self.customModel.pageCustomBlock = ^(int privacyType) {
        @strongify(self)
        TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:@"https://www.baidu.com"];
        web.delegate = self;
        [self.navigationController pushViewController:web animated:YES];
        [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
        }];
    };
}

#pragma mark - TSHybridViewControllerDelegate
-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param{
    
    [self getPhoneNumber];
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
                [[NTESQuickLoginManager sharedInstance] closeAuthController:^{

                 }];
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

- (TSLoginRegisterDataController *)dataController{
    if (!_dataController ) {
        _dataController = [TSLoginRegisterDataController new];
    }
    return _dataController;
}

@end
