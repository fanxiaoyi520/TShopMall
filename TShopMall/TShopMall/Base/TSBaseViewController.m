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
    [self setupNavigationBar];
    [self fillCustomView];
}

#pragma mark - 基本设置
-(void)setupBasic
{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 设置导航栏
-(void)setupNavigationBar
{
    
}

#pragma mark - 隐藏导航栏
-(void)hiddenNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = UIImage.new;
}

#pragma mark - 添加子控件
-(void)fillCustomView
{
    
}

@end
