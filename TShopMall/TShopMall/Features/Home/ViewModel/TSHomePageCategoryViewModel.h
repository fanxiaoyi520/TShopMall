//
//  TSHomePageCategoryViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageCategoryViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSMutableArray *categoryDatas;
- (void)getCategoryData;
@end

NS_ASSUME_NONNULL_END
