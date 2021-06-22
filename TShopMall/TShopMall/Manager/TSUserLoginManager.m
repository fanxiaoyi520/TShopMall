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
    login.loginBlock = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@0];
    };
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    homeController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:homeController animated:YES completion:nil];
}

- (void)logout{
    TSLogoutRequest *request = [TSLogoutRequest new];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            
        }
        NSString *dataString = request.responseObject[@"data"];
        if (dataString) {
            NSDictionary *dic = [dataString jsonValueDecoded];
            if ([dic[@"code"] intValue] == 1) {
                
                [[TSUserInfoManager userInfo] clearUserInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TS_LoginUpdateNotification" object:@1];

               
            }
            else{
                
            }
        }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
           
        }];
}

- (TSLoginState)state{
    if ([TSUserInfoManager userInfo].accessToken && [TSUserInfoManager userInfo].userName && [TSUserInfoManager userInfo].refreshToken) {
        return Login;
    }else
        return None;
}

- (void)setLoginStateDidChanged:(void (^)(TSLoginState))loginStateDidChanged{
    
}
@end
