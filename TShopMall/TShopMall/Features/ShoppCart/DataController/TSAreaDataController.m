//
//  TSAreaDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import "TSAreaDataController.h"

@interface TSAreaDataController ()
@property (nonatomic, strong) SSGenaralRequest *proviceRequest;
@end

@implementation TSAreaDataController

- (void)fetachAddressData:(void(^)(void))finished{
    [[self request] startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
//        NSLog(@"%@", request.responseJSONObject);
        if (request.responseModel.isSucceed == YES) {
            [self handleRes:request.responseJSONObject[@"data"]];
        }
        finished();
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        finished();
    }];

}

- (void)handleRes:(NSArray *)res{
    NSArray<TSAreaModel *> *arr  = [NSArray yy_modelArrayWithClass:TSAreaModel.class json:res];
    NSDictionary<NSString *, NSArray<TSAreaModel *> *> *dic = [self handleSections:arr];
    if (self.requestType == 0) {
        self.provices = dic;
    } else if (self.requestType == 1) {
        self.cities = dic;
    } else if (self.requestType == 2) {
        self.areas = dic;
    } else if (self.requestType == 3) {
        self.streets = dic;
    }
}

- (NSDictionary<NSString *,NSArray<TSAreaModel *> *> *)currentDatas{
    if (self.requestType == 0) {
        return self.provices;
    } else if (self.requestType == 1) {
        return self.cities;
    } else if (self.requestType == 2) {
        return self.areas;
    } else {
        return self.streets;
    }
}

- (NSDictionary<NSString *, NSArray<TSAreaModel *> *> *)handleSections:(NSArray<TSAreaModel *> *)obj{
   
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (TSAreaModel *model in obj) {
        NSString *key = [[model.pinYin substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        if ([[dic allKeys] containsObject:key]) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[key]];
            [arr addObject:model];
            dic[key] = arr;
        } else {
            NSMutableArray *arr = [NSMutableArray arrayWithObject:model];
            dic[key] = arr;
        }
    }
    
    return dic;
}

- (SSGenaralRequest *)request{
    NSString *url = @"";
    NSDictionary *params;
    switch (self.requestType) {
        case 0:
            url = kProvice;
            break;
        case 1:
            url = kCities;
            params = @{@"provinceUuid":self.uuid};
            break;
        case 2:
            url = kAreas;
            params = @{@"cityUuid":self.uuid};
            break;
            
        default:
            url = kStreets;
            params = @{@"regionUuid":self.uuid};
            break;
    }
   
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:url
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    
    return request;
}

@end
