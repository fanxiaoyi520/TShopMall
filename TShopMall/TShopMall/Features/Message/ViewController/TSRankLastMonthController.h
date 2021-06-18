//
//  TSRankLastMonthController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSBaseListController.h"
#import "TSRankSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRankLastMonthController : TSBaseListController<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSMutableArray <TSRankSectionModel *> *coronalSections;

@end

NS_ASSUME_NONNULL_END
