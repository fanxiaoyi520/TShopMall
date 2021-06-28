//
//  TSPayStyleDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPayStyleDataController.h"

@interface TSPayStyleDataController()
@property (nonatomic, copy) void(^finished)(BOOL);
@end

@implementation TSPayStyleDataController

- (void)fetchPayStyle:(NSString *)payOrderId finished:(void(^)(BOOL))finished{
    self.finished = finished;
    SSGenaralRequest *req = [TSPayStyleDataController payStyleRequestWithPayOrderId:payOrderId];
    req.animatingView = self.context.view;
    [req startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    }];
}

+ (SSGenaralRequest *)payStyleRequestWithPayOrderId:(NSString *)payOrderId{
    return [[SSGenaralRequest alloc] initWithRequestUrl:kPayChanne
                                          requestMethod:YTKRequestMethodPOST
                                  requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                          requestHeader:NSMutableDictionary.dictionary
                                            requestBody:@{@"payOrderId":payOrderId}
                                         needErrorToast:YES];
}

- (void)handlePayInfoReques:(SSGenaralRequest *)request{
    NSLog(@"%@", request.responseJSONObject);
    if (request.responseModel.isSucceed) {
        NSDictionary *data = request.responseJSONObject[@"data"];
        NSArray *payChannelList = data[@"payChannelList"];
        self.payStyles = [NSArray yy_modelArrayWithClass:TSPayStyleModel.class json:payChannelList];
        self.finished(YES);
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Popover popToastOnView:self.context.view text:request.responseModel.responseMsg];
        });
        self.finished(NO);
    }
}

@end
