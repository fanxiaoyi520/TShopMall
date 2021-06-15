//
//  TSGoodsListDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSGoodsListDataController.h"

@implementation TSGoodsListDataController
+ (instancetype)fetchData:(void (^)(NSArray<TSGoodsListSection *> *, NSError *))finished{
    TSGoodsListDataController *con = [TSGoodsListDataController new];
    
    con.model = nil;
    finished([TSGoodsListDataController sectionsWithModels:con.model isGrid:YES], nil);
    return con;
}



+ (NSArray<TSGoodsListSection *> *)sectionsWithModels:(id)models isGrid:(BOOL)isGrid{
    NSMutableArray *rows = [NSMutableArray array];
    for (NSInteger i=0; i<8; i++) {
        TSGoodsListRow *row = [TSGoodsListRow new];
        row.cellIdentifier = isGrid==YES? @"TSGoodsListCell":@"TSGoodsListRailCell";
        row.rowSize = isGrid==YES? CGSizeMake((kScreenWidth - KRateW(40.0))/2.0, KRateW(282.0)):CGSizeMake(kScreenWidth-KRateW(32.0), KRateW(120.0));
        row.obj = nil;
        [rows addObject:row];
    }
    
    TSGoodsListSection *section = [TSGoodsListSection new];
    section.headerIdentifier = @"UICollectionReusableView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    section.rows = rows;
    return @[section];
}

@end
