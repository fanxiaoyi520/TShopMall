//
//  TSCategoryDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryDataController.h"

@interface TSCategoryDataController()

@property (nonatomic, strong) NSMutableArray <TSCategoryKindModel *> *kinds;
@property (nonatomic, strong) NSMutableArray <TSCategorySectionModel *> *sections;

@end

@implementation TSCategoryDataController

-(void)fetchKindsComplete:(void(^)(BOOL isSucess))complete{

    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@"productList_page" forKey:@"pageType"];
    [body setValue:@"APP" forKey:@"uiType"];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kShopContentUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"------");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"------");
    }];
    
    
    NSArray *titles = @[@"智屏",@"冰箱",@"洗衣机",@"空调",@"厨卫大电",@"全屋智能",@"美妆个护",@"附近商品"];
    
    NSMutableArray *kindsArr = [NSMutableArray array];
    for (NSString *title in titles) {
        TSCategoryKindModel *kindModel = [[TSCategoryKindModel alloc] init];
        kindModel.kind = title;
        
        [kindsArr addObject:kindModel];
    }
    
    self.kinds = kindsArr;
    
    complete(YES);
}

-(void)fetchContentsComplete:(void(^)(BOOL isSucess))complete{
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        TSCategorySectionBannerItemModel *item = [[TSCategorySectionBannerItemModel alloc] init];
        item.cellHeight = 144;
        item.identify = @"TSCategoryBannerCell";
        item.imgUrls = @[@""];
        
        TSCategorySectionModel *bannerSection = [[TSCategorySectionModel alloc] init];
        bannerSection.column = 1;
        bannerSection.spacingWithLastSection = 16;
        bannerSection.items = @[item];
        
        [sections addObject:bannerSection];
    }
    
    {
        TSCategorySectionKindItemModel *item = [[TSCategorySectionKindItemModel alloc] init];
        item.cellHeight = 111;
        item.identify = @"TSMeasureCell";
        
        TSCategorySectionModel *section = [[TSCategorySectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"尺寸分类";
        section.headerSize = CGSizeMake(0, 32);
        section.headerIdentify = @"TSCategoryHeaderReusableView";
        section.column = 3;
        section.spacingWithLastSection = 16;
        section.items = @[item,item,item,item,item,item];
        
        [sections addObject:section];
    }
    
    {
        TSCategorySectionKindItemModel *item = [[TSCategorySectionKindItemModel alloc] init];
        item.cellHeight = 111;
        item.identify = @"TSMeasureCell";
        
        TSCategorySectionModel *section = [[TSCategorySectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"推荐品牌";
        section.headerSize = CGSizeMake(0, 32);
        section.headerIdentify = @"TSCategoryHeaderReusableView";
        section.column = 3;
        section.spacingWithLastSection = 16;
        section.items = @[item,item,item,item,item,item,item];
        
        [sections addObject:section];
    }
    
    {
        TSCategorySectionRecommendItemModel *item = [[TSCategorySectionRecommendItemModel alloc] init];
        item.cellHeight = 112;
        item.identify = @"TSRecommendCell";
        
        TSCategorySectionModel *section = [[TSCategorySectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"推荐商品";
        section.headerSize = CGSizeMake(0, 32);
        section.headerIdentify = @"TSCategoryHeaderReusableView";
        section.column = 1;
        section.spacingWithLastSection = 16;
        section.items = @[item,item,item];
        
        [sections addObject:section];
    }
    
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}

@end
