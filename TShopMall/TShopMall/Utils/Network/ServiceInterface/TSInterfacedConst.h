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
///  一键登录
UIKIT_EXTERN NSString *const kOneStepLoginUrl;
///  第三方Token登录接口
UIKIT_EXTERN NSString *const kLoginByTokenUrl;
/// 将第三方应用如微信小程序通过授权码登录
UIKIT_EXTERN NSString *const kLoginByAuthCode;
/// 第三方绑定用户信息接口
UIKIT_EXTERN NSString *const kBindUserByAuthCode;
/// 协议信息的接口
UIKIT_EXTERN NSString *const kLoginRegisterAgreementUrl;
/// 获取用户信息的接口
UIKIT_EXTERN NSString *const kUserInfoUrl;
#pragma mark - 首页
UIKIT_EXTERN NSString *const kHomePageInfoUrl;
UIKIT_EXTERN NSString *const kSearchKey;//搜索关键词
UIKIT_EXTERN NSString *const kSearchAssociateWord;//搜索联想关键词
UIKIT_EXTERN NSString *const kSearchHotKey;//搜索热门关键词
UIKIT_EXTERN NSString *const kSearchResult;//搜索结果

#pragma mark - 商品详情
UIKIT_EXTERN NSString *const kGoodDetailUrl;
UIKIT_EXTERN NSString *const kGoodDetailCartNumberUrl;
UIKIT_EXTERN NSString *const kGoodDetailAddProductToCartUrl;
UIKIT_EXTERN NSString *const kGoodDetailHasProductUrl;
UIKIT_EXTERN NSString *const kGoodDetailChangeChooseUrl;
UIKIT_EXTERN NSString *const kGoodDetailFastBuyUrl;
UIKIT_EXTERN NSString *const kGoodDetailCarriageCostUrl;

#pragma mark - 分类
UIKIT_EXTERN NSString *const kShopContentUrl;
UIKIT_EXTERN NSString *const kProducts;//商品列表

#pragma mark - 排行

#pragma mark - 采购蓝
UIKIT_EXTERN NSString * const kCartShow;
UIKIT_EXTERN NSString * const kCartChangeChoose;
UIKIT_EXTERN NSString * const kCartChangeNums;
UIKIT_EXTERN NSString * const kCartRemove;
UIKIT_EXTERN NSString * const kCartCount;

#pragma mark - 下单
UIKIT_EXTERN NSString * const kToBalance;
UIKIT_EXTERN NSString * const kSaveOrder;
UIKIT_EXTERN NSString * const kOrderPay;
UIKIT_EXTERN NSString * const kPayChanne;
UIKIT_EXTERN NSString * const kSubmitOrder;
UIKIT_EXTERN NSString * const kMockPay;

#pragma mark - 地址
UIKIT_EXTERN NSString * const kProvice;
UIKIT_EXTERN NSString * const kCities;
UIKIT_EXTERN NSString * const kAreas;
UIKIT_EXTERN NSString * const kStreets;
UIKIT_EXTERN NSString * const kAddAddress;
UIKIT_EXTERN NSString * const kEditAddress;
UIKIT_EXTERN NSString * const kDeleteAddress;
UIKIT_EXTERN NSString * const kCustomerAddress;
UIKIT_EXTERN NSString * const kAddressTag;
UIKIT_EXTERN NSString * const kSmartAddress;

#pragma mark - 我的
UIKIT_EXTERN NSString * const kMineMerchantUserInformation;
UIKIT_EXTERN NSString * const kMinePartnerCenterData;

UIKIT_EXTERN NSString * const kMineWithdrawalRecordListData;//提现记录
UIKIT_EXTERN NSString * const kMineWalletData;//我的钱包
UIKIT_EXTERN NSString * const kMineQueryProfit;//我的收益
//广告图
UIKIT_EXTERN NSString * const kMineShopContentUrl;

#pragma mark - 设置
UIKIT_EXTERN NSString *const kAboutMeAgreementUrl;
UIKIT_EXTERN NSString *const kModifyUserUrl;

UIKIT_EXTERN NSString * const kMineWithdrawalApply;//提现申请
UIKIT_EXTERN NSString * const kMineQueryAppBankCardAccountList;//查询银行卡列表
UIKIT_EXTERN NSString * const kMineAddBankCardAccount;//添加银行卡
UIKIT_EXTERN NSString * const kMineBankNoCheck;//校验银行卡
UIKIT_EXTERN NSString * const kMineGetBankInfo;//查询支行
UIKIT_EXTERN NSString * const kMineDelBankCardAccount;//删除银行卡
UIKIT_EXTERN NSString * const kMineQueryAmount;//查询我的余额
UIKIT_EXTERN NSString * const kAboutMeAgreementUrl;
