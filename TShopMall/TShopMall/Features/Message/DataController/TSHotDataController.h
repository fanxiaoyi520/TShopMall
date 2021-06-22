//
//  TSHotDataController.h
//  TShopMall
//
//  Created by edy on 2021/6/21.
//

#import "TSBaseDataController.h"
#import "TSHotSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHotDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSHotSectionModel *> *sections;

- (void)fetchHotGoodsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
