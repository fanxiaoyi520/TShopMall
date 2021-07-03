//
//  AppDelegate+RootController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate+RootController.h"
#import "TSTabBarController.h"
#import "TSLoginViewController.h"
#import "TSBaseNavigationController.h"
#import "TSUserLoginManager.h"
#import "TSFirstEnterAgreementView.h"
#import "TSHybridViewController.h"
#import "TSAgreementModel.h"
#import <NTESQuickPass/NTESQuickPass.h>

@interface AppDelegate()<TSFirstEnterAgreementViewDelegate, TSHybridViewControllerDelegate, NTESQuickLoginManagerDelegate>
@end

@implementation AppDelegate (RootController)

-(void)setupRootController{
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;

    /**
     * 第一次加载键盘慢
     */
    UITextField *lagFreeField = [[UITextField alloc] init];
    [self.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];

    [NTESQuickLoginManager sharedInstance].delegate = self;
    
    @weakify(self);
    if ([TSUserLoginManager shareInstance].state == TSLoginStateNone) {
        [self configLoginController];
    }else{
        self.window.rootViewController = [TSTabBarController new];
    }
    
    [TSUserLoginManager shareInstance].loginBlock = ^{
        self.window.rootViewController = [TSTabBarController new];
    };
    
    [TSUserLoginManager shareInstance].logoutBlock = ^{
        @strongify(self)
        [self configLoginController];
    };
   
    [self.window makeKeyAndVisible];
}

- (void)configLoginController{
    @weakify(self);
    [[TSUserLoginManager shareInstance] configLoginController:^(UIViewController * _Nonnull vc) {
        @strongify(self)
        self.window.rootViewController = vc;
        
        if ([vc.childViewControllers.firstObject isKindOfClass:TSLoginViewController.class]) {
            [self showAlertInView:vc.view];
        }
    }];
}

- (void)showAlertInView:(UIView *)view {
    if ([TSGlobalManager shareInstance].firstStartApp) {
        TSFirstEnterAgreementView *firstEnterAlert = [[TSFirstEnterAgreementView alloc] init];
        firstEnterAlert.delegate = self;
        [firstEnterAlert showInView:view];
    }
}

#pragma mark - TSFirstEnterAgreementViewDelegate

- (void)goToH5WithAgreementModel:(TSAgreementModel *)agreementModel {
    TSBaseNavigationController *nav = (TSBaseNavigationController *)self.window.rootViewController;

    if ([nav.visibleViewController isKindOfClass:TSLoginViewController.class]) {
        TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:[agreementModel.serverUrl stringByAppendingString:@"&mode=webview"]];
        web.delegate = self;
        [nav pushViewController:web animated:YES];
    }
    else{
        
        TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:[agreementModel.serverUrl stringByAppendingString:@"&mode=webview"]];
        TSBaseNavigationController *nav1 = [[TSBaseNavigationController alloc] initWithRootViewController:web];
        nav1.modalPresentationStyle = UIModalPresentationFullScreen;
        web.delegate = self;
        [nav.visibleViewController presentViewController:nav1 animated:YES completion:nil];
    }
    
}

#pragma mark - TSHybridViewControllerDelegate
-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param{
    
    
}

- (void)authViewDidAppear {
    TSBaseNavigationController *nav = (TSBaseNavigationController *)self.window.rootViewController;
    [self showAlertInView:nav.visibleViewController.view];
}
@end
