//
//  TSMakeOrderController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSBaseViewController.h"
#import "TSMakeOrderBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSMakeOrderController : TSBaseViewController<TSMakeOrderCellDelegate>
@property (nonatomic, assign) BOOL isFromCart;
@end

NS_ASSUME_NONNULL_END
