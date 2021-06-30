//
//  TSChangeBindRequest.h
//  TShopMall
//
//  Created by  on 2021/6/30.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSChangeBindRequest : SSBaseRequest
- (instancetype)initWithNewMobile:(NSString *)newMobile validCode:(NSString *)validCode;

@end

NS_ASSUME_NONNULL_END
