//
//  TSHomePageCategoryViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageCategoryViewModel.h"
@implementation TSHomePageCategoryViewModel
- (void)getCategoryData{
    if (self.model.data) {
        NSArray *temp = [NSArray yy_modelArrayWithClass:TSImageBaseModel.class json:self.model.data[@"list"]];
        self.categoryDatas = [NSMutableArray arrayWithArray:temp];
    }
}

@end
