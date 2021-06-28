//
//  TSPayInfoDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPayInfoDataController.h"

@interface TSPayInfoDataController()
@property (nonatomic, copy) void(^finished)(BOOL);
@end

@implementation TSPayInfoDataController

- (void)fetchPayInfo:(NSString *)payOrderId isGroup:(NSString *)isGroup finished:(void(^)(BOOL))finished{
    self.finished = finished;
    SSGenaralRequest *req = [TSPayInfoDataController payInfoRequestWith:payOrderId isGroup:isGroup];
    req.animatingView = self.context.view;
    [req startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    }];
}

+ (SSGenaralRequest *)payInfoRequestWith:(NSString *)payOrderId isGroup:(NSString *)isGroup{
    NSDictionary *params = @{
        @"payOrderUuid" : payOrderId,
        @"payOrderType" : isGroup
    };
    return [[SSGenaralRequest alloc] initWithRequestUrl:kOrderPay
                                                                requestMethod:YTKRequestMethodPOST
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                               needErrorToast:YES];
}

- (void)handlePayInfoReques:(SSGenaralRequest *)request{
    NSLog(@"%@", request.responseJSONObject);
    if (request.responseModel.isSucceed) {
        NSDictionary *data = request.responseObject[@"data"];
        NSDictionary *order = data[@"order"];
        self.currentTimestamp = [NSString stringWithFormat:@"%@", order[@"currentTimestamp"]].doubleValue;
        self.payEndTimestamp = [NSString stringWithFormat:@"%@", order[@"payEndTimestamp"]].doubleValue;
        self.totalPayMoney = [NSString stringWithFormat:@"%@", order[@"totalPayMoney"]];
        self.finished(YES);
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Popover popToastOnView:self.context.view text:request.responseModel.responseMsg];
        });
        self.finished(NO);
    }
}

@end
