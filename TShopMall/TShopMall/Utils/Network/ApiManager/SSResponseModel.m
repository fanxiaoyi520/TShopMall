//
//  SSResponseModel.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import "SSResponseModel.h"
#import "SSBaseRequest.h"

@implementation SSResponseModel

+(instancetype)responseWithRequest:(SSBaseRequest *)baseRequest{
    if (!baseRequest) {
        return nil;
    }
    
    NSDictionary *response = baseRequest.responseJSONObject;
    
    BOOL isSucess = NO;
    if ([@"200" isEqualToString:response[@"code"]]) {
        isSucess = YES;
    }
    
    SSResponseModel *responseModel = [[SSResponseModel alloc] init];
    responseModel.isSucceed = isSucess;
    responseModel.stateCode = baseRequest.responseStatusCode;
    responseModel.code = response[@"code"];
    responseModel.responseMsg = response[@"responseMsg"];
    responseModel.data = response[@"data"];
    
    return responseModel;
}

@end
