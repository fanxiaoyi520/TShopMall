//
//  TSPayDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPayDataController.h"

@interface TSPayDataController()
@property (nonatomic, copy) void(^finished)(BOOL);
@end

@implementation TSPayDataController


- (void)goToPay:(void(^)(BOOL))isSuccess{
    self.finished = isSuccess;
    NSDictionary *params = @{
        @"orderId" : self.orderId,
        @"payChannel" :  self.payChannel,
        @"isWeixin" : @"0"
    };
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSubmitOrder
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    }];
}


- (void)handlePayInfoReques:(SSGenaralRequest *)request{
    NSLog(@"%@", request.responseJSONObject);
    if (request.responseModel.isSucceed) {
        NSDictionary *data = request.responseJSONObject[@"data"];
        NSString *html_form = data[@"html_form"];
        NSString *extra = data[@"extra"];
        self.awakeAppInfo = [html_form jsonValueDecoded];
        self.extra = [extra jsonValueDecoded];
        self.finished(YES);
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = request.responseJSONObject[@"message"];
            if (message.length == 0) {
                message = request.responseJSONObject[@"msg"];
            }
            [Popover popToastOnView:self.context.view text:message];
        });
        self.finished(NO);
    }
}


- (void)mockPay:(void (^)(BOOL))finished{
    self.finished = finished;
    NSDictionary *params = @{
        @"orderId" : self.orderId,
        @"payChannel" :  self.payChannel,
    };
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMockPay
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        NSString *msg = request.responseJSONObject[@"msg"];
        if ([msg isEqualToString:@"成功"]) {
            finished(YES);
        } else {
            [self handlePayInfoReques:request];
        }
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        [self handlePayInfoReques:request];
    }];
}

@end
