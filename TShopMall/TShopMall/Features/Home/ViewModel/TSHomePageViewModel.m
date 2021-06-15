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

#import "TSHomePageContainerHeaderViewModel.h"

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
    
    TSTableViewSectionModel *sectionModel1 = [TSTableViewSectionModel new];
    sectionModel1.rowDatas = @[bannerViewModel];
    
    TSHomePageCategoryViewModel *categoryViewModel = [TSHomePageCategoryViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageCategory";
    categoryViewModel.model = templateModel;
    
    TSTableViewSectionModel *sectionModel2 = [TSTableViewSectionModel new];
    sectionModel2.rowDatas = @[categoryViewModel];
    
    TSHomePageReleaseViewModel *releaseViewModel = [TSHomePageReleaseViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageRelease";
    releaseViewModel.model = templateModel;
    
    TSTableViewSectionModel *sectionModel3 = [TSTableViewSectionModel new];
    sectionModel3.rowDatas = @[releaseViewModel];
    
    TSHomePageContainerHeaderViewModel *containerHeaderViewModel = [TSHomePageContainerHeaderViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageContainerHeader";
    containerHeaderViewModel.model = templateModel;
    
    TSHomePageContainerViewModel *containerViewModel = [TSHomePageContainerViewModel new];
    templateModel = [TSHomePageCellTemplateModel new];
    templateModel.templateName = @"TSHomePageContainer";
    containerViewModel.model = templateModel;
    containerViewModel.containerHeaderViewModel = containerHeaderViewModel;
    _containerViewModel = containerViewModel;
    
    TSTableViewSectionModel *sectionModel4 = [TSTableViewSectionModel new];
    sectionModel4.rowDatas = @[containerViewModel];
    sectionModel4.headerModel = containerHeaderViewModel;
    
    self.dataSource = @[sectionModel1,sectionModel2, sectionModel3, sectionModel4];
    
    
//    for (TSTableViewSectionModel *sectionModel in self.dataSource) {
//        TSHomePageCellViewModel *viewModel = viewModels.firstObject;
//        if ([viewModel.model.templateName isEqualToString:@"TSHomePageContainer"]) {
//            [self getSegmentHeaderData];
//            break;
//        }
//    }
}

@end
