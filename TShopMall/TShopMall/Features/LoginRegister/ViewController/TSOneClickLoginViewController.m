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
#import "TSBindMobileController.h"
#import "UIViewController+Plugin.h"

@interface TSOneClickLoginViewController ()<TSHybridViewControllerDelegate>
@property (nonatomic, strong) NTESQuickLoginModel  *customModel;

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
    if ([[UIViewController windowRootViewController].childViewControllers.firstObject isKindOfClass:self.class]) {
        [self getPhoneNumber];
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
    
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
                            [[TSServicesManager sharedInstance].acconutService fetchOneStepLoginToken:[resultDic1 objectForKey:@"token"] accessToken:[resultDic2 objectForKey:@"accessToken"] complete:^(BOOL isSucess) {
                               
                                if (isSucess) {
                                    [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
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
    NTESQuickLoginModel  *customModel = [uiModel configCustomUIModel:NTESPresentDirectionPush withType:0 faceOrientation:UIInterfaceOrientationPortrait];
    customModel.currentVC = self;
    
    [[NTESQuickLoginManager sharedInstance] setupModel:customModel];
    @weakify(self);
    
    uiModel.otherLoginBlock = ^{
        @strongify(self)
        if (self.otherLoginBlock) {
            self.otherLoginBlock();
        }
    };
    uiModel.appleLoginBlock = ^{
        @strongify(self)
        AuthAppleIDManager *manager = [AuthAppleIDManager sharedInstance];
        [manager authorizationAppleID];
        manager.loginByTokenBlock = ^(NSString * _Nonnull token) {
            [[TSServicesManager sharedInstance].acconutService fetchLoginByToken:token platformId:@"15" sucess:^(BOOL isHaveMobile, NSString * _Nonnull token) {
                [[NTESQuickLoginManager sharedInstance] closeAuthController:^{

                 }];
                if (isHaveMobile) {
                    /// 完成登录
                    [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
                        if (self.loginBlock) {
                            self.loginBlock();
                        }
                    }];
                }
                else{
                    [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
                        if (self.loginBlock) {
                            self.loginBlock();
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
    customModel.rootViewController = self;
    customModel.pageCustomBlock = ^(int privacyType) {
        NSString *url;
        if (privacyType == 0) {
            if ([[NTESQuickLoginManager sharedInstance] getCarrier] == NTESCarrierTypeMobile) {
                url = @"https://wap.cmpassport.com/resources/html/contract.html";
            }
            else if ([[NTESQuickLoginManager sharedInstance] getCarrier] == NTESCarrierTypeUnicom){
                url = @"https://ms.zzx9.cn/html/oauth/protocol2.html";
            }
            else if ([[NTESQuickLoginManager sharedInstance] getCarrier] == NTESCarrierTypeTelecom){
                url = @"https://e.189.cn/sdk/agreement/content.do?type=main&appKey=&hidetop=true";
            }
        }else{
            url = [TSGlobalManager shareInstance].agreementModels[privacyType - 1].serverUrl;
        }
        @strongify(self)
        TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:url];
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
            
            [[TSServicesManager sharedInstance].acconutService fetchLoginByAuthCode:code platformId:@"3" sucess:^(BOOL isHaveMobile, NSString * _Nonnull token) {
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
                            self.bindBlock(token);
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
