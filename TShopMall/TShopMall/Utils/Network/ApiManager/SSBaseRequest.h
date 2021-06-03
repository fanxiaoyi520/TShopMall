//
//  SSBaseRequest.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/6/1.
//  网络请求基类，自定义网络请求类，请继承该类

#import "YTKBaseRequest.h"

@class SSResponseModel;

NS_ASSUME_NONNULL_BEGIN

@interface SSBaseRequest : YTKBaseRequest

/// 请求失败是否toast
@property(nonatomic, assign) BOOL needErrorToast;
/// 此次请求的响应信息
@property(nonatomic, strong) SSResponseModel *responseModel;

@end

NS_ASSUME_NONNULL_END
