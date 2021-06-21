//
//  TSSMSCodeRequest.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "SSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSMSCodeRequest : SSBaseRequest

-(instancetype)initWithMobile:(NSString *)mobile;

@end

NS_ASSUME_NONNULL_END
