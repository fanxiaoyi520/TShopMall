//
//  AppDelegate.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#import "AppDelegate+Initialize.h"
#import "WXApi.h"
#import "TSAccountConst.h"
#import "WechatManager.h"
#import "WechatShareManager.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self initNetworkConfig];
    [self setUITemplateSize];
    [self setKeywordAttribute];
    [self setNavigationConfig];
    [self setupRootController];
    [self initWechatConfig];
    [self initRouteConfig];
    
    
    if (@available(iOS 13.0, *)) {
        
        // 注意 存储用户标识信息需要使用钥匙串来存储 这里使用NSUserDefaults 做的简单示例
        NSString *userIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"appleID"];
        
        if (userIdentifier) {
            
            ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
            
            [appleIDProvider getCredentialStateForUserID:userIdentifier
                                              completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
                switch (credentialState) {
                    case ASAuthorizationAppleIDProviderCredentialAuthorized:
                        // 授权状态有效
                        break;
                    case ASAuthorizationAppleIDProviderCredentialRevoked:
                        // 苹果账号登录的凭据已被移除，需解除绑定并重新引导用户使用苹果登录
                        break;
                    case ASAuthorizationAppleIDProviderCredentialNotFound:
                        // 未登录授权，直接弹出登录页面，引导用户登录
                        break;
                    case ASAuthorizationAppleIDProviderCredentialTransferred:
                        // 授权AppleID提供者凭据转移
                        break;
                }
            }];
        }
        
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSLog(@"url.host:%@",url.host);
    if ([url.host isEqualToString:@"oauth"]) {
        return [WechatManager handleOpenUrl:url];
    }
    else{
        //微信分享
        [WechatShareManager handleOpenUrl:url];
    }
    return YES;
    
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    NSURL *continueURL = userActivity.webpageURL;
    NSString *relativePath = continueURL.relativePath;
    if ([relativePath containsString:WXAPPId] && [relativePath containsString:@"pay"]) {
        return [WXApi handleOpenUniversalLink:userActivity delegate:[WechatManager shareInstance]];
    } else
        if ([relativePath containsString:[NSString stringWithFormat:@"%@", WXAPPId]]) {
            return [WXApi handleOpenUniversalLink:userActivity delegate:[WechatShareManager shareInstance]];
        }else{
            
        }
    return YES;
}

@end
