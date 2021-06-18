//
//  TSHomePageCategoryViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TSImageBaseModel;
@interface TSHomePageCategoryViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSArray <TSImageBaseModel *> *categoryDatas;

@end

NS_ASSUME_NONNULL_END
