//
//  TSOneStepLoginRequest.h
//  TShopMall
//
//  Created by  on 2021/6/23.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSOneStepLoginRequest : SSBaseRequest
-(instancetype)initWithToken:(NSString *)token accessToken:(NSString *)accessToken;

@end

NS_ASSUME_NONNULL_END
