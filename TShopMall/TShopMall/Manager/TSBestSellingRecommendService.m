//
//  TSBestSellingRecommendService.m
//  TShopMall
//
//  Created by sway on 2021/6/26.
//

#import "TSBestSellingRecommendService.h"
@implementation TSBestSellingRecommendService

- (void)getRecommendListWithType:(NSString * _Nullable)type
                         success:(void(^_Nullable)(NSArray<id<TSRecomendGoodsProtocol>> *_Nullable list))success
                         failure:(void(^_Nullable)(NSError *_Nonnull error))failure{
    [[self requestWithType:type] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSString *content = request.responseObject[@"data"][@"content"];
            if (content.length != 0) {
                NSDictionary *dic = [content jsonValueDecoded];
                NSArray *arr = [NSArray yy_modelArrayWithClass:TSRecomendModel.class json:dic[@"items"]];
                for (TSRecomendModel *model in arr) {
                    if ([model.type isEqualToString:@"Goods"]) {
                        success(model.goodsList);
                        break;
                    }
                }
                
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure([NSError new]);
    }];
}

- (SSGenaralRequest *)requestWithType:(NSString *)type{
    NSDictionary *params = @{
        @"pageType" : type,
        @"uiType" : @"APP",
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kShopContentUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    
    return request;
}
@end
