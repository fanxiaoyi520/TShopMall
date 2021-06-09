//
//  TSLoginController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import "TSLoginController.h"
#import "TSBaseNavigationController.h"

@interface TSLoginController ()
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, copy) void(^loginFinished)(BOOL);
@end

@implementation TSLoginController

+ (void)loginFinished:(void (^)(BOOL))finished{
    TSLoginController *con = [TSLoginController new];
    con.loginFinished = finished;
    TSBaseNavigationController *naviCon = [[TSBaseNavigationController alloc] initWithRootViewController:con];
    naviCon.modalPresentationStyle = UIModalPresentationFullScreen;
    UITabBarController *tabbarCon = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    [tabbarCon presentViewController:naviCon animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenNavigationBar];
}

- (void)viewWillLayoutSubviews{
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(21);
        make.top.equalTo(self.view.mas_top).offset(self.view.statusBarHight + 34.0);
        make.width.height.mas_equalTo(16.0);
    }];
}

- (UIButton *)cancelBtn{
    if (_cancelBtn) {
        return _cancelBtn;
    }
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:self.cancelBtn];
    
    return self.cancelBtn;
}
@end
