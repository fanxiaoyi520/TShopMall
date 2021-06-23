//
//  AppDelegate.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#import "AppDelegate+Initialize.h"
#import "NSObject+TSProperty.h"
#import "NSString+Plugin.h"

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

- (UIViewController *)getCurrentVC{
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    //其他框架可能会改我们的keywindow，比如支付宝支付，qq登录都是在一个新的window上，这时候的keywindow就不是appdelegate中的window。 当然这里也可以直接用APPdelegate里的window。
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController* currentViewController = window.rootViewController;
    while (YES) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}

- (void)openURI:(NSString *_Nullable)uri {
    NSLog(@"AppDelegate 中 uri==%@",uri);
    
    Class cls = NSClassFromString([self getClassDict][[uri componentsSeparatedByString:@"?"].firstObject]);
    if (cls == nil) { return; }
    
    UIViewController *obj = [[cls alloc] init];
    if (obj == nil || ![obj isKindOfClass:[UIViewController class]]) {
        return;
    }

    for (NSString *propertyKey in obj.ts_validProperties) {
        NSObject *propertyValue = [uri.ts_urlParsing objectForKey:propertyKey];
        if (propertyValue) {
            [obj setValue:propertyValue forKey:propertyKey];
        }
    }
    
    [self.getCurrentVC.navigationController pushViewController:obj animated:YES];
}

- (NSDictionary *)getClassDict {
    return @{
        @"page://quote/detailList": @"CMSQuoteDetailListViewController",
        @"page://quote/config": @"CMSQuotesConfigViewController",
    };
}
@end
