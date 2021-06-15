//
//  TSHomePageContainerViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"
#import "TSHomePageContainerHeaderViewModel.h"
#import "TSHomePageContainerGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) TSHomePageContainerHeaderViewModel *containerHeaderViewModel;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSArray <TSHomePageContainerModel *> *> *allGroupDict;

- (void)getPageContainerDataWithStartIndex:(NSInteger)startIndex
                                     count:(NSInteger)count
                                     group:(TSHomePageContainerGroup *)group;

- (void)getPageContainerDataWithStartIndex:(NSInteger)startIndex
                                     count:(NSInteger)count
                                     group:(TSHomePageContainerGroup *)group
                                  callback:(void(^_Nullable)(NSMutableDictionary <NSString *, NSArray <TSHomePageContainerModel *> *> *allGroupDict))callback;

- (void)loadMoreData;
@end

NS_ASSUME_NONNULL_END
