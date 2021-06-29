//
//  TSMainViewController.m
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import "TSMainViewController.h"
#import "TSUserLoginManager.h"
#import "TSTabBarController.h"
#import "TSFirstEnterAgreementView.h"
#import "TSHybridViewController.h"
#import "TSAgreementModel.h"
#import <NTESQuickPass/NTESQuickPass.h>
#import "TSLoginViewController.h"

@interface TSMainViewController ()<TSFirstEnterAgreementViewDelegate, TSHybridViewControllerDelegate, NTESQuickLoginManagerDelegate>
@property (nonatomic, strong) UIViewController *loginVC;
@property (nonatomic, strong) TSTabBarController *tab;

@end

@implementation TSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenNavigationBar];
    [NTESQuickLoginManager sharedInstance].delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateDidChanged:) name:TS_Login_State object:nil];

    @weakify(self);
    // Do any additional setup after loading the view.
    if ([TSUserLoginManager shareInstance].state == TSLoginStateNone) {
        
        [[TSUserLoginManager shareInstance] configLoginController:^(UIViewController * _Nonnull vc) {
            @strongify(self)
            [self addChildViewController:vc];
            self.loginVC = vc;
            if ([self.loginVC isKindOfClass:TSLoginViewController.class]) {
                [self showAlertInView:[UIApplication sharedApplication].keyWindow];
            }
            
            [self.view addSubview:vc.view];
        }];
        
    }else{
       
        self.tab = [TSTabBarController new];
        [self addChildViewController:self.tab];
        [self.view addSubview:self.tab.view];
    }
    
    [TSUserLoginManager shareInstance].loginBlock = ^{
        @strongify(self)
        [self.view removeAllSubviews];
        [self.loginVC removeFromParentViewController];
        
        self.tab = [TSTabBarController new];
        [self addChildViewController:self.tab];
        [self.view addSubview:self.tab.view];
    };
    
    [TSUserLoginManager shareInstance].logoutBlock = ^{
        @strongify(self)
        [self.view removeAllSubviews];
        [self.tab removeFromParentViewController];
        [[TSUserLoginManager shareInstance] configLoginController:^(UIViewController * _Nonnull vc) {
            @strongify(self)
            self.loginVC = vc;
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
        }];
    };
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
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
    TSHybridViewController *web = [[TSHybridViewController alloc] initWithURLString:[agreementModel.serverUrl stringByAppendingString:@"&mode=webview"]];
    web.delegate = self;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark - TSHybridViewControllerDelegate
-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param{
    
    
}

- (void)loginStateDidChanged:(NSNotification *)noti{
    TSLoginState state = ![noti.object intValue];
    if (state == TSLoginStateNone) {
        [self.view removeAllSubviews];
        [self.tab removeFromParentViewController];
        @weakify(self);
        [[TSUserLoginManager shareInstance] configLoginController:^(UIViewController * _Nonnull vc) {
            @strongify(self)
            self.loginVC = vc;
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
        }];
    }
   
}

- (void)authViewDealloc {
    
}

- (void)authViewDidAppear {
    [self showAlertInView:[UIApplication sharedApplication].keyWindow];
}

- (void)authViewDidDisappear {
    
}

- (void)authViewDidLoad {
    
}

- (void)authViewWillAppear {
    
}

- (void)authViewWillDisappear {
    
}


@end
