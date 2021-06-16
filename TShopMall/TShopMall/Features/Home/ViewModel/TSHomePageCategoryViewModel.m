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
    NSMutableArray *marr = @[].mutableCopy;
    ///模拟数据 请求
    TSHomePageBaseModel *model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"111";

    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"222";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"333";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"444";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"555";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"666";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"777";
    [marr addObject:model];

    model = [TSHomePageBaseModel new];
    model.imageUrl = @"image_test";
    model.uri = @"http://www.baidu.com";
    model.title = @"888";

    [marr addObject:model];
     
    self.categoryDatas  = marr;
}

@end
