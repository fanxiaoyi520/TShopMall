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
#import "TSJsonCacheData.h"

@interface TSHomePageViewModel ()
@end

@implementation TSHomePageViewModel
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStatusChanged:) name:TS_NetWork_State object:nil];
    }
    return self;
}
- (void)loadDefaultData{
//    TSHomePageBannerViewModel *bannerViewModel = [TSHomePageBannerViewModel new];
//    TSHomePageCellTemplateModel *templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageBanner";
//    bannerViewModel.model = templateModel;
//
//    TSHomePageCategoryViewModel *categoryViewModel = [TSHomePageCategoryViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageCategory";
//    categoryViewModel.model = templateModel;
//
//    TSHomePageReleaseTitleViewModel *releaseTitleViewModel = [TSHomePageReleaseTitleViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageReleaseTitle";
//    releaseTitleViewModel.model = templateModel;
//
//
//    TSHomePageReleaseViewModel *releaseViewModel = [TSHomePageReleaseViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageRelease";
//    releaseViewModel.model = templateModel;
//
//
//    TSCategoryGroupViewModel *containerViewModel = [TSCategoryGroupViewModel new];
//    templateModel = [TSHomePageCellTemplateModel new];
//    templateModel.templateName = @"TSHomePageContainer";
//    templateModel.headerTemplateName = @"TSHomePageContainerHeader";
//
//    containerViewModel.model = templateModel;
//    _containerViewModel = containerViewModel;
    
    
//    NSArray *temp = self.model.data[@"list"];
//
//     NSMutableArray *marr = @[].mutableCopy;
//
//     for (NSDictionary *dic in temp) {
//         TSCategoryGroup *model = [TSCategoryGroup new];
//         model.name = dic[@"groupName"];
//         model.groupId = dic[@"goodsgroupUuid"];
//         [marr addObject:model];
//     }
    

//    NSMutableArray *sections = [NSMutableArray array];
//
//    for (TSHomePageContentModel *model in temp) {
//        TSHomePageCellViewModel *viewModel = [self configSection:model];
//        if(viewModel){
//            [sections addObject:viewModel];
//        }
//    }
//    
//    self.dataSource = sections;
 
}

-(void)fetchData{
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
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
            [TSJsonCacheData writePlistWithData:content saveKey:@"homePageList"];
            [self setUITemplateWithResponseData:content];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];

}

- (void)setUITemplateWithResponseData:(NSString *)responseData{
    NSArray *contentArr = [responseData jsonValueDecoded][@"items"];
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
            templateModel.templateName = @"TSHomePageContainer";
            templateModel.headerTemplateName = @"TSHomePageContainerHeader";
            templateModel.data = model.data;
            viewModel.model = templateModel;
            _containerViewModel = (TSCategoryGroupViewModel *)viewModel;
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
        @"GroupType":@"TSCategoryGroup",
    };
    
}

- (void)netWorkStatusChanged:(NSNotification *)noti{
    NSInteger state = [noti.object intValue];
    if (state == 0) {
        /// 取缓存
        NSString *content = [TSJsonCacheData readPlistWithKey:@"homePageList"];
        if (content) {
            [self setUITemplateWithResponseData:content];
        }
    }
   
}
@end
