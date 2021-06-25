//
//  TSLoginByTokenRequest.h
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSLoginByTokenRequest : SSBaseRequest
-(instancetype)initWithToken:(NSString *)token platformId:(NSString *)platformId;
@end

NS_ASSUME_NONNULL_END
