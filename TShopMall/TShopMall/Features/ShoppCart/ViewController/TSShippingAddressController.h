//
//  TSShippingAddressController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSBaseViewController.h"
#import "TSAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSShippingAddressController : TSBaseViewController
@property (nonatomic, copy) void(^addressSelected)(TSAddressModel *address);
@end

NS_ASSUME_NONNULL_END
