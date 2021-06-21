//
//  AppDelegate+RootController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate+RootController.h"
#import "TSTabBarController.h"
#import "TSLoginViewController.h"

@implementation AppDelegate (RootController)

-(void)setupRootController{
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[TSLoginViewController alloc] init];
    [self.window makeKeyAndVisible];
}

@end
