//
//  TSRecomendDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSRecomendDataController.h"
#import "TSRecomendViewModel.h"

@implementation TSRecomendDataController


+ (void)checkCurrentRecomendPage:(RecomendPageType)pageType finished:(void (^)(TSRecomendModel *, TSRecomendPageInfo *))finished{
    NSDictionary *params = @{
        @"pageType" : [self pageTypeStr:pageType],
        @"uiType" : @"APP",
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kShopContentUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSString *content = request.responseObject[@"data"][@"content"];
            if (content.length != 0) {
                NSDictionary *dic = [content jsonValueDecoded];
                NSDictionary *pageInfoDic = dic[@"pageInfo"];
                TSRecomendPageInfo *pageInfo = [TSRecomendPageInfo yy_modelWithDictionary:pageInfoDic];
                TSRecomendModel *recomendModel = [self recomendModelFormArray:dic[@"items"]];
                finished(recomendModel, pageInfo);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

+ (TSRecomendModel *)recomendModelFormArray:(NSArray *)array{
    NSArray *arr = [NSArray yy_modelArrayWithClass:TSRecomendModel.class json:array];
    for (TSRecomendModel *model in arr) {
        if ([model.type isEqualToString:@"Goods"]) {
            return model;
        }
    }
    return nil;
}

+ (NSString *)pageTypeStr:(RecomendPageType)type{
    if (type == RecomendSearchResultPage) {
        return @"searchResult_page";
    } else if (type == RecomendSearchPage){
        return @"searchResult_page";
    } else if (type == RecomendCartPage) {
        return @"cart_page";
    }
    return @"";
}

@end
