//
//  TSHomePageViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageViewModel.h"
#import "TSHomePageBannerViewModel.h"
#import "TSHomePageCategoryViewModel.h"
#import "TSHomePageReleaseViewModel.h"
#import "TSHomePageContainerViewModel.h"
#import "TSHomePageCellTemplateModel.h"
#import "TSHomePageBaseModel.h"

@interface TSHomePageViewModel ()
@end
@implementation TSHomePageViewModel
- (void)loadData{
    TSHomePageBannerViewModel *bannerViewModel = [TSHomePageBannerViewModel new];
    TSHomePageCellTemplateModel *templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageBanner";
    bannerViewModel.model = templateModel;
    
    TSHomePageCategoryViewModel *categoryViewModel = [TSHomePageCategoryViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageCategory";
    categoryViewModel.model = templateModel;
    
    TSHomePageReleaseViewModel *releaseViewModel = [TSHomePageReleaseViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageRelease";
    releaseViewModel.model = templateModel;
        
    TSHomePageContainerViewModel *containerViewModel = [TSHomePageContainerViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageContainer";
    containerViewModel.model = templateModel;
        
    self.dataSource = @[@[bannerViewModel], @[categoryViewModel], @[releaseViewModel], @[containerViewModel]];
}

- (void)getSegmentHeaderData{
    NSMutableArray *marr = @[].mutableCopy;
    for (int i = 0; i < 10; i ++) {
        TSHomePageBaseModel *model = [TSHomePageBaseModel new];
        model.title = [NSString stringWithFormat:@"标题%d",i];
        if (i == 4) {
            model.title = @"特别长的aaa";
        }
        [marr addObject:model];
    }
    self.segmentHeaderDatas = marr;
    
}
@end
