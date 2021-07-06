//
//  TSInterfacedConst.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSInterfacedConst.h"

#ifdef DEBUG
    //集团账号中心 0生产 1预发布 2测试 3开发
    #define kAccountCenterFlag 3
    //是否打开调试模式，<<Release包记得改为0！>>1:是，0：否，打开后影响微信分享、百度地图、极光推送、debug包修改配置
    #define kEnableDebug 1
    //服务器地址标志 0生产 1预发布 2 测试
    #define kServerFlag 2
    //账户中心服务器地址标志 0生产 1预发布 2 测试 3开发环境
    #define kAccountCenterServerFlag 2

#else
    //集团账号中心 0生产 1预发布 2测试 3开发
    #define kAccountCenterFlag 3
    //是否打开调试模式，<<Release包记得改为0！>>1:是，0：否，打开后影响微信分享、百度地图、极光推送、debug包修改配置
    #define kEnableDebug 1
    //服务器地址标志 0生产 1预发布 2 测试
    #define kServerFlag 2
    //账户中心服务器地址标志 0生产 1预发布 2 测试 3开发环境
    #define kAccountCenterServerFlag 2

#endif


#if (kEnableDebug == 1)
    /*打开调试模式时*/
    #define kWechatKey @"wx79ef802e0697f041" //微信key

#else
    /*关闭调试模式*/
    #define kWechatKey @"wx4d31f4cd66c6bddf"

#endif

/*集团账户中心账号信息，不要手动修改*/
#if (kServerFlag == 0)
    NSString *const kAppId = @"";
    NSString *const kAppSecret = @"";
#elif (kServerFlag == 1)
    NSString *const kAppId = @"66191623737327854";
    NSString *const kAppSecret = @"650eb6547a8386b8a9dfa81d51be922b7e571583ecdd0cc6a3ec61f1eefcb573";
#elif (kServerFlag == 2)
    NSString *const kAppId = @"37011623737219069";
    NSString *const kAppSecret = @"e545f8fbf9c659823e4a0b14383a6098a89cdb7da20122724efc0ce704e7a8b9";
#elif (kServerFlag == 3)
    NSString *const kAppId = @"84601623736956822";
    NSString *const kAppSecret = @"7803d548944e4e0cb26f5d032496a64b653ba11ddea54a3ca44f4f6e5b454907";
#endif

/*服务器地址，不要手动修改以下地址*/
#if (kServerFlag == 0)
    NSString *const kMallApiPrefix = @"https://api.tcl.com/";
#elif (kServerFlag == 1)
    NSString *const kMallApiPrefix = @"https://prepc.tclo2o.cn/";
#elif (kServerFlag == 2)
    NSString *const kMallApiPrefix = @"https://testpc.tclo2o.cn/rest";
#endif

/*账户中心服务器地址，不要手动修改*/
#if (kAccountCenterServerFlag == 0)
    NSString *const kAccountCenterApiPrefix = @"https://cn.account.tcl.com";
#elif (kAccountCenterServerFlag == 1)
    NSString *const kAccountCenterApiPrefix = @"https://account-uat.tcljd.com";
#elif (kAccountCenterServerFlag == 2)
    NSString *const kAccountCenterApiPrefix = @"https://account-sit.tcljd.com";
#elif (kAccountCenterServerFlag == 3)
    NSString *const kAccountCenterApiPrefix = @"https://account-dev.tcljd.com";
#endif


