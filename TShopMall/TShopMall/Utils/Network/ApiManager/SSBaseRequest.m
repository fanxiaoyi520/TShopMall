//
//  SSBaseRequest.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import "SSBaseRequest.h"
#import "SSResponseModel.h"
#import "NSString+Plugin.h"
@implementation SSBaseRequest

#pragma mark - 失败处理器（stateCode != 200）
-(void)requestFailedFilter{
    SSResponseModel *reponseModel = [[SSResponseModel alloc] init];
    reponseModel.stateCode = 500;
    self.responseModel = reponseModel;
}

#pragma mark - 请求成功过滤器（stateCode == 200）
-(void)requestCompleteFilter{
    SSResponseModel *reponseModel = [SSResponseModel responseWithRequest:self];
    self.responseModel = reponseModel;
#if  DEBUG
    NSLog(@"url --%@%@",self.baseUrl,self.requestUrl);
    NSLog(@" --%@",reponseModel.data);
#endif
    
    if ([self.responseModel.code integerValue] == 403) {
        [[TSServicesManager sharedInstance].acconutService fetchRefershToken];
    }
    
    /// 被挤下线
    if (reponseModel.stateCode == 999) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TS_Login_State object:@(1)];
    }
    
    if (!reponseModel.isSucceed) {//网络请求失败
        if (self.needErrorToast) {//toast提示
            [Popover popToastOnWindowWithText:reponseModel.responseMsg];
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
    [commonRequestHeader setValue:@"TCL" forKey:@"t-id"];
    [commonRequestHeader setValue:@"02" forKey:@"terminalType"];
    
    if ([TSGlobalManager shareInstance].currentUserInfo.accessToken.length > 0) {
        NSDictionary *dic = [[TSUserInfoManager userInfo].accessToken jwtDecodeWithJwtString];
        double expTime = [dic[@"exp"] doubleValue];
        double iatTime = [dic[@"iat"] doubleValue];
        
        NSTimeInterval nowTime = (long long)[[NSDate date] timeIntervalSince1970];
        double time  = (expTime - iatTime) * .7 + iatTime;
        if (nowTime > time) {
            [[TSServicesManager sharedInstance].acconutService fetchRefershToken];
        }
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
