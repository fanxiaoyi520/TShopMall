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
@property (nonatomic, strong) NSMutableArray *marr;

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

- (void)otherLoginWithAnimation:(BOOL)animation needClose:(BOOL)needClose{
    TSLoginViewController *loginViewController = [TSLoginViewController new];
    loginViewController.needClose = needClose;
    TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.loginBlock = self.loginBlock;
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    homeController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:homeController animated:animation completion:^{
    }];
}

-(void)configLoginController:(void(^)(UIViewController *))callBack{
    
    BOOL shouldQL = [[NTESQuickLoginManager sharedInstance] shouldQuickLogin];
    [self.marr removeAllObjects];
    if (shouldQL && [[UIApplication sharedApplication].appBundleID isEqualToString:QuickLoginBundleID]) {
        TSOneClickLoginViewController *oneClickLoginVC = [TSOneClickLoginViewController new];
        TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:oneClickLoginVC];
        @weakify(self);
        oneClickLoginVC.otherLoginBlock = ^{
            @strongify(self)
            [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
                [self otherLoginWithAnimation:YES needClose:YES];
            }];
        };
//        oneClickLoginVC.loginBlock = self.loginBlock;
        oneClickLoginVC.loginBlock = ^(BOOL sucess){
            @strongify(self)
            if (sucess) {
                self.loginBlock();
            }else
            {
                [self otherLoginWithAnimation:NO needClose:NO];
            }
            
        };
        oneClickLoginVC.bindBlock = ^(NSString *token){
            
            TSBindMobileController *vc = [TSBindMobileController new];
            vc.token = token;
            TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:vc];
            
            vc.bindedBlock = self.loginBlock;
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:^{
            }];
        };
        [self.marr addObject:nav];
        callBack(nav);
    }else{
        TSLoginViewController *loginVC = [TSLoginViewController new];
        loginVC.needClose = NO;
        TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:loginVC];
        loginVC.loginBlock = ^{
            [self.marr removeAllObjects];
            self.loginBlock();
        };
        loginVC.bindBlock = ^(NSString * _Nonnull token) {
            TSBindMobileController *vc = [TSBindMobileController new];
            vc.token = token;
            TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:vc];
            
            vc.bindedBlock = self.loginBlock;
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:^{
            }];
        };
        [self.marr addObject:nav];
        callBack(nav);
    }
    
}

- (NSMutableArray *)marr
{
    if (!_marr) {
        _marr = @[].mutableCopy;
    }
    return _marr;
}
@end
