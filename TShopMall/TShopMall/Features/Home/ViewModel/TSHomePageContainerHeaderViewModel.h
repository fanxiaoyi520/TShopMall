//
//  TSHomePageContainerHeaderViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/12.
//

#import "TSHomePageCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class  TSHomePageContainerGroup;
@interface TSHomePageContainerHeaderViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSMutableArray *segmentHeaderDatas;
@property (nonatomic, assign) NSInteger currentIndex;

- (void)getSegmentHeaderData;

@end

NS_ASSUME_NONNULL_END
