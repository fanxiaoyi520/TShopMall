//
//  TSCartViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartViewModel.h"

@implementation TSCartViewModel

+ (instancetype)congfigViewModelWithCartInfo:(TSCartModel *)cartModel{
    TSCartViewModel *viewModel = [TSCartViewModel new];
    viewModel.sections = [[self class] viewModel:cartModel];
    return viewModel;
}

+ (NSArray<TSCartGoodsSection *> *)viewModel:(TSCartModel *)model{
    NSMutableArray<TSCartGoodsSection *> *sections = [NSMutableArray array];
    
    for (NSInteger i=0; i<2; i++) {
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = @"TSCartCell";

        TSCartGoodsSection *section = [TSCartGoodsSection new];
        section.heightForFooter = KRateW(10.0);
        section.rows = @[row];
        [sections addObject:section];
    }
    
    NSMutableArray *invalidRow = [NSMutableArray array];
    for (NSInteger i=0; i<2; i++) {
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = i/1==0? @"TSCartInvalidCell":@"TSCartInvalidTaoCanCell";
        [invalidRow addObject:row];
    }
    TSCartGoodsSection *section = [TSCartGoodsSection new];
    section.heightForHeader = KRateW(54.0);
    section.headerIdentifier = @"TSCartInvalidHeader";
    section.heightForFooter = KRateW(10.0);
    section.rows = invalidRow;
    [sections addObject:section];
    
    return sections;
}
@end
