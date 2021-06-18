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
#import "TSHomePageCellTemplateModel.h"
#import "TSHomePageReleaseTitleViewModel.h"
#import "TSHomePageBaseModel.h"
#import "TSHomePageContentModel.h"
@interface TSHomePageViewModel ()
@end
@implementation TSHomePageViewModel

- (void)loadData{
//    TSHomePageBannerViewModel *bannerViewModel = [TSHomePageBannerViewModel new];
//    TSHomePageCellTemplateModel *templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageBanner";
//    bannerViewModel.model = templateModel;
//
//    TSTableViewSectionModel *sectionModel1 = [TSTableViewSectionModel new];
//    sectionModel1.rowDatas = @[bannerViewModel];
//
//    TSHomePageCategoryViewModel *categoryViewModel = [TSHomePageCategoryViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageCategory";
//    categoryViewModel.model = templateModel;
//
//    TSTableViewSectionModel *sectionModel2 = [TSTableViewSectionModel new];
//    sectionModel2.rowDatas = @[categoryViewModel];
//
//    TSHomePageReleaseViewModel *releaseViewModel = [TSHomePageReleaseViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageRelease";
//    releaseViewModel.model = templateModel;
//
//    TSTableViewSectionModel *sectionModel3 = [TSTableViewSectionModel new];
//    sectionModel3.rowDatas = @[releaseViewModel];
//
//    TSHomePageContainerViewModel *containerViewModel = [TSHomePageContainerViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageContainer";
//    templateModel.headerTemplateName = @"TSHomePageContainerHeader";
//
//    containerViewModel.model = templateModel;
//    _containerViewModel = containerViewModel;
//
//    TSTableViewSectionModel *sectionModel4 = [TSTableViewSectionModel new];
//    sectionModel4.rowDatas = @[containerViewModel];
//    sectionModel4.headerModel = containerViewModel;
//
//    self.dataSource = @[sectionModel1,sectionModel2, sectionModel3, sectionModel4];
 
}

-(void)fetchData{

    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@"platform_tcl_shop" forKey:@"platform"];
    [body setValue:@"tclplus" forKey:@"storeUuid"];
    [body setValue:@"TCL" forKey:@"t-id"];
    [body setValue:@"02" forKey:@"terminalType"];
    [body setValue:@"APP" forKey:@"uiType"];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kHomePageInfoUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            NSString *content = request.responseModel.data[@"content"];
            NSArray *contentArr = [content jsonValueDecoded][@"items"];
            
            NSMutableArray *sections = [NSMutableArray array];
            NSArray *temp = [NSArray yy_modelArrayWithClass:TSHomePageContentModel.class json:contentArr];

            for (TSHomePageContentModel *model in temp) {
                TSHomePageCellViewModel *viewModel = [self configSection:model];
                if(viewModel){
                    [sections addObject:viewModel];
                }
            }
            
            self.dataSource = sections;
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];

}

- (TSHomePageCellViewModel *)configSection:(TSHomePageContentModel *)model{
    NSString *sectionName = nil;
    TSHomePageCellViewModel *viewModel = nil;
    if ([model.type isEqualToString:@"ImageAd"]) {
        NSDictionary *data = model.data;
        if (data) {
            int style = [data[@"style"] intValue];
            NSString *key = [NSString stringWithFormat:@"ImageAd%d",style];
            sectionName = [self configViewModel][key];
            
            Class viewModelClass = NSClassFromString([NSString stringWithFormat:@"%@ViewModel",sectionName]);
            viewModel = [viewModelClass new];
            if ([viewModel isKindOfClass:TSHomePageCellViewModel.class]) {
                TSHomePageCellTemplateModel *templateModel = [TSHomePageCellTemplateModel new];
                templateModel.templateName = sectionName;
                templateModel.data = model.data;
                viewModel.model = templateModel;
            }
        }
    }
    else if ([model.type isEqualToString:@"Nav"] || [model.type isEqualToString:@"RichText"]){
        sectionName = [self configViewModel][model.type];
        Class viewModelClass = NSClassFromString([NSString stringWithFormat:@"%@ViewModel",sectionName]);
        viewModel = [viewModelClass new];
        if ([viewModel isKindOfClass:TSHomePageCellViewModel.class]) {
            TSHomePageCellTemplateModel *templateModel = [TSHomePageCellTemplateModel new];
            templateModel.templateName = sectionName;
            templateModel.data = model.data;
            viewModel.model = templateModel;
        }
    }
    else if ([model.type isEqualToString:@"GroupType"]){
        sectionName = [self configViewModel][model.type];
        
        Class viewModelClass = NSClassFromString([NSString stringWithFormat:@"%@ViewModel",sectionName]);
        viewModel = [viewModelClass new];
        if ([viewModel isKindOfClass:TSHomePageCellViewModel.class]) {
            TSHomePageCellTemplateModel *templateModel = [TSHomePageCellTemplateModel new];
            templateModel.templateName = sectionName;
            templateModel.headerTemplateName = [NSString stringWithFormat:@"%@Header",sectionName];
            templateModel.data = model.data;
            viewModel.model = templateModel;
            _containerViewModel = (TSHomePageContainerViewModel *)viewModel;
        }
    }

    return viewModel;
}

- (NSDictionary *)configViewModel{
    
    return @{
        @"ImageAd1":@"TSHomePageBanner",
        @"Nav":@"TSHomePageCategory",
//        @"RichText":@"TSHomePageReleaseTitle",
        @"ImageAd0":@"TSHomePageRelease",
        @"GroupType":@"TSHomePageContainer",
    };
    
    
    
    
}


@end
