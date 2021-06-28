//
//  TSH5InterfacedConst.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSH5InterfacedConst.h"

#ifdef DEBUG
    //服务器地址标志 0生产 1预发布 2 测试
    #define kH5ServerFlag 2

#else
    //服务器地址标志 0生产 1预发布 2 测试
    #define kH5ServerFlag 2

#endif

/*集团账户中心账号信息，不要手动修改*/

#if DEBUG

#if (kH5ServerFlag == 0)
    NSString * kMallH5ApiPrefix = @"https://m.tcl.com/seller-app-h5/";
#elif (kH5ServerFlag == 1)
    NSString * kMallH5ApiPrefix = @"https://prewap.tclo2o.cn/seller-app-h5/";
#elif (kH5ServerFlag == 2)
    NSString * kMallH5ApiPrefix = @"https://testwap.tclo2o.cn/seller-app-h5/";
#endif

#else

#if (kH5ServerFlag == 0)
    NSString *const kMallH5ApiPrefix = @"https://m.tcl.com/seller-app-h5/";
#elif (kH5ServerFlag == 1)
    NSString *const kMallH5ApiPrefix = @"https://prewap.tclo2o.cn/seller-app-h5/";
#elif (kH5ServerFlag == 2)
    NSString *const kMallH5ApiPrefix = @"https://testwap.tclo2o.cn/seller-app-h5/";
#endif

#endif


#pragma mark - 各页面

///订单列表
NSString *const kMallH5OrderManageUrl = @"pages/order/manage";
///订单详情
NSString *const kMallH5OrderDetailUrl = @"pages/order/detail";
///物流列表
NSString *const kMallH5LogisticsListUrl = @"pages/orderDeliver/logisticsDetail";
///物流详情
NSString *const kMallH5LogisticsDetailUrl = @"pages/orderDeliver/logisticsList";
///发票抬头
NSString *const kMallH5InvoiceUrl = @"pages/invoice/index";
///发票中心
NSString *const kMallH5InvoiceListUrl = @"pages/invoice/invoiceList";
///发票详情
NSString *const kMallH5InvoiceDetailUrl = @"pages/invoice/invoiceDetail";
///查看发票
NSString *const kMallH5InvoiceCheckUrl = @"pages/invoice/invoiceCheck";
///售后列表
NSString *const kMallH5RefundManageUrl = @"pages/refund/manage";
///售后详情
NSString *const kMallH5RefundDetailUrl = @"pages/refund/refund";
///退换货首页
NSString *const kMallH5RefundSelectUrl = @"pages/refund/select";
///申请退换货
NSString *const kMallH5RefundApplyUrl = @"pages/refund/apply";
///合伙人中心
NSString *const kMallH5CopartnerUrl = @"pages/copartner/index";
