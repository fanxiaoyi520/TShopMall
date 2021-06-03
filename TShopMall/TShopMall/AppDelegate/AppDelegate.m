//
//  AppDelegate.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[TSTabBarController alloc] init];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - 网络配置
- (void)setupRequestFilters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    [config setBaseUrl:kApiPrefix];
}


@end
