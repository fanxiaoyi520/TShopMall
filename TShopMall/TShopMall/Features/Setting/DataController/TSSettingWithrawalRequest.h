//
//  TSSettingWithrawalRequest.h
//  TShopMall
//
//  Created by edy on 2021/7/6.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSettingWithrawalRequest : SSBaseRequest

- (instancetype)initWithCipherPwd:(NSString *)cipherPwd;

@end

NS_ASSUME_NONNULL_END
