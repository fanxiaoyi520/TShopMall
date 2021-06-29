//
//  TSCategoryGroupViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"
#import "TSCategoryGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryGroupViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSArray <TSCategoryGroup *> *segmentHeaderDatas;
@property (nonatomic, assign) NSInteger pageIndex;
- (void)getCategoryGroupDataWithStartPageIndex:(NSInteger)startIndex count:(NSInteger)count group:(TSCategoryGroup *)group sortType:(NSString *)sortType sortBy:(NSString *)sortBy success:(void(^_Nullable)(NSArray * list))success failure:(void(^_Nullable)(NSError *_Nonnull error))failure;
/// 默认排序
- (void)loadData:(TSCategoryGroup *)group success:(void(^_Nullable)(NSArray * list))success failure:(void(^_Nullable)(NSError *_Nonnull error))failure;
- (void)getSegmentHeaderData;
- (NSString *)getSortByWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
