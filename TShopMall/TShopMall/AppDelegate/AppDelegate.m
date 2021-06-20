//
//  AppDelegate.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#import "AppDelegate+Initialize.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self initNetworkConfig];
    [self setUITemplateSize];
    [self setKeywordAttribute];
    [self setNavigationConfig];
    [self setupRootController];
    return YES;
}


@end
