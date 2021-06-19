//
//  TSHomePageContainerViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"
#import "TSHomePageContainerGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSArray <TSHomePageContainerGroup *> *segmentHeaderDatas;
@property (nonatomic, assign) NSInteger pageIndex;

- (void)loadData:(TSHomePageContainerGroup *)group callBack:(void (^)(NSArray * _Nonnull list, NSError * _Nonnull error))listCallBack;
- (void)getSegmentHeaderData;
@end

NS_ASSUME_NONNULL_END
