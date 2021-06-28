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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@0];
        };
        oneClickLoginVC.bindBlock = ^{
            TSBindMobileController *vc = [TSBindMobileController new];
            TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:vc];

            vc.bindedBlock = ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@0];

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
        [[TSGlobalManager shareInstance] setCurrentUserInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@1];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (TSLoginState)state{
    if ([TSUserInfoManager userInfo].accessToken && [TSUserInfoManager userInfo].userName && [TSUserInfoManager userInfo].refreshToken) {
        return Login;
    }else
        return None;
}

- (void)registerQuickLogin {
    [[NTESQuickLoginManager sharedInstance] registerWithBusinessID:QuickLoginBusinessID];
}

- (void)otherLoginWithAnimation:(BOOL)animation{
    TSLoginViewController *loginViewController = [TSLoginViewController new];
    TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.loginBlock = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@0];
    };
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    homeController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:homeController animated:animation completion:^{
    }];
}



@end
