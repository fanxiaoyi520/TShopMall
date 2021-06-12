//
//  TSHomePageBannerViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageBannerViewModel.h"
#import "TSHomePageBaseModel.h"

@implementation TSHomePageBannerViewModel
- (void)getBannerData{
    
    self.bannerDatas = @[].mutableCopy;
    ///模拟数据 请求
    TSHomePageBaseModel *model = [TSHomePageBaseModel new];
    model.imageUrl = @"mall_home_bg";
    model.uri = @"http://www.baidu.com";
    [self.bannerDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"mall_home_bg";
    model.uri = @"http://www.baidu.com";
    [self.bannerDatas addObject:model];

}
@end
