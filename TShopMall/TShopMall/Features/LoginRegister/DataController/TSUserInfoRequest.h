//
//  TSUserInfoRequest.h
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSUserInfoRequest : SSBaseRequest

- (instancetype)initWithAccountId:(NSString *)accountId;

@end

NS_ASSUME_NONNULL_END
