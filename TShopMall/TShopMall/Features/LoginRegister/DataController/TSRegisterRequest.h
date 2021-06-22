//
//  TSRegisterRequest.h
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRegisterRequest : SSBaseRequest
-(instancetype)initWithMobile:(NSString *)mobile
                    validCode:(NSString *)validCode
               invitationCode:(NSString *)invitationCode;

@end

NS_ASSUME_NONNULL_END
