//
//  TSPayStyleDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSBaseDataController.h"
#import "TSPayStyleModel.h"

@interface TSPayStyleDataController : TSBaseDataController
@property (nonatomic, strong) NSArray<TSPayStyleModel *> *payStyles;
- (void)fetchPayStyle:(NSString *)payOrderId finished:(void(^)(BOOL))finished;
@end
