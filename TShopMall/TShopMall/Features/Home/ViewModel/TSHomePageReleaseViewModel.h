//
//  TSHomePageReleaseViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TSHomePageBaseModel;
@interface TSHomePageReleaseViewModel : TSHomePageCellViewModel
@property(nonatomic, assign) CGFloat imageViewHeight;
@property (nonatomic, strong) TSHomePageBaseModel *releaseModel;
- (void)getReleaseData;
@end

NS_ASSUME_NONNULL_END
