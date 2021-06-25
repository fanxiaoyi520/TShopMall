//
//  TSLoginByAuthCodeRequest.h
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSLoginByAuthCodeRequest : SSBaseRequest
-(instancetype)initWithCode:(NSString *)code platformId:(NSString *)platformId;

@end

NS_ASSUME_NONNULL_END
