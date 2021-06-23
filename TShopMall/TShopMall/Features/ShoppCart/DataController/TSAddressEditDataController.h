//
//  TSAddressEditDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/23.
//

#import "TSBaseDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAddressEditDataController : TSBaseDataController
+ (void)editAddress:(NSDictionary *)address finished:(void(^)(BOOL isSuccess))finished controller:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
