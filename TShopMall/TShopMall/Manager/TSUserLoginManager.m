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
#import "NTESQLHomePageCustomUIModel.h"
@interface TSUserLoginManager ()

@end

@implementation TSUserLoginManager
+ (instancetype)shareInstance{
    static TSUserLoginManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TSUserLoginManager alloc] init];
    });
    return instance;
}

- (void)startLogin{
    
    TSLoginViewController *loginViewController = [TSLoginViewController new];
    TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.loginBlock = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@0];
    };
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    homeController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:homeController animated:YES completion:^{
    }];
    
}

- (void)logout{
    TSLogoutRequest *request = [TSLogoutRequest new];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        [[TSUserInfoManager userInfo] clearUserInfo];
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

@end
