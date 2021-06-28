//
//  TSAddressSmartDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSAddressSmartDataController.h"

@implementation TSAddressSmartDataController

+ (void)smartAddress:(NSString *)addressStr finished:(void(^)(TSAddressModel *))finished onController:(UIViewController *)controller{
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSmartAddress
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{@"deliverInfo":addressStr}
                                                              needErrorToast:YES];
    request.animatingView = controller.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseObject[@"data"];
            TSAddressModel *model  = [TSAddressModel yy_modelWithDictionary:data];
            finished(model);
        } else{
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
