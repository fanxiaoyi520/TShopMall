//
//  TSShippingAddressDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSBaseDataController.h"
#import "TSAddressModel.h"

@interface TSShippingAddressDataController : TSBaseDataController

@property (nonatomic, strong) NSArray<TSAddressModel *> *address;
+ (void)fetchAddress:(void (^)(NSArray<TSAddressModel *> *, NSString *))finished lodingView:(UIView *)view;

+ (void)deleteAddress:(TSAddressModel *)address finished:(void (^)(void))finished lodingView:(UIView *)view;
@end

