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
    #define kAccountCenterFlag 0
    //是否打开调试模式，<<Release包记得改为0！>>1:是，0：否，打开后影响微信分享、百度地图、极光推送、debug包修改配置
    #define kEnableDebug 0
    //服务器地址标志 0生产 1预发布 2 测试
    #define kServerFlag 0
    //账户中心服务器地址标志 0生产 1预发布 2 测试 3开发环境
    #define kAccountCenterServerFlag 0

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

#pragma mark - 首页

NSString *const kHomePageInfoUrl = @"/rest/v2/front/shopContent/getIndexPageInfo";

NSString * const kSearchKey = @"/rest/v2/front/product/queryKeyWord";
NSString * const kSearchAssociateWord = @"/rest/v2/front/product/associateWord";
NSString * const kSearchHotKey = @"/rest/v2/front/product/queryKeyWord";
NSString * const kSearchResult = @"/rest/v2/itemsearch/toProductList";
#pragma mark - 分类
NSString *const kShopContentUrl = @"/rest/v2/front/shopContent/getPageManageByPageType";
NSString * const kProducts = @"/rest/v2/product/category/groups/searchProducts";

#pragma mark - 排行

#pragma mark - 采购蓝
NSString * const kProvice = @"/rest/v2/usercenter/region/getAllProvince";
NSString * const kCities = @"/rest/v2/usercenter/region/getCitysByProvinceUuid";
NSString * const kAreas = @"/rest/v2/usercenter/region/getRegionsByCityUuid";
NSString * const kStreets = @"/rest/v2/usercenter/region/getStreetsByRegionUuid";



#pragma mark - 我的
