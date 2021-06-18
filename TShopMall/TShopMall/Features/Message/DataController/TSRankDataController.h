//
//  TSRankDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSBaseDataController.h"
#import "TSRankSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRankDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSRankSectionModel *> *coronalSections;

-(void)fetchRankCoronalComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
