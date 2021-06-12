//
//  SSGenaralRequest.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import "SSGenaralRequest.h"

@interface SSGenaralRequest()

/// 请求路径
@property(nonatomic, copy) NSString *path;
/// 请求方法
@property(nonatomic, assign) YTKRequestMethod method;
/// 请求序列化
@property(nonatomic, assign) YTKRequestSerializerType requestType;
/// 响应序列化
@property(nonatomic, assign) YTKResponseSerializerType responseType;
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
                   needErrorToast:(BOOL)needErrorToast{
    if (self = [super init]) {
        self.path = requestUrl;
        self.method = requestMethod;
        self.requestType = requestserializerType;
        self.responseType = responseSerializerType;
        self.requestHeader = requestHeader;
        self.requestBody = requestBody;
        self.needErrorToast = needErrorToast;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)requestUrl{
    return self.path;
}

-(YTKRequestSerializerType)requestSerializerType{
    return self.requestType;
}

-(YTKResponseSerializerType)responseSerializerType{
    return self.responseType;
}

-(YTKRequestMethod)requestMethod{
    return self.method;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    NSMutableDictionary *comHeader = [self commonHeader];
    if ([self.requestHeader allKeys].count > 0) {
        [comHeader setValuesForKeysWithDictionary:self.requestHeader];
    }
    return comHeader;
}

-(id)requestArgument{
    NSMutableDictionary *comBody = [self commonBady];
    if (self.requestBody.count > 0) {
        [comBody setValuesForKeysWithDictionary:self.requestBody];
    }
    return comBody;
}


@end
