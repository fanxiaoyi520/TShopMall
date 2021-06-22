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

    TSLoginViewController *login = [TSLoginViewController new];
    TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:login];
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    homeController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:homeController animated:YES completion:nil];
}

- (void)startLogout{
    
}

- (TSLoginState)state{
    if ([TSUserInfoManager userInfo].accessToken && [TSUserInfoManager userInfo].userName && [TSUserInfoManager userInfo].refreshToken) {
        return Login;
    }else
        return None;
}
@end
