//
//  TSHomePageCategoryViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCategoryViewModel.h"
#import "TSHomePageBaseModel.h"
@implementation TSHomePageCategoryViewModel
- (void)getCategoryData{
    self.categoryDatas = @[].mutableCopy;
    ///模拟数据 请求
    TSHomePageBaseModel *model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"111";

    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"222";
    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"333";
    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"444";
    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"555";
    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"666";
    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"777";
    [self.categoryDatas addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"888";

    [self.categoryDatas addObject:model];
}

@end
