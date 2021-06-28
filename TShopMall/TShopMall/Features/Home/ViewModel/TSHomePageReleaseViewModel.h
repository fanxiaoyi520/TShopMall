//
//  TSHomePageReleaseViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCellViewModel.h"
#import "TSImageBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TSHomePageReleaseViewModel : TSHomePageCellViewModel
@property (nonatomic, strong) TSImageBaseModel *releaseModel;
- (void)getReleaseData;

@property (nonatomic, strong) NSArray *datas;

@end

NS_ASSUME_NONNULL_END
