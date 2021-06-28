//
//  TSMakeOrderCommitOrderDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import "TSMakeOrderCommitOrderDataController.h"

@implementation TSMakeOrderCommitOrderDataController
+ (void)commitOrderWithAddress:(TSAddressModel *)address balanceInfo:(TSBalanceModel *)balanceInfo invoice:(TSMakeOrderInvoiceViewModel *)invoice isFromCart:(BOOL)isFromCart finished:(void(^)(BOOL, NSString *, NSString *))finished OnController:(UIViewController *)controller{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"noCart"] = @(!isFromCart);
    params[@"checkArea"] = address.uuid;
    params[@"area"] = address.area;
    params[@"orderFrom"] = @"11";
    params[@"jifenPromotionUUID"] = balanceInfo.limitPromotionUuid;
    params[@"integralReduceNum"] = @"";//积分扣减金额
    params[@"totalMoneyShow"] = balanceInfo.orderTotalMoney;//订单总价
    
//    params[@"invoiceCate"] = invoice.type.length==0? @"":invoice.type;
//    params[@"invoiceUuid"] = invoice.invoiceUuid.length==0? @"":invoice.invoiceUuid;
//    params[@"electron_titleContent"] = invoice.invoiceTitle.length==0? @"":invoice.invoiceTitle;
//    params[@"electron_code"] = invoice.code.length==0? @"":invoice.code;
//    params[@"add_companyName"] = invoice.companyName.length==0? @"":invoice.companyName;
//    params[@"add_code"] = @"";
//    params[@"add_address"] = invoice.registerAddress.length==0? @"":invoice.registerAddress;
//    params[@"add_registerMobile"] = invoice.registerPhone.length==0? @"":invoice.registerPhone;
    
    for (TSBalanceCartManagerDetailModel *detail in balanceInfo.cartManager.detailModelList) {
        params[[NSString stringWithFormat:@"productPrice_%@", detail.attrAndValue]] = detail.totalPrice;
        params[[NSString stringWithFormat:@"productBasePrice_%@", detail.attrAndValue]] = detail.basePrice;
        params[[NSString stringWithFormat:@"productNowPrice_%@", detail.attrAndValue]] = detail.nowPrice;
        params[[NSString stringWithFormat:@"productNum_%@", detail.attrAndValue]] = [NSString stringWithFormat:@"%ld", detail.buyNum];
    }
    
    params[[NSString stringWithFormat:@"cartTotal_%@", balanceInfo.cartManager.storeUuid]] = balanceInfo.cartManager.totalMoney;
    params[[NSString stringWithFormat:@"affix_%@", balanceInfo.cartManager.storeUuid]] = balanceInfo.cartManager.affix;
    params[[NSString stringWithFormat:@"shipType_%@", balanceInfo.cartManager.storeUuid]] = balanceInfo.cartManager.shipType;
    params[[NSString stringWithFormat:@"storeReduce_%@", balanceInfo.cartManager.storeUuid]] = balanceInfo.cartManager.reduceMoney;
    params[[NSString stringWithFormat:@"storeNote_%@", balanceInfo.cartManager.storeUuid]] = invoice.message;//买家留言
    

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSaveOrder
                                                                requestMethod:YTKRequestMethodPOST
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                               needErrorToast:YES];
    request.animatingView = controller.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.responseModel);
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseObject[@"data"];
            NSString *payOrderId  = data[@"payOrderId"];
            NSString *isGroup = data[@"isGroup"];
            NSString *indentOrderId = data[@"indentOrderId"];
            finished(YES, payOrderId, isGroup);
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Popover popToastOnWindowWithText:request.responseObject[@"message"]];
            });
            finished(NO, @"", @"");
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Popover popToastOnWindowWithText:request.responseObject[@"message"]];
        });
        finished(NO, @"", @"");
    }];
}
@end
