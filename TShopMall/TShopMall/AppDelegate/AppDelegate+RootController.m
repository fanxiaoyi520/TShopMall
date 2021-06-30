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
//    TSMainViewController *mainVC = [TSMainViewController new];
//    TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:mainVC];
//    @weakify(self);
//    mainVC.rootViewControllerBlock = ^(UIViewController *vc){
//        @strongify(self)
//        self.window.rootViewController = vc;
//    };
    
    [NTESQuickLoginManager sharedInstance].delegate = self;
    
    @weakify(self);
    if ([TSUserLoginManager shareInstance].state == TSLoginStateNone) {
        [self configLoginController];
    }else{
        self.window.rootViewController = [TSTabBarController new];
    }
    
    [TSUserLoginManager shareInstance].loginBlock = ^{
        @strongify(self)
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
        self.window.rootViewController = vc.navigationController;
        
        if ([vc isKindOfClass:TSLoginViewController.class]) {
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
        
    }
    
}

#pragma mark - TSHybridViewControllerDelegate
-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param{
    
    
}

- (void)authViewDidAppear {
    TSBaseNavigationController *nav = (TSBaseNavigationController *)self.window.rootViewController;

//    [self showAlertInView:nav.visibleViewController.view];
    [self showAlertInView:self.window];
}
@end
