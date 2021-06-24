//
//  TSShippingAddressCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <UIKit/UIKit.h>
#import "TSAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSShippingAddressCell : UITableViewCell
@property (nonatomic, copy) void(^addressEdit)(TSAddressModel *address);
@property (nonatomic, strong) TSAddressModel *addressModel;
@end

NS_ASSUME_NONNULL_END
