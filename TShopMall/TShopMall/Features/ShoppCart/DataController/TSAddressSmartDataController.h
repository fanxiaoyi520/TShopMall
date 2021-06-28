//
//  TSAddressSmartDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSBaseDataController.h"
#import "TSAddressModel.h"

@interface TSAddressSmartDataController : TSBaseDataController
+ (void)smartAddress:(NSString *)addressStr finished:(void(^)(TSAddressModel *))finished onController:(UIViewController *)controller;
@end