#pragma mark - 注册&登录
NSString *const kLoginSmsCaptchaUrl = @"/captcha/captcha/smsCaptcha";
NSString *const kLoginQuickLoginUrl = @"/auth/auth/quickLogin";
NSString *const kRegisterUrl = @"/rest/sysback/salesman/registered/distributor";
NSString *const kLogoutUrl = @"/auth/auth/signOut";
NSString *const kOneStepLoginUrl = @"/auth/auth/oneClickLogin";
NSString *const kLoginByTokenUrl = @"/auth/thirdParty/loginByToken";
NSString *const kLoginByAuthCode = @"/auth/thirdParty/loginByAuthCode";
NSString *const kBindUserByAuthCode = @"/auth/thirdParty/bindUserByAuthCode";
NSString *const kLoginRegisterAgreementUrl = @"/rest/v2/front/shopStatement/getShopStatementAuthList";
NSString *const kUserInfoUrl = @"/user/user/info";
NSString *const kChangeBindMobileUrl = @"/auth/account/changeBind";
NSString *const kAccountCancelUrl = @"/auth/account/cancel";
NSString *const kAccountCancelBackUrl = @"/auth/account/cancelBack";
NSString *const kAccountCancelInfoUrl = @"/auth/account/cancelInfo";
NSString *const kAccountCheckSalesmanWithMobileUrl = @"/rest/sysback/salesman/checkSalesman";
NSString *const kAccountCheckSalesmanWithTokenUrl = @"/rest/sysback/salesman/checkSalesmanByToken";
NSString *const kAccountRefershTokenUrl = @"/auth/auth/refershToken";
NSString *const kAccountPublicKeyUrl = @"/auth/common/publicKey";
#pragma mark - 首页

NSString *const kHomePageInfoUrl = @"/rest/v2/front/shopContent/getIndexPageInfo";

NSString * const kSearchKey = @"/rest/v2/front/product/queryKeyWord";
NSString * const kSearchAssociateWord = @"/rest/v2/front/product/associateWord";
NSString * const kSearchHotKey = @"/rest/v2/front/product/queryKeyWord";
NSString * const kSearchResult = @"/rest/v2/itemsearch/toProductList";

#pragma mark - 商品详情
NSString *const kGoodDetailUrl = @"/rest/v2/front/product/toProduct";
NSString *const kGoodDetailCartNumberUrl = @"/rest/v2/cart/count";
NSString *const kGoodDetailAddProductToCartUrl = @"/rest/v2/front/product/addProductToCart";
NSString *const kGoodDetailHasProductUrl = @"/rest/v2/front/product/hasProduct";
NSString *const kGoodDetailChangeChooseUrl = @"/rest/v2/cart/changeChoose";
NSString *const kGoodDetailFastBuyUrl = @"/rest/v2/front/product/fastBuy";
NSString *const kGoodDetailCarriageCostUrl = @"/rest/v2/front/product/getCarriageCost";
NSString *const kGoodDetailStaffShareUrl = @"/rest/v2/usercenter/staffShare/toShare";
NSString *const kGoodDetailSetProductDiscountPriceUrl = @"/rest/v2/usercenter/staffbuy/setProductDiscountPrice";

#pragma mark - 分类
NSString *const kShopContentUrl = @"/rest/v2/front/shopContent/getPageManageByPageType";
NSString * const kProducts = @"/rest/v2/product/category/groups/searchProducts";

#pragma mark - 排行
NSString * const kRankSaleRankUrl = @"/rest/v2/salesman/rank/saleRank";
NSString * const kRankProfitRankUrl = @"/rest/v2/salesman/rank/profitRank";

#pragma mark - 采购蓝
NSString * const kCartShow = @"/rest/v2/cart/show";
NSString * const kCartChangeChoose = @"/rest/v2/cart/changeChoose";
NSString * const kCartChangeNums = @"/rest/v2/cart/changeNums";
NSString * const kCartRemove = @"/rest/v2/cart/remove";
NSString * const kCartCount = @"/rest/v2/cart/count";

#pragma  mark - 下单
NSString * const kToBalance = @"/rest/v2/order/toBalance";
NSString * const kSaveOrder = @"/rest/v2/cart/saveOrder";
NSString * const kOrderPay = @"/rest/v2/orderpay/toOrderPay";
NSString * const kPayChanne = @"/rest/v2/tcl_pay/getPayChannelList";
NSString * const kSubmitOrder = @"/rest/v2/tcl_pay/submitOrder";
NSString * const kMockPay = @"/rest/pay/submitorderKuyuTest";//模拟支付

