//
//  AppDelegate+Initialize.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/7.
//

#import "AppDelegate+Initialize.h"
#import "MyDimeScale.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <GKNavigationBarConfigure.h>
#import "WXApi.h"

#import "NSObject+TSProperty.h"
#import "NSString+Plugin.h"
#import "TSServicesManager.h"
#import "TSAccountConst.h"
#import "WechatShareManager.h"
@interface AppDelegate ()<TSUriHandler, WXApiDelegate>

@end

@implementation AppDelegate (Initialize)

-(void)setUITemplateSize{
    [MyDimeScale setUITemplateSize:CGSizeMake(375, 667)];
}

-(void)initNetworkConfig{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    [config setBaseUrl:kMallApiPrefix];
}

-(void)setKeywordAttribute{
    IQKeyboardManager *maneger = [IQKeyboardManager sharedManager];
    maneger.enable = YES;
    //点击空白区域回收键盘
    maneger.shouldResignOnTouchOutside = YES;
    //关闭自带键盘工具条
    maneger.enableAutoToolbar = NO;
    //是否显示占位文字
    maneger.shouldShowToolbarPlaceholder = NO;
    //设置键盘textField的距离，不能小于零，默认是10.0
    maneger.keyboardDistanceFromTextField = 60.0f;
}

-(void)setNavigationConfig {
    GKNavigationBarConfigure *config = [GKNavigationBarConfigure sharedInstance];
    [config setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
        configure.backgroundColor = [UIColor whiteColor];
        configure.titleColor = [UIColor blackColor];
        configure.titleFont = [UIFont systemFontOfSize:18.0f];
        configure.backStyle = GKNavigationBarBackStyleBlack;
        configure.gk_navItemLeftSpace = 12.0f;
        configure.gk_navItemRightSpace = 12.0f;
        configure.gk_openScrollViewGestureHandle = YES;
    }];
}

-(void)initWechatConfig{
      
//    [WXApi registerApp:WXAPPId universalLink:WXAPPLink];
    
    [WechatShareManager registerApp:WXAPPId universalLink:WXAPPLink];
    
}

- (void)initRouteConfig{
    [TSServicesManager sharedInstance].uriHandler = self;
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
        @"page://quote/productDetail": @"TSProductDetailController",
    };
}
@end
