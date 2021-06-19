//
//  TSShippingAddressDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <UIKit/UIKit.h>
#import "TSAddressModel.h"

@interface TSShippingAddressDataController : UIViewController

@property (nonatomic, strong) NSArray<TSAddressModel *> *address;
- (void)fetchAddress:(void(^)(NSError *))finished;
@end