#pragma mark - 地址
NSString * const kProvice = @"/rest/v2/usercenter/region/getAllProvince";
NSString * const kCities = @"/rest/v2/usercenter/region/getCitysByProvinceUuid";
NSString * const kAreas = @"/rest/v2/usercenter/region/getRegionsByCityUuid";
NSString * const kStreets = @"/rest/v2/usercenter/region/getStreetsByRegionUuid";
NSString * const kAddAddress = @"/rest/v2/usercenter/customeraddress/addAddress";
NSString * const kEditAddress = @"/rest/v2/usercenter/customeraddress/doEdit";
NSString * const kDeleteAddress = @"/rest/v2/usercenter/customeraddress/delDeliveryAddress";
NSString * const kCustomerAddress = @"/rest/v2/usercenter/customeraddress/toCustomerAddress";
NSString * const kAddressTag = @"/v2/usercenter/customerAddressTag/list";
NSString * const kSmartAddress = @"/rest/v2/usercenter/customeraddress/getSmartAddress";

#pragma mark - 我的
NSString * const kMineMerchantUserInformation = @"v2/login/userInfo";
//NSString * const kMineMerchantUserInformation = @"v2/login/userInfo";
NSString * const kMinePartnerCenterData = @"v2/sysback/salesman/dataCenter";
NSString * const kMineWithdrawalRecordListData = @"/rest/v2/withdrawal/record/queryAppWithdrawalRecordList";
NSString * const kMineWalletData = @"/rest/v2/withdrawal/record/queryWallet";
NSString *const kMineQueryProfit = @"/rest/v2/withdrawal/record/queryProfit";
//广告图
NSString * const kMineShopContentUrl = @"v2/front/shopContent/getPageManageByPageType";
//查询订单各状态下的订单数
NSString *const kMineOrderCount = @"v2/usercenter/order/query/queryAllStatusOrderCountByGroup";
//通过手机号、商户、来源（app）查询邀请码
NSString *const kCustomerInvitationCode  = @"v2/sysback/salesman/get/customer/invitationCode";
//一级分销员通过邀请码推广记录
NSString *const kSalesmanInvitationRecord = @"v2/sysback/salesman/get/salesman/page";
#pragma mark - 设置
NSString *const kCheckCodeUrl = @"/captcha/captcha/checkCaptcha";
NSString *const kAboutMeAgreementUrl = @"/rest/v2/front/shopStatement/getShopStatementList";
NSString *const kModifyUserUrl = @"/user/mng/user";
NSString *const kUploadImageUrl = @"/rest/v2/usercenter/batchfileupload/batch/upload";
NSString *const kSetWithdrawalPwdUrl = @"/usercenter/customer/setCustomerWithdrawalPwd";
NSString *const kCheckWithdrawalPwdUrl = @"/usercenter/customer/checkWithdrawalPwd";

NSString *const kMineWithdrawalApply = @"/rest/v2/withdrawal/record/withdrawalApply";
NSString *const kMineQueryAppBankCardAccountList = @"/rest/v2/bankCardAccount/queryAppBankCardAccountList";
NSString *const kMineAddBankCardAccount = @"/rest/v2/bankCardAccount/addBankCardAccount";
NSString *const kMineBankNoCheck = @"/rest/v2/bankCardAccount/bankNoCheck";
NSString *const kMineGetBankInfo = @"/rest/v2/bankCardAccount/getBankInfo";
NSString *const kMineDelBankCardAccount = @"/rest/v2/bankCardAccount/delBankCardAccount";
NSString *const kMineQueryAmount = @"/rest/v2/withdrawal/record/queryAmount";
NSString *const kMineGetBankNames = @"/rest/v2/bankCardAccount/getBankNames";
NSString *const kSecurCenterAgreementUrl = @"/rest/v2/front/shopStatement/getShopStatementList";
NSString *const kMineGetAllProvince = @"/rest/v2/withdrawal/record/getAllProvince";
NSString *const kMineGetAllCityByProvinceUuid = @"/rest/v2/withdrawal/record/getAllCityByProvinceUuid";
NSString *const kMineGetPublicKey = @"/rest/usercenter/customer/security";
NSString *const kMineCheckWhetherSetWithdrawalPwd = @"/rest/usercenter/customer/checkWhetherSetWithdrawalPwd";
NSString * const kMineCheckWithdrawalPwd = @"/rest/usercenter/customer/checkWithdrawalPwd";
NSString * const kMineCheckRealAuth = @"/usercenter/customer/checkRealAuth";//查询是否已实名认证
NSString * const kMineRealAuth = @"/usercenter/customer/realAuth";//实名认证
NSString * const kShopStatement = @"v2/front/shopStatement/getShopStatementListByState"; 
