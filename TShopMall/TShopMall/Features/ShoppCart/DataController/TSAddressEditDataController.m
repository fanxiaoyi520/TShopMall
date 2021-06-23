//
//  TSAddressEditDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/23.
//

#import "TSAddressEditDataController.h"

@interface TSAddressEditDataController()
@end

@implementation TSAddressEditDataController


+ (void)editAddress:(NSDictionary *)address finished:(void(^)(BOOL isSuccess))finished controller:(UIViewController *)controller{
   SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kAddAddress
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:address
                                                              needErrorToast:YES];
    request.animatingView = controller.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            finished(YES);
        } else {
            finished(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        finished(NO);
    }];
}

@end
