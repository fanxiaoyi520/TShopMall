//
//  SSGenaralRequest.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import "SSGenaralRequest.h"

@interface SSGenaralRequest()

/// 请求路径
@property(nonatomic, copy) NSString *requestUrl;
/// 请求方法
@property(nonatomic, assign) YTKRequestMethod method;
/// 请求序列化
@property(nonatomic, assign) YTKRequestSerializerType requestserializerType;
/// 响应序列化
@property(nonatomic, assign) YTKResponseSerializerType responseSerializerType;
/// 请求头
@property(nonatomic, strong) NSDictionary *requestHeader;
/// 请求体
@property(nonatomic, strong) NSDictionary *requestBody;

@end

@implementation SSGenaralRequest

-(instancetype)initWithRequestUrl:(NSString *)requestUrl
                    requestMethod:(YTKRequestMethod)requestMethod
            requestSerializerType:(YTKRequestSerializerType)requestserializerType
           responseSerializerType:(YTKResponseSerializerType)responseSerializerType
                    requestHeader:(NSDictionary *)requestHeader
                      requestBody:(NSDictionary *)requestBody
                   needErrorToast:(BOOL)needErrorToast
{
    if (self = [super init]) {
        self.requestUrl = requestUrl;
        self.method = requestMethod;
        self.requestserializerType = requestserializerType;
        self.responseSerializerType = responseSerializerType;
        self.requestHeader = requestHeader;
        self.requestBody = requestBody;
        self.needErrorToast = needErrorToast;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)requestUrl
{
    return self.requestUrl;
}

-(YTKRequestSerializerType)requestSerializerType
{
    return self.requestserializerType;
}

-(YTKResponseSerializerType)responseSerializerType
{
    return self.responseSerializerType;
}

-(YTKRequestMethod)requestMethod
{
    return self.requestMethod;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:[super requestHeaderFieldValueDictionary]];
    return header;
}

-(id)requestArgument
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithDictionary:[super requestArgument]];
    return body;
}


@end
