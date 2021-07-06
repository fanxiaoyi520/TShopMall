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
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        [self.KVOController observe:[AFNetworkReachabilityManager sharedManager] keyPath:@"networkReachabilityStatus" options:( NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
            @strongify(self)
            NSLog(@"%ld",[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
            if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
                NSString *content = [TSJsonCacheData readPlistWithKey:@"homePageList"];
                if (content) {
                    [self setUITemplateWithResponseData:content];
                }
            }else{
                [self fetchData];
            }
        }];
    }
    return self;
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

@end
