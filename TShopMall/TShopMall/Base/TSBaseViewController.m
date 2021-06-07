//
//  TSBaseViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSBaseViewController.h"

@interface TSBaseViewController ()

@end

@implementation TSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];
}

-(void)setupBasic
{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 隐藏导航栏
-(void)hiddenNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = UIImage.new;
}

@end
