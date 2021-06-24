//
//  TSAddressEditController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSBaseViewController.h"
#import "TSAddressViewModel.h"

@interface TSAddressEditController : TSBaseViewController
@property (nonatomic, strong) TSAddressViewModel *vm;
@property (nonatomic, copy) void(^addressChanged)(void);
@end
