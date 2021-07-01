//
//  TSUserInfoService.m
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "TSUserInfoService.h"
#import "TSUserInfoRequest.h"
#import "TSUser.h"
#import "TSModifyUserInfoRequest.h"

@interface TSUserInfoService ()


@end

@implementation TSUserInfoService

- (void)getUserInfoAccountId:(NSString *)accountId
                     success:(void(^_Nullable)(TSUser *user))success
                     failure:(void(^_Nullable)(NSString *errorMsg))failure {
    TSUserInfoRequest *request = [[TSUserInfoRequest alloc] initWithAccountId:accountId];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        NSLog(@"获取用户信息 === %@", request.responseModel.originalData);
        if (request.responseModel.isSucceed) {
            TSUser *user = [TSUser yy_modelWithJSON:request.responseModel.originalData[@"data"]];
            if (success) {
                success(user);
            }
        }
        
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        
    }];
}

/**
 * @params key 可以为nickname（昵称）、city（城市）、province（省份）、country（国家）、sex（性别 1: 男 2:女）、area（区）
 * @params value 为对应key的修改值
 */
- (void)modifyUserInfoWithKey:(NSString *)key
                        value:(NSString *)value
                      success:(void(^_Nullable)(void))success
                      failure:(void(^_Nullable)(NSString *errorMsg))failure {
    //SSGenaralRequest *request = [self getModifyUserInfoRequestWithKey:key value:value accountId:accountId];
    TSModifyUserInfoRequest *request = [[TSModifyUserInfoRequest alloc] initWithModifyKey:key modifyValue:value];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            ///更新本地个人信息
            [[TSUserInfoManager userInfo] updateUserInfo:^(BOOL isSuccess) {
                if (success) {
                    success();
                }
            }];
        } else {
            if (failure) {
                failure(request.responseModel.originalData[@"failCause"]);
            }
        }
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (failure) {
            failure(@"发生未知错误~");
        }
    }];
}

- (SSGenaralRequest *)getUserInfoRequestWithAccountId: (NSString *)accountId {
    NSDictionary *params = @{
        @"mask": @"1",
        @"accountId": accountId,
        @"tenantId": @"tcl",
        @"appId": kAppId,
        @"appSecret": kAppSecret
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kUserInfoUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.new
                                                                 requestBody:params
                                                              needErrorToast:YES];
    
    return request;
}


- (SSGenaralRequest *)getModifyUserInfoRequestWithKey:(NSString *)key value:(NSString *)value accountId: (NSString *)accountId {
    NSDictionary *params = @{
        @"id": @"0",
        @"accountId": accountId,
        key: value,
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kModifyUserUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    
    return request;
}

@end
