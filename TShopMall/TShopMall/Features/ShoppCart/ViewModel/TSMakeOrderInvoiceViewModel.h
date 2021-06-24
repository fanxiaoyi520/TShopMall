//
//  TSMakeOrderInvoiceViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import <Foundation/Foundation.h>

@interface TSMakeOrderInvoiceViewModel : NSObject
@property (nonatomic, copy) NSString *type;//发票类型
@property (nonatomic, copy) NSString *invoiceTitle;//发票抬头
@property (nonatomic, copy) NSString *invoiceTitleType;//发票抬头类型
@property (nonatomic, copy) NSString *companyName;//单位名称
@property (nonatomic, copy) NSString *code;//税号
@property (nonatomic, copy) NSString *registerAddress;
@property (nonatomic, copy) NSString *registerPhone;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankCode;
@property (nonatomic, copy) NSString *invoiceUuid;

@property (nonatomic, copy) NSString *message;//留言
@end

