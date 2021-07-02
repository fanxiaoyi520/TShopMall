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

/// 是否是财富榜
@property (nonatomic, assign) BOOL isProfitRank;

/// 是否是本月
@property (nonatomic, assign) BOOL isNowMonth;

@property (nonatomic, strong, readonly) NSMutableArray <TSRankSectionModel *> *coronalSections;


/// 排行数据
/// @param rankNum 排行数量
/// @param complete 获取完成回调
- (void)fetchRankDataWithRankNum:(NSInteger)rankNum Complete:(void(^)(BOOL isSucess))complete;

@property (nonatomic, strong) TSRankUserModel * currentUserRankModel;

@end

NS_ASSUME_NONNULL_END
