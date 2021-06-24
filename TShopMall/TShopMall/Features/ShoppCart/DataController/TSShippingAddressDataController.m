//
//  TSShippingAddressDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSShippingAddressDataController.h"

@interface TSShippingAddressDataController ()
@end

@implementation TSShippingAddressDataController
+ (void)fetchAddress:(void (^)(NSArray<TSAddressModel *> *))finished lodingView:(UIView *)view{
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kCustomerAddress
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{}
                                                               needErrorToast:YES];
    request.animatingView = view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseObject[@"data"];
            NSArray *deliveryAddressList = data[@"deliveryAddressList"];
            NSArray<TSAddressModel *> *addresses = [NSArray yy_modelArrayWithClass:TSAddressModel.class json:deliveryAddressList];
            finished(addresses);
        } else {
            finished(nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        finished(nil);
    }];
}

+ (void)deleteAddress:(TSAddressModel *)address finished:(void (^)(void))finished lodingView:(UIView *)view{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kDeleteAddress
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{@"uuid":address.uuid}
                                                               needErrorToast:YES];
    request.animatingView = view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            finished();
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Popover popToastOnWindowWithText:request.responseObject[@"message"]];
            });
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Popover popToastOnWindowWithText:request.responseObject[@"message"]];
        });
    }];
}


@end
