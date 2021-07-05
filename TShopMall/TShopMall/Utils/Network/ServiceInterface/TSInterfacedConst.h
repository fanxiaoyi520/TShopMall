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
/// 换绑手机号
UIKIT_EXTERN NSString *const kChangeBindMobileUrl;
/// 注销账号
UIKIT_EXTERN NSString *const kAccountCancelUrl;
///  取消注销账号
UIKIT_EXTERN NSString *const kAccountCancelBackUrl;
///  查询注销状态
UIKIT_EXTERN NSString *const kAccountCancelInfoUrl;
///手机号校验分销员是否存在
UIKIT_EXTERN NSString *const kAccountCheckSalesmanWithMobileUrl;
///Token校验分销员是否存在
UIKIT_EXTERN NSString *const kAccountCheckSalesmanWithTokenUrl;
///Token刷新
UIKIT_EXTERN NSString *const kAccountRefershTokenUrl;
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
UIKIT_EXTERN NSString *const kGoodDetailStaffShareUrl;
UIKIT_EXTERN NSString *const kGoodDetailSetProductDiscountPriceUrl;

#pragma mark - 分类
UIKIT_EXTERN NSString *const kShopContentUrl;
UIKIT_EXTERN NSString *const kProducts;//商品列表

#pragma mark - 排行
UIKIT_EXTERN NSString * const kRankSaleRankUrl;
UIKIT_EXTERN NSString * const kRankProfitRankUrl;

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
UIKIT_EXTERN NSString * const kMineShopContentUrl;//广告图
UIKIT_EXTERN NSString *const kMineOrderCount;//查询订单各状态下的订单数
//通过手机号、商户、来源（app）查询邀请码
UIKIT_EXTERN NSString *const kCustomerInvitationCode;
//一级分销员通过邀请码推广记录
UIKIT_EXTERN NSString *const kSalesmanInvitationRecord;
#pragma mark - 设置
UIKIT_EXTERN NSString *const kCheckCodeUrl;
UIKIT_EXTERN NSString *const kAboutMeAgreementUrl;
UIKIT_EXTERN NSString *const kModifyUserUrl;
UIKIT_EXTERN NSString *const kUploadImageUrl;
UIKIT_EXTERN NSString *const kSetWithdrawalPwdUrl;
UIKIT_EXTERN NSString *const kCheckWithdrawalPwdUrl;

UIKIT_EXTERN NSString * const kMineWithdrawalApply;//提现申请
UIKIT_EXTERN NSString * const kMineQueryAppBankCardAccountList;//查询银行卡列表
UIKIT_EXTERN NSString * const kMineAddBankCardAccount;//添加银行卡
UIKIT_EXTERN NSString * const kMineBankNoCheck;//校验银行卡
UIKIT_EXTERN NSString * const kMineGetBankInfo;//查询支行
UIKIT_EXTERN NSString * const kMineDelBankCardAccount;//删除银行卡
UIKIT_EXTERN NSString * const kMineQueryAmount;//查询我的余额
UIKIT_EXTERN NSString * const kMineGetBankNames;//查询银行列表
UIKIT_EXTERN NSString * const kAboutMeAgreementUrl;
UIKIT_EXTERN NSString * const kSecurCenterAgreementUrl;//安全中心协议
UIKIT_EXTERN NSString * const kMineGetAllProvince;//获取全部省和直辖市
UIKIT_EXTERN NSString * const kMineGetAllCityByProvinceUuid;//根据省份uuid获取它下面的城市
