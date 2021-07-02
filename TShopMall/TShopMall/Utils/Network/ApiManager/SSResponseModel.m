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
    if ([@"200" isEqualToString:response[@"code"]] || [@"SUCCESS" isEqualToString:response[@"status"]] ||[response[@"code"] intValue] == 1) {
        isSucess = YES;
    }
    
    SSResponseModel *responseModel = [[SSResponseModel alloc] init];
    responseModel.isSucceed = isSucess;
    responseModel.stateCode = baseRequest.responseStatusCode;
    responseModel.code = response[@"code"];
    if (response[@"responseMsg"]) {
        responseModel.responseMsg = response[@"responseMsg"];
    } else {
        responseModel.responseMsg = response[@"message"];
    }
    responseModel.data = response[@"data"];
    responseModel.originalData = response;
    
    return responseModel;
}

@end
