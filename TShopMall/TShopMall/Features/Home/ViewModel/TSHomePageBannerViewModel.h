//
//  TSHomePageBannerViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"
#import "TSImageBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TSHomePageBannerViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSArray <TSImageBaseModel *> *bannerDatas;
- (void)getBannerData;
@end

NS_ASSUME_NONNULL_END
