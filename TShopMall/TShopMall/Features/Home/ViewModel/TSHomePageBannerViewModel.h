//
//  TSHomePageBannerViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageBannerViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) NSArray *bannerDatas;
- (void)getBannerData;
@end

NS_ASSUME_NONNULL_END
