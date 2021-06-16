//
//  TSProductDetailDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSGoodDetailSectionModel.h"
#import "TSGoodDetailItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSProductDetailDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSGoodDetailSectionModel *> *sections;

-(void)fetchProductDetailComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
