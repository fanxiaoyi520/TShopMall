//
//  SSResponseModel.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import "SSResponseModel.h"
#import "SSBaseRequest.h"

@implementation SSResponseModel

+(instancetype)responseWithRequest:(SSBaseRequest *)baseRequest
{
    if (!baseRequest) {
        return nil;
    }
    
    SSResponseModel *responseModel = [[SSResponseModel alloc] init];
    return responseModel;
}

@end
