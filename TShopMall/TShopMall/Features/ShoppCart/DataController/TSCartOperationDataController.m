//
//  TSCartOperationDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/23.
//

#import "TSCartOperationDataController.h"

@interface TSCartOperationDataController()

@end

@implementation TSCartOperationDataController

+ (void)updateGoodsChooseStatus:(TSCart *)cart status:(BOOL)status finished:(void(^)(void))finished{
    NSString *idStr;
    if (cart == nil) {
        idStr = @"allRecords";
    } else {
        idStr = [NSString stringWithFormat:@"allRecords_%@_%@", cart.productId, cart.attrIds];
    }
    NSDictionary *params = @{
        @"productIdAndAttrId" : idStr,
        @"chooseState" : @(status)
    };
    SSGenaralRequest *request = [self requestWithUrl:kCartChangeChoose params:params];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull resq) {
        [self handleRes:resq];
        finished();
    } failure:^(__kindof SSGenaralRequest * _Nonnull resq) {
        [self handleRes:resq];
        finished();
    }];
}

+ (void)updateGoodsNumber:(TSCart *)cart finished:(void(^)(void))finished{
    NSString *idStr = [NSString stringWithFormat:@"allRecords_%@_%@", cart.productId, cart.attrIds];
    NSDictionary *params = @{
        @"productIdAndAttrId" : idStr,
        @"changeNum" : @(cart.buyNum)
    };
    SSGenaralRequest *request = [self requestWithUrl:kCartChangeNums params:params];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull resq) {
        [self handleRes:resq];
        finished();
    } failure:^(__kindof SSGenaralRequest * _Nonnull resq) {
        [self handleRes:resq];
        finished();
    }];
}

+ (void)deleteCarts:(NSArray<TSCart *> *)carts finished:(void(^)(void))finished{
    NSString *idStr = @"";
    for (TSCart *cart in carts) {
        if (idStr.length == 0) {
            idStr = [NSString stringWithFormat:@"remove,%@,%@", cart.productId, cart.attrIds];
        } else {
            idStr = [NSString stringWithFormat:@";remove,%@,%@", cart.productId, cart.attrIds];
        }
    }
    NSDictionary *params = @{
        @"productIdAndAttrId" : idStr,
        @"version" : @"1.0"
    };
    SSGenaralRequest *request = [self requestWithUrl:kCartRemove params:params];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull resq) {
        [self handleRes:resq];
        finished();
    } failure:^(__kindof SSGenaralRequest * _Nonnull resq) {
        [self handleRes:resq];
        finished();
    }];
}

+ (void)handleRes:(SSGenaralRequest *)resq{
    if (resq.responseModel.isSucceed == NO) {
        [Popover popToastOnWindowWithText:resq.responseObject[@"message"]];
    }
}

+ (SSGenaralRequest *)requestWithUrl:(NSString *)url params:(NSDictionary *)params{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:url
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    return request;
}
@end
