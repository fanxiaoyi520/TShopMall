//
//  SSGenaralRequest.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//  网络请求通用类

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSGenaralRequest : SSBaseRequest

-(instancetype)initWithRequestUrl:(NSString *)requestUrl
                    requestMethod:(YTKRequestMethod)requestMethod
            requestSerializerType:(YTKRequestSerializerType)requestserializerType
           responseSerializerType:(YTKResponseSerializerType)responseSerializerType
                    requestHeader:(NSDictionary *)requestHeader
                      requestBody:(NSDictionary *)requestBody
                   needErrorToast:(BOOL)needErrorToast;

-(instancetype)initWithBaseUrl:(NSString *)baseUrl
                    RequestUrl:(NSString *)requestUrl
                    requestMethod:(YTKRequestMethod)requestMethod
            requestSerializerType:(YTKRequestSerializerType)requestserializerType
           responseSerializerType:(YTKResponseSerializerType)responseSerializerType
                    requestHeader:(NSDictionary *)requestHeader
                      requestBody:(NSDictionary *)requestBody
                   needErrorToast:(BOOL)needErrorToast;
@end

NS_ASSUME_NONNULL_END
