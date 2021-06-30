//
//  TSH5InterfacedConst.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <UIKit/UIKit.h>
#if DEBUG
/// H5基本地址
UIKIT_EXTERN NSString * kMallH5ApiPrefix;
#else
/// H5基本地址
UIKIT_EXTERN NSString *const kMallH5ApiPrefix;
#endif
#pragma mark - 各页面
///订单列表
UIKIT_EXTERN NSString *const kMallH5OrderManageUrl;
///订单详情
UIKIT_EXTERN NSString *const kMallH5OrderDetailUrl;
///物流列表
UIKIT_EXTERN NSString *const kMallH5LogisticsListUrl;
///物流详情
UIKIT_EXTERN NSString *const kMallH5LogisticsDetailUrl;
///发票抬头
UIKIT_EXTERN NSString *const kMallH5InvoiceUrl;
///发票中心
UIKIT_EXTERN NSString *const kMallH5InvoiceListUrl;
///发票详情
UIKIT_EXTERN NSString *const kMallH5InvoiceDetailUrl;
///查看发票
UIKIT_EXTERN NSString *const kMallH5InvoiceCheckUrl;
///售后列表
UIKIT_EXTERN NSString *const kMallH5RefundManageUrl;
///售后详情
UIKIT_EXTERN NSString *const kMallH5RefundDetailUrl;
///退换货首页
UIKIT_EXTERN NSString *const kMallH5RefundSelectUrl;
///申请退换货
UIKIT_EXTERN NSString *const kMallH5RefundApplyUrl;
///合伙人中心
UIKIT_EXTERN NSString *const kMallH5CopartnerUrl;
///人工客服
UIKIT_EXTERN NSString *const kMallH5StaffServiceUrl;
///报装报修
UIKIT_EXTERN NSString *const kMallH5RepairsUrl;
///服务进度
UIKIT_EXTERN NSString *const kMallH5ServiceScheduleUrl;
///延保查询
UIKIT_EXTERN NSString *const kMallH5ExtendWarrantyUrl;
///故障自查
UIKIT_EXTERN NSString *const kMallH5FaultInspectionUrl;
///服务政策 & 收费标准
UIKIT_EXTERN NSString *const kMallH5ServicePolicyUrl;
///说明书
UIKIT_EXTERN NSString *const kMallH5InstructionUrl;
///服务工程师
UIKIT_EXTERN NSString *const kMallH5ServiceEngineerUrl;
