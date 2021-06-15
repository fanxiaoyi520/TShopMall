//
//  TSSearchDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchDataController.h"

@implementation TSSearchDataController
+ (void)fetchData:(void (^)(NSArray<TSSearchSection *> *, NSError *))finished{
    NSMutableArray *sections = [NSMutableArray array];
    [sections addObject:[TSSearchDataController configHotSection:nil]];
    [sections addObject:[TSSearchDataController configHistorySection:nil]];
    [sections addObject:[TSSearchDataController configRecomendSection:nil]];
    
    finished(sections, nil);
}

+ (TSSearchSection *)configHotSection:(id)obj{
    
    NSMutableArray *rows = [NSMutableArray array];
    NSArray *arr = @[@"滚筒洗衣机", @"空气净化器", @"电视", @"XESS电视", @"空调", @"智能冰箱", @"门锁"];
    for (NSString *str in arr) {
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = @"TSSearchMarkCell";
        row.obj = str;
        [rows addObject:row];
    }
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerTitle = @"热门搜索";
    section.headerHeight = KRateW(40.0);
    section.footerHeight = KRateW(22.0);
    section.rows = rows;
    
    return section;
}

+ (TSSearchSection *)configHistorySection:(id)obj{
    
    NSMutableArray *rows = [NSMutableArray array];
    NSArray *arr = @[@"滚筒洗衣机", @"曲面", @"大屏", @"智能冰箱智能冰箱",  @"XESS", @"旋转智屏", @"门锁", @"洗衣机", @"滚筒洗衣机", @"曲面", @"大屏", @"智能冰箱"];
    for (NSString *str in arr) {
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = @"TSSearchMarkCell";
        row.obj = str;
        [rows addObject:row];
    }
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerTitle = @"历史搜索";
    section.headerHeight = KRateW(40.0);
    section.footerHeight = KRateW(22.0);
    section.rows = rows;
    
    return section;
}

+ (TSSearchSection *)configRecomendSection:(id)obj{
    TSSearchRow *row = [TSSearchRow new];
    row.cellIdentifier = @"TSSearchRecomendCell";
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerTitle = @"热门推荐";
    section.headerHeight = KRateW(40.0);
    section.footerHeight = GK_SAFEAREA_BTM;
    section.rows = @[row, row, row];
    
    return section;
}



@end
