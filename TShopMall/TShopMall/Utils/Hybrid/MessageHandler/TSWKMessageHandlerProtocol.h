//
//  TSWKMessageHandlerProtocol.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSWKMessageHandlerProtocol <NSObject>

///JS传给Native的参数
@property (nonatomic, strong) NSDictionary *params;

/**
 Native业务处理成功的回调,result:回调给JS的数据
 */
@property (nonatomic, copy) void(^successCallback)(NSDictionary *result);

/**
 Native业务处理失败的回调,result:回调给JS的数据
 */
@property (nonatomic, copy) void(^failCallback)(NSDictionary *result);

/**
 Native业务处理的回调,result:回调给JS的数据
 */
@property (nonatomic, copy) void(^progressCallback)(NSDictionary *result);

@end

NS_ASSUME_NONNULL_END
