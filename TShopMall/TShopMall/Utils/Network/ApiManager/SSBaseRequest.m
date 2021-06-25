//
//  SSBaseRequest.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import "SSBaseRequest.h"
#import "SSResponseModel.h"

@implementation SSBaseRequest

#pragma mark - 失败处理器（stateCode != 200）
-(void)requestFailedFilter{
    SSResponseModel *reponseModel = [[SSResponseModel alloc] init];
    reponseModel.stateCode = @"500";
    self.responseModel = reponseModel;
}

#pragma mark - 请求成功过滤器（stateCode == 200）
-(void)requestCompleteFilter{
    SSResponseModel *reponseModel = [SSResponseModel responseWithRequest:self];
    self.responseModel = reponseModel;
    
    if (!reponseModel.isSucceed) {//网络请求失败
        if (self.needErrorToast) {//toast提示
            
        }
    }
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return @"";
}

-(NSString *)requestUrl{
    return @"";
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

-(YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

#pragma mark - Public
-(NSMutableDictionary *)commonHeader{
    NSMutableDictionary *commonRequestHeader = [NSMutableDictionary dictionary];
    [commonRequestHeader setValue:@"platform_tcl_shop" forKey:@"platform"];
    [commonRequestHeader setValue:@"thome" forKey:@"storeUuid"];
//    [commonRequestHeader setValue:@"tclplus" forKey:@"storeUuid"];
    [commonRequestHeader setValue:@"TCL" forKey:@"t-id"];
    [commonRequestHeader setValue:@"02" forKey:@"terminalType"];
    
    if ([TSGlobalManager shareInstance].currentUserInfo.accessToken.length > 0) {
        [commonRequestHeader setValue:[TSGlobalManager shareInstance].currentUserInfo.accessToken forKey:@"accessToken"];
    }else{
        [commonRequestHeader setValue:@"" forKey:@"accessToken"];
    }
    if ([TSGlobalManager shareInstance].clientID.length > 0) {
        [commonRequestHeader setValue:[TSGlobalManager shareInstance].clientID forKey:@"User-Agent"];
    }
    [commonRequestHeader setValue:[TSGlobalManager shareInstance].appVersion forKey:@"appVersion"];
    [commonRequestHeader setValue:@"app" forKey:@"source"];
    [commonRequestHeader setValue:@"AppStore" forKey:@"pubChannel"];

    return commonRequestHeader;
}

-(NSMutableDictionary *)commonBady{
    NSMutableDictionary *commmonBody = [NSMutableDictionary dictionary];
    return commmonBody;
}

@end
