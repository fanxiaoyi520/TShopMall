//
//  TSInterfacedConst.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <UIKit/UIKit.h>

#pragma mark - AppId账号信息
/// AppId
UIKIT_EXTERN NSString *const kAppId;
/// AppSecret
UIKIT_EXTERN NSString *const kAppSecret;

#pragma mark - 接口前缀
/// 账号中心接口前缀
UIKIT_EXTERN NSString *const kAccountCenterApiPrefix;
/// 商城接口前缀
UIKIT_EXTERN NSString *const kMallApiPrefix;

#pragma mark - 注册&登录
/// 登录获取验证码
UIKIT_EXTERN NSString *const kLoginSmsCaptchaUrl;
/// 快速登录
UIKIT_EXTERN NSString *const kLoginQuickLoginUrl;
///  注册
UIKIT_EXTERN NSString *const kRegisterUrl;
///  登出
UIKIT_EXTERN NSString *const kLogoutUrl;

#pragma mark - 首页
UIKIT_EXTERN NSString *const kHomePageInfoUrl;
UIKIT_EXTERN NSString *const kSearchKey;//搜索关键词
UIKIT_EXTERN NSString *const kSearchAssociateWord;//搜索联想关键词
UIKIT_EXTERN NSString *const kSearchHotKey;//搜索热门关键词
UIKIT_EXTERN NSString *const kSearchResult;//搜索结果

#pragma mark - 分类
UIKIT_EXTERN NSString *const kShopContentUrl;
UIKIT_EXTERN NSString *const kProducts;//商品列表

#pragma mark - 排行

#pragma mark - 采购蓝
UIKIT_EXTERN NSString * const kProvice;
UIKIT_EXTERN NSString * const kCities;
UIKIT_EXTERN NSString * const kAreas;
UIKIT_EXTERN NSString * const kStreets;

#pragma mark - 我的
