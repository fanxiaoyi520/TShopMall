//
//  TSHomePageDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageDataController.h"
#import "TSHomePageBackgroundReusableView.h"
#import "TSUniverseCollectionBackgroundView.h"
#import "TSUniverseBackgroundHeaderView.h"
#import "TSHomePageReleaseHeaderReusableView.h"
#import "TSHomePageBannerCell.h"
#import "TSHomePageCategoryCell.h"
#import "TSHomePageReleaseCell.h"

@implementation TSHomePageDataController

-(NSMutableArray <FMLayoutBaseSection *> *)fetchPlaceholderLayouts{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    //背景
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)
                                                                            itemSpace:10
                                                                            lineSpace:10
                                                                               column:1];
        section.header = [FMLayoutHeader elementSize:204 viewClass:[TSHomePageBackgroundReusableView class]];
        section.header.type = FMLayoutHeaderTypeSuspensionBigger;
        section.header.zIndex = FMLayoutZIndexBackOfItem;
        section.header.minSize = 90;
        section.header.isStickTop = YES;
        section.header.lastMargin = -100;
        section.itemSize = CGSizeMake(kScreenWidth, 174);
        section.itemDatas = [@[@"1"] mutableCopy];
        section.cellElement = [FMLayoutElement elementWithViewClass:[TSHomePageBannerCell class] isNib:NO];
        [sections addObject:section];
    }
    
    {
        CGFloat itemW = (kScreenWidth - 32)/5.0;
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 16, 0, 16)
                                                                            itemSpace:0
                                                                            lineSpace:0
                                                                               column:5];
        section.header = [FMLayoutHeader elementSize:12 viewClass:[TSUniverseBackgroundHeaderView class]];
        section.header.zIndex = FMLayoutZIndexBg;
        section.itemSize = CGSizeMake(itemW, 100);
        section.itemDatas = [@[@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"1"] mutableCopy];
        section.cellElement = [FMLayoutElement elementWithViewClass:[TSHomePageCategoryCell class] isNib:NO];
        section.background = [FMLayoutBackground bgWithViewClass:[TSUniverseCollectionBackgroundView class]];
        section.background.inset = UIEdgeInsetsMake(0, 16, 0, 16);
        [sections addObject:section];
    }
    
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:0 lineSpace:0 column:1];
        section.header = [FMLayoutHeader elementSize:30 viewClass:[TSHomePageReleaseHeaderReusableView class]];
        section.header.type = FMLayoutHeaderTypeFixed;
        section.sectionOffset = 40;
        section.itemSize = CGSizeMake(kScreenWidth, 447);
        section.itemDatas = [@[@"1"] mutableCopy];
        section.cellElement = [FMLayoutElement elementWithViewClass:[TSHomePageReleaseCell class] isNib:NO];
        [sections addObject:section];
    }
    
    self.layouts = sections;
    
    return sections;
}

@end
