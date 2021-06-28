//
//  TSMainViewController.m
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import "TSMainViewController.h"
#import "TSUserLoginManager.h"
#import "TSTabBarController.h"

@interface TSMainViewController ()
@property (nonatomic, strong) UIViewController *loginVC;
@end

@implementation TSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    // Do any additional setup after loading the view.
    if ([TSUserLoginManager shareInstance].state == TSLoginStateNone) {
        
        
        
        
        [[TSUserLoginManager shareInstance] configLoginController:^(UIViewController * _Nonnull vc) {
            @strongify(self)
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
        }];
        
    }else{
       
        TSTabBarController *tab = [TSTabBarController new];
        [self addChildViewController:tab];
        [self.view addSubview:tab.view];
    }
    
    [TSUserLoginManager shareInstance].loginBlock = ^{
        @strongify(self)
        [self.view removeAllSubviews];
        [self removeFromParentViewController];
        TSTabBarController *tab = [TSTabBarController new];
        [self addChildViewController:tab];
        [self.view addSubview:tab.view];
    };
    
    [TSUserLoginManager shareInstance].logoutBlock = ^{
        @strongify(self)
        [self.view removeAllSubviews];
        [self removeFromParentViewController];
        [[TSUserLoginManager shareInstance] configLoginController:^(UIViewController * _Nonnull vc) {
            @strongify(self)
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
        }];
    };
    
}



@end
