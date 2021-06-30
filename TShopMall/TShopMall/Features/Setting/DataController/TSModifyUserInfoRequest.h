//
//  TSModifyUserInfoRequest.h
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSModifyUserInfoRequest : SSBaseRequest

- (instancetype)initWithModifyKey:(NSString *)key modifyValue:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
