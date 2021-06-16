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
    NSMutableArray *marr = @[].mutableCopy;
    ///模拟数据 请求
    TSHomePageBaseModel *model = [TSHomePageBaseModel new];
    model.imageUrl = @"https://www.baidu.com/img/bdlogo.png";
    model.uri = @"http://www.baidu.com";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"https://www.baidu.com/img/bdlogo.png";
    model.uri = @"http://www.baidu.com";
    [marr addObject:model];
    self.bannerDatas = marr;
}
@end
