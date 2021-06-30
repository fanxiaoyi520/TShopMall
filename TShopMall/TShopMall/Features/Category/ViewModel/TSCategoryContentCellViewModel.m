//
//  TSCategoryContentCellViewModel.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSCategoryContentCellViewModel.h"

@implementation TSCategoryContentCellViewModel

+ (nonnull TSCategoryContentCellViewModel *)viewModelWithSubject:(nonnull TSCategoryContentModel *)kindModel{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    //banner
    {
        TSCategorySectionBannerItemModel *item = [[TSCategorySectionBannerItemModel alloc] init];
        item.cellHeight = 144;
        item.identify = @"TSCategoryBannerCell";
        item.imgUrls = @[kindModel.OneLevelImg];
        
        TSCategorySectionModel *bannerSection = [[TSCategorySectionModel alloc] init];
        bannerSection.column = 1;
        bannerSection.spacingWithLastSection = 16;
        bannerSection.items = @[item];
        
        [sections addObject:bannerSection];
    }
    
    //热门分类
    {
        NSMutableArray *items = [NSMutableArray array];
        
        for (NSDictionary *itemDic in kindModel.TwoLevel) {
            TSCategorySectionKindItemModel *item = [[TSCategorySectionKindItemModel alloc] init];
            item.cellHeight = 111;
            item.identify = @"TSMeasureCell";
            item.TwoLevelTitle = itemDic[@"TwoLevelTitle"];
            item.TwoLevelImg = itemDic[@"TwoLevelImg"];
            item.typeValue = itemDic[@"typeValue"];
            item.objectValue = itemDic[@"objectValue"];
            [items addObject:item];
        }
        
        TSCategorySectionModel *section = [[TSCategorySectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"热门分类";
        section.headerSize = CGSizeMake(0, 32);
        section.headerIdentify = @"TSCategoryHeaderReusableView";
        section.column = 3;
        section.spacingWithLastSection = 16;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        for (NSDictionary *itemDic in kindModel.goodsList) {
            TSCategorySectionRecommendItemModel *item = [[TSCategorySectionRecommendItemModel alloc] init];
            item.cellHeight = 112;
            item.identify = @"TSRecommendCell";
            item.promotionPrice = itemDic[@"promotionPrice"];
            item.buyState = itemDic[@"buyState"];
            item.recommend = itemDic[@"recommend"];
            item.baseRetailPrice = itemDic[@"baseRetailPrice"];
            item.uuid = itemDic[@"uuid"];
            item.productName = itemDic[@"productName"];
            item.sellingPrice = itemDic[@"sellingPrice"];
            item.price = itemDic[@"price"];
            item.imageUrl = itemDic[@"imageUrl"];
            item.stock = itemDic[@"stock"];
            item.staffPrice = itemDic[@"staffPrice"];
            item.earnMost = itemDic[@"earnMost"];
            [items addObject:item];
        }

        TSCategorySectionModel *section = [[TSCategorySectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"推荐商品";
        section.headerSize = CGSizeMake(0, 32);
        section.headerIdentify = @"TSCategoryHeaderReusableView";
        section.column = 1;
        section.spacingWithLastSection = 16;
        section.items = items;
        
        [sections addObject:section];
    }
    
    TSCategoryContentCellViewModel *viewModel = [[self alloc] init];
    viewModel.sections = sections;
    
    return viewModel;
}

@end
