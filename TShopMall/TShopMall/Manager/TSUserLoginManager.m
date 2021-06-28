//
//  TSUserLoginManager.m
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import "TSUserLoginManager.h"
#import "TSLoginViewController.h"
#import "TSBaseNavigationController.h"
#import "TSUserInfoManager.h"
#import "TSLogoutRequest.h"
#import <NTESQuickPass/NTESQuickPass.h>
#import "TSAccountConst.h"
#import "TSOneClickLoginViewController.h"
#import "TSLoginRegisterDataController.h"
#import "TSBindMobileController.h"
@interface TSUserLoginManager ()

@end

@implementation TSUserLoginManager
+ (instancetype)shareInstance{
    static TSUserLoginManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TSUserLoginManager alloc] init];
        [instance registerQuickLogin];
    });
    return instance;
}

- (void)startLogin{
    BOOL shouldQL = [[NTESQuickLoginManager sharedInstance] shouldQuickLogin];
    if (shouldQL) {
        TSOneClickLoginViewController *oneClickLoginVC = [TSOneClickLoginViewController new];
        TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:oneClickLoginVC];
        @weakify(self);
        oneClickLoginVC.otherLoginBlock = ^{
            @strongify(self)
            [self otherLoginWithAnimation:YES];
        };
        oneClickLoginVC.loginBlock = ^{
            self.loginBlock();
        };
        oneClickLoginVC.bindBlock = ^{
            TSBindMobileController *vc = [TSBindMobileController new];
            TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:vc];
            
            vc.bindedBlock = ^{
                self.loginBlock();
                
            };
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:^{
            }];
        };
        UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [vc presentViewController:nav animated:YES completion:^{
        }];
       
    }else{
        [self otherLoginWithAnimation:YES];
    }
   
}

- (void)logout{
    TSLogoutRequest *request = [TSLogoutRequest new];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        [[TSUserInfoManager userInfo] clearUserInfo];
        if (self.logoutBlock) {
            self.logoutBlock();
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (TSLoginState)state{
    if ([TSUserInfoManager userInfo].accessToken && [TSUserInfoManager userInfo].userName && [TSUserInfoManager userInfo].refreshToken) {
        return TSLoginStateLogin;
    }else
        return TSLoginStateNone;
}

- (void)registerQuickLogin {
    [[NTESQuickLoginManager sharedInstance] registerWithBusinessID:QuickLoginBusinessID];
}

- (void)otherLoginWithAnimation:(BOOL)animation{
    TSLoginViewController *loginViewController = [TSLoginViewController new];
    loginViewController.needClose = YES;
    TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.loginBlock = ^{
        self.loginBlock();
    };
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    homeController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:homeController animated:animation completion:^{
    }];
}

- (void)postNotificationWithLoginState:(TSLoginState)state{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@(state)];
}

-(void)configLoginController:(void(^)(UIViewController *))callBack{
    
    BOOL shouldQL = [[NTESQuickLoginManager sharedInstance] shouldQuickLogin];
    if (shouldQL && [[UIApplication sharedApplication].appBundleID isEqualToString:QuickLoginBundleID]) {
        TSOneClickLoginViewController *oneClickLoginVC = [TSOneClickLoginViewController new];
        TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:oneClickLoginVC];
        @weakify(self);
        oneClickLoginVC.otherLoginBlock = ^{
            @strongify(self)
            [self otherLoginWithAnimation:YES];
        };
        oneClickLoginVC.loginBlock = ^{
            if (self.loginBlock) {
                self.loginBlock();
            }
        };
        oneClickLoginVC.bindBlock = ^{
            TSBindMobileController *vc = [TSBindMobileController new];
            TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:vc];
            
            vc.bindedBlock = ^{
                self.loginBlock();
                
            };
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:^{
            }];
        };
        callBack(nav);
    }else{
        TSLoginViewController *loginViewController = [TSLoginViewController new];
        loginViewController.needClose = NO;
        TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.loginBlock = ^{
            self.loginBlock();
        };
        callBack(homeController);
    }
    
}

@end
