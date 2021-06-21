//
//  AppDelegate+Initialize.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/7.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Initialize)

/// 初始化网络配置
-(void)initNetworkConfig;

/// 设置以那种手机屏幕为基准UI适配
-(void)setUITemplateSize;

/// 设置键盘相关属性
-(void)setKeywordAttribute;

/// 导航栏统一配置
-(void)setNavigationConfig;

@end

NS_ASSUME_NONNULL_END
