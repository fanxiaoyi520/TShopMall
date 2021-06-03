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
-(void)requestFailedFilter
{
    SSResponseModel *reponseModel = [[SSResponseModel alloc] init];
    reponseModel.stateCode = @"500";
    self.responseModel = reponseModel;
}

#pragma mark - 请求成功过滤器（stateCode == 200）
-(void)requestCompleteFilter
{
    SSResponseModel *reponseModel = [SSResponseModel responseWithRequest:self];
    self.responseModel = reponseModel;
    
    if (!reponseModel.isSucceed) {//网络请求失败
        if (self.needErrorToast) {//toast提示
            
        }
    }
}

#pragma mark - Super Method
-(NSString *)baseUrl
{
    return @"";
}

-(NSString *)requestUrl
{
    return @"";
}

-(YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

-(YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    NSMutableDictionary *commonRequestHeader = [NSMutableDictionary dictionary];
    return commonRequestHeader;
}

-(id)requestArgument
{
    NSMutableDictionary *commonRequestBody = [NSMutableDictionary dictionary];
    return commonRequestBody;
}

@end
