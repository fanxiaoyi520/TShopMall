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


+ (void)addAddress:(NSDictionary *)address finished:(void(^)(BOOL))finished controller:(UIViewController *)controller{
    [self addressOperation:NO address:address finished:finished controller:controller];
}

+ (void)editAddress:(NSDictionary *)address finished:(void (^)(BOOL))finished controller:(UIViewController *)controller{
    [self addressOperation:YES address:address finished:finished controller:controller];
}

+ (void)addressOperation:(BOOL)isEdit address:(NSDictionary *)address finished:(void (^)(BOOL))finished controller:(UIViewController *)controller{
    NSString *url = kEditAddress;
    if (isEdit == NO) {
        url = kAddAddress;
    }
    NSData *data= [NSJSONSerialization dataWithJSONObject:address options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    SSGenaralRequest *request = [self requestWithUrl:url method:@"POST" params:@{@"param":str}];
    request.animatingView = controller.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            finished(YES);
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Popover popToastOnWindowWithText:request.responseObject[@"message"]];
            });
            finished(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Popover popToastOnWindowWithText:request.responseObject[@"message"]];
        });
        finished(NO);
    }];
}

+ (void)addressTags:(void(^)(void))finished controller:(UIViewController *)controller{
    SSGenaralRequest *request = [self requestWithUrl:kAddressTag method:@"GET" params:@{}];
    request.animatingView  = controller.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.responseObject);
    }];
}

+ (SSGenaralRequest *)requestWithUrl:(NSString *)url method:(NSString *)method params:(NSDictionary *)params{
    return [[SSGenaralRequest alloc] initWithRequestUrl:url
                                          requestMethod:[method isEqualToString:@"POST"]? YTKRequestMethodPOST:YTKRequestMethodGET
                                  requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                          requestHeader:NSMutableDictionary.dictionary
                                            requestBody:params
                                         needErrorToast:YES];
}

@end
