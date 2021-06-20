//
//  TSHomePageBannerViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageBannerViewModel.h"

@implementation TSHomePageBannerViewModel
- (void)getBannerData{
    if (self.model.data) {
        NSArray *temp = [NSArray yy_modelArrayWithClass:TSImageBaseModel.class json:self.model.data[@"list"]];
        self.bannerDatas = [NSMutableArray arrayWithArray:temp];
    }
}
@end
