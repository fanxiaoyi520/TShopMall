//
//  TSMakeOrderCommitOrderDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "TSAddressModel.h"
#import "TSBalanceModel.h"
#import "TSMakeOrderInvoiceViewModel.h"

@interface TSMakeOrderCommitOrderDataController : NSObject
+ (void)commitOrderWithAddress:(TSAddressModel *)address balanceInfo:(TSBalanceModel *)balanceInfo invoice:(TSMakeOrderInvoiceViewModel *)invoice finished:(void(^)(BOOL, NSString *, NSString *))finished OnController:(UIViewController *)controller;
@end

