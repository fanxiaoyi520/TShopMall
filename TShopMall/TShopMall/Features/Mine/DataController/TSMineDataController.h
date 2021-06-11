//
//  TSMineDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSBaseDataController.h"
#import "TSMineSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSMineDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSMineSectionModel *> *sections;

-(void)fetchMineContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
