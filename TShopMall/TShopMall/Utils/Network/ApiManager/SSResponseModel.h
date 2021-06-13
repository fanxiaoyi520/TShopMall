//
//  SSResponseModel.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import <Foundation/Foundation.h>

@class SSBaseRequest;

typedef NS_ENUM(NSUInteger, TSRequestStatusCode){
    TSRequestStatusSuccess = 200,                   //一切正常
    TSRequestStatusBadRequest = 400,                //一般由缺失参数，参数格式不正确等引起
    TSRequestStatusUnauthorized = 401,              //没有提供正确的 AppKey或验签不通过
    TSRequestStatusRequestFailed = 402,             //参数格式正确但是请求失败，一般由业务错误引起
    TSRequestStatusRequestForbidden = 403,          //调用接口限制，未登录或会话失效等情况
    TSRequestStatusRequestNotFound = 404,           //请求的资源不存在
    TSRequestStatusRequestServerErrors = 500,       //服务器出错
    TSRequestStatusRequestBadGateway = 502,         //网关错误
    TSRequestStatusRequestServiceUnavailable = 503, //服务器出错
    TSRequestStatusRequestGatewayTimeout = 504,     //网关超时
    TSRequestStatusRequestLocked = 423,             //当前资源被锁定
    TSRequestStatusRequestLimitCount = 511,         //在指定的时间范围内，超过限制总的请求个数
    TSRequestStatusRequestLimitRequest = 512,       //被限制请求速度，超速了
    TSRequestStatusRequestSystemException = 9999,   //系统运行时异常，不符合接入标准或后端服务异常的情况
};

NS_ASSUME_NONNULL_BEGIN

@interface SSResponseModel : NSObject

/// 网络请求是否成功
@property(nonatomic, assign) BOOL isSucceed;
/// Http请求状态码
@property(nonatomic, assign) NSInteger stateCode;
/// 请求返回的状态码
@property(nonatomic, copy) NSString *code;
/// 响应信息
@property(nonatomic, copy) NSString *responseMsg;
/// 响应体（字典或者数组）
@property(nonatomic, strong) id data;

+(instancetype)responseWithRequest:(SSBaseRequest *)baseRequest;

@end

NS_ASSUME_NONNULL_END
