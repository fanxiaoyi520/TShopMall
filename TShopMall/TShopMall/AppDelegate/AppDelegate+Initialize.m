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
#import "AFNetworkReachabilityManager.h"
#import "TSBestSellingRecommendService.h"

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
//    maneger.enableAutoToolbar = NO;
    //是否显示占位文字
    maneger.shouldShowToolbarPlaceholder = NO;
    //设置键盘textField的距离，不能小于零，默认是10.0
    maneger.keyboardDistanceFromTextField = 60.0f;
}

-(void)setNavigationConfig {
    GKNavigationBarConfigure *config = [GKNavigationBarConfigure sharedInstance];
    [config setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
        configure.backgroundColor = [UIColor whiteColor];
        configure.titleColor = KTextColor;
        configure.titleFont = KRegularFont(18);
        configure.backStyle = GKNavigationBarBackStyleBlack;
        configure.gk_navItemLeftSpace = 12.0f;
        configure.gk_navItemRightSpace = 12.0f;
//        configure.backImage = [UIImage imageNamed:@"mall_navigationbar_back"];
        configure.gk_openScrollViewGestureHandle = YES;
    }];
}

-(void)initWechatConfig{
    [WechatShareManager registerApp:WXAPPId universalLink:WXAPPLink];
}

- (void)initRouteConfig{
    [TSServicesManager sharedInstance].uriHandler = [TSURLRouter sharedInstance];
}

- (void)initNetworkReachability {
    // 监听网络状况
    @weakify(self);
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /// 简化成两种状态 0 为 无网络 1 为有网络
        NSInteger state = status == AFNetworkReachabilityStatusNotReachable?0:1;
        if (state != 0) {
            @strongify(self)
            [self getNetData];
        }
       
    }];
    [mgr startMonitoring];
}

- (void)initService {
    [TSServicesManager sharedInstance].acconutService = [TSLoginRegisterDataController new];
    [TSServicesManager sharedInstance].bestSellingRecommendService = [TSBestSellingRecommendService new];
    [TSServicesManager sharedInstance].userInfoService = [TSUserInfoService new];
    [TSServicesManager sharedInstance].uploadImageService = [TSUploadImageService new];
}

- (void)getNetData {
    
    [[TSServicesManager sharedInstance].acconutService fetchAccountPublicKeyComplete:nil];
    
    [[TSServicesManager sharedInstance].userInfoService getUserInfoAccountId:[TSUserInfoManager userInfo].accountId success:^(TSUser * _Nonnull user) {
        [[TSUserInfoManager userInfo] updateUserInfo:nil];
    } failure:nil];
    [[TSServicesManager sharedInstance].acconutService fetchAgreementWithCompleted:^(NSArray<TSAgreementModel *> * _Nonnull agreementModels) {
        [TSGlobalManager shareInstance].agreementModels = agreementModels;
    }];
}


@end
