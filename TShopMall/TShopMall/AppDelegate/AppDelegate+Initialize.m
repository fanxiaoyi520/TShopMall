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

#import "TSURLRouter.h"
#import "TSServicesManager.h"
#import "TSAccountConst.h"
#import "WechatShareManager.h"
@interface AppDelegate ()<WXApiDelegate>

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
    [WechatShareManager registerApp:WXAPPId universalLink:WXAPPLink];
}

- (void)initRouteConfig{
    [TSServicesManager sharedInstance].uriHandler = [TSURLRouter sharedInstance];
}


@end
