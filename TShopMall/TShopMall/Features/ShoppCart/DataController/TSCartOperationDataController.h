//
//  TSCartOperationDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/23.
//

#import "TSBaseDataController.h"
#import "TSCartModel.h"

@interface TSCartOperationDataController : TSBaseDataController
+ (void)updateGoodsChooseStatus:(TSCart *)cart status:(BOOL)status finished:(void(^)(void))finished;
+ (void)updateGoodsNumber:(TSCart *)cart finished:(void(^)(void))finished;
+ (void)deleteCarts:(NSArray<TSCart *> *)carts finished:(void(^)(void))finished;
@end

