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
//                TSRecomendModel *recomendModel = [self recomendModelFormArray:dic[@"items"]];
                [self recomendModelFormArray:dic[@"items"] finished:^(TSRecomendModel *a) {
                    finished(a, pageInfo);
                }];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

+ (void)recomendModelFormArray:(NSArray *)array finished:(void(^)(TSRecomendModel *))finished{
    NSArray<TSRecomendModel *> *arr = [NSArray yy_modelArrayWithClass:TSRecomendModel.class json:array];
    if (arr.count != 0 && [arr[0].sourceGoods isEqualToString:@"goodsGroup"] && arr[0].goodsGroup.count != 0) {//分组商品
        TSRecomendGoodsGroup *goodsGroup = [arr[0].goodsGroup lastObject];
        [self recomendForGoodsGroup:goodsGroup finished:^(NSArray *a) {
            if (a != nil) {
                TSRecomendModel *model = arr[0];
                model.goodsList = a;
                finished(model);
            }
        }];
    }
    for (TSRecomendModel *model in arr) {
        if ([model.type isEqualToString:@"Goods"]) {
            finished(model);
        }
    }
}

+ (NSString *)pageTypeStr:(RecomendPageType)type{
    if (type == RecomendSearchResultPage) {
        return @"searchResult_page";
    } else if (type == RecomendSearchPage){
        return @"searchResult_page";
    } else if (type == RecomendCartPage) {
        return @"cart_page";
    } else if (type == RecomendPaySuccess) {
        return @"paySuccess_page";
    }
    return @"";
}


+ (void)recomendForGoodsGroup:(TSRecomendGoodsGroup *)goodsGroup finished:(void(^)(NSArray *))finished{
    NSDictionary *params = @{
        @"nowPage" : @"1",
        @"pageShow" : @(goodsGroup.productCount),
        @"cateGroupUuid" : goodsGroup.goodsgroupUuid,
        @"sortBy" : @"sortWeight",
        @"sortType" : @"1",
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kProducts
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *list = request.responseJSONObject[@"data"][@"list"];
//            NSArray *a = [NSArray yy_modelArrayWithClass:TSRecomendGoods.class json:list];
            NSMutableArray *a = [NSMutableArray array];
            for (NSDictionary *dic in list) {
                TSRecomendGoods *good = [TSRecomendGoods new];
                good.imageUrl = dic[@"pic"];
                good.productName = dic[@"name"];
                good.price = dic[@"price"];
                good.earnMost = dic[@"earnMost"];
                good.staffPrice = dic[@"staffPrice"];
                good.goodsUuid = dic[@"uuid"];
                [a addObject:good];
            }
            finished(a);
        } else {
            finished(nil);
        }
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        finished(nil);
    }];
    
}


@end
