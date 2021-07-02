//
//  TSSaleRankRequest.h
//  TShopMall
//
//  Created by oneyian on 2021/7/2.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSaleRankRequest : SSBaseRequest

- (instancetype)initWithTime:(NSInteger)time rankNum:(NSInteger)rankNum;

@end

NS_ASSUME_NONNULL_END
