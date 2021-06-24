//
//  TSAddressEditDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/23.
//

#import "TSBaseDataController.h"

@interface TSAddressEditDataController : TSBaseDataController
+ (void)addAddress:(NSDictionary *)address finished:(void(^)(BOOL isSuccess))finished controller:(UIViewController *)controller;

+ (void)editAddress:(NSDictionary *)address finished:(void(^)(BOOL isSuccess))finished controller:(UIViewController *)controller;

+ (void)addressTags:(void(^)(void))finished controller:(UIViewController *)controller;
@end

