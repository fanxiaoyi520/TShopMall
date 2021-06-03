//
//  SSResponseModel.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//

#import <Foundation/Foundation.h>

@class SSBaseRequest;

NS_ASSUME_NONNULL_BEGIN

@interface SSResponseModel : NSObject

/// 网络请求是否成功
@property(nonatomic, assign) BOOL isSucceed;
/// Http请求状态码
@property(nonatomic, copy) NSString *stateCode;
/// 请求返回的状态码
@property(nonatomic, copy) NSString *code;
/// 响应信息
@property(nonatomic, copy) NSString *responseMsg;
/// 响应体（字典或者数组）
@property(nonatomic, strong) id responseObject;

+(instancetype)responseWithRequest:(SSBaseRequest *)baseRequest;

@end

NS_ASSUME_NONNULL_END
