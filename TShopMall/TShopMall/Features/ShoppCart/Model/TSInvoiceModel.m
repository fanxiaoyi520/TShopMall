//
//  TSInvoiceModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/29.
//

#import "TSInvoiceModel.h"

@implementation TSInvoiceModel
+ (TSInvoiceModel *)creatWithInvoice:(NSDictionary *)invoice{
    return [TSInvoiceModel yy_modelWithDictionary:invoice];
}
@end
