//
//  TSBindUserByAuthCodeRequest.h
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBindUserByAuthCodeRequest : SSBaseRequest
-(instancetype)initWithType:(NSString *)type platformId:(NSString *)platformId phone:(NSString *)phone token:(NSString *)token smsCode:(NSString *)smsCode;

@end

NS_ASSUME_NONNULL_END
