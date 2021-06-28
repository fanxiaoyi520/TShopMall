//
//  AppDelegate+RootController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate+RootController.h"
#import "TSTabBarController.h"
#import "TSMainViewController.h"
#import "TSBaseNavigationController.h"

@implementation AppDelegate (RootController)

-(void)setupRootController{
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    TSMainViewController *mainVC = [TSMainViewController new];
    TSBaseNavigationController *nav = [[TSBaseNavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

@end
