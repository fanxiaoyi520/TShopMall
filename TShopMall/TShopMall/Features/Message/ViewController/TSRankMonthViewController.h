//
//  TSRankMonthViewController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSBaseListController.h"
//#import "TSRankSectionModel.h"
#import "TSRankDataController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSRankMonthViewController : TSBaseListController<JXCategoryListContentViewDelegate>

//@property (nonatomic, strong) NSMutableArray <TSRankSectionModel *> *coronalSections;
@property(nonatomic, strong) TSRankDataController *dataController;

@end

NS_ASSUME_NONNULL_END
