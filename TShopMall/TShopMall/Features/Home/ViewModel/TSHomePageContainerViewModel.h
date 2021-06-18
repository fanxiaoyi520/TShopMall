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
@property (nonatomic, strong) TSHomePageContainerGroup *currentGroup;


- (void)getPageContainerDataWithStartPageIndex:(NSInteger)startIndex count:(NSInteger)count group:(TSHomePageContainerGroup *)group callBack:(void (^)(NSArray * _Nonnull list, NSError * _Nonnull error))listCallBack;

- (void)loadData:(TSHomePageContainerGroup *)group callBack:(void (^)(NSArray * _Nonnull list, NSError * _Nonnull error))listCallBack;
- (void)getSegmentHeaderData;
@end

NS_ASSUME_NONNULL_END
