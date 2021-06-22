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
    
    if (model == nil || model.carts.count == 0) {
        [sections addObject:[TSCartViewModel emptyRow]];
    } else {
        [sections addObjectsFromArray:[TSCartViewModel configGoods:model.carts]];
    }
    
    [sections addObject:[TSCartViewModel configInvalidGoods:nil]];
    [sections addObject:[TSCartViewModel configRecomendGoods:nil]];

    return sections;
}

+ (TSCartGoodsSection *)emptyRow{
    TSCartGoodsRow *row = [TSCartGoodsRow new];
    row.cellIdentifier = @"TSCartEmptyCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(384.0);
    
    TSCartGoodsSection *section = [TSCartGoodsSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = 0.1f;
    section.rows = @[row];
    return section;
}

+ (NSArray<TSCartGoodsSection *> *)configGoods:(NSArray<TSCart *> *)carts{
    NSMutableArray *sections = [NSMutableArray array];
    for (NSInteger i=0; i<carts.count; i++) {
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = @"TSCartCell";
        row.obj = carts[i];
        row.canScrollEdit = YES;

        TSCartGoodsSection *section = [TSCartGoodsSection new];
        section.heightForFooter = KRateW(10.0);
        section.rows = @[row];
        [sections addObject:section];
    }
    
    return sections;
}

+ (TSCartGoodsSection *)configInvalidGoods:(id)obj{
    NSMutableArray *invalidRow = [NSMutableArray array];
    for (NSInteger i=0; i<2; i++) {
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = i/1==0? @"TSCartInvalidCell":@"TSCartInvalidTaoCanCell";
        [invalidRow addObject:row];
    }
    TSCartGoodsSection *section = [TSCartGoodsSection new];
    section.heightForHeader = KRateW(54.0);
    section.headerIdentifier = @"TSCartInvalidHeader";
//    section.heightForFooter = KRateW(10.0);
    section.rows = invalidRow;
    
    return section;
}

+ (TSCartGoodsSection *)configRecomendGoods:(id)obj{
    TSCartGoodsRow *recomendRow = [TSCartGoodsRow new];
    recomendRow.cellIdentifier = @"TSCartRecomendCell";
    
    TSCartGoodsSection *section =  [TSCartGoodsSection new];
    section.heightForHeader = KRateW(62.0);
    section.headerIdentifier = @"TSCartRecomendHeader";
    section.heightForFooter = 0.1f;
    section.rows = @[recomendRow];
    
    return section;
}

+ (NSArray<TSCart *> *)canOperationGoodsInSections:(NSArray<TSCartGoodsSection *> *)sections{
    NSMutableArray *arr = [NSMutableArray array];
    for (TSCartGoodsSection *section in sections) {
        TSCartGoodsRow *row = [section.rows lastObject];
        if ([row.cellIdentifier isEqualToString:@"TSCartCell"]) {
            [arr addObject:row.obj];
        }
    }
    return arr;
}

+ (BOOL)isAllGoodsSelected:(NSArray<TSCart *> *)goods{
    for (TSCart *model in goods) {
        if (model.isSelected == NO) {
            return NO;
        }
    }
    return YES;
}

+ (NSArray<TSCart *> *)selectedInfo:(NSArray<TSCart *> *)cartModels{
    NSMutableArray *arr = [NSMutableArray array];
    for (TSCart *model in cartModels) {
        if (model.isSelected == YES) {
            [arr addObject:model];
        }
    }
    return arr;
}
+ (NSString *)totalPrice:(NSArray<TSCart *> *)cartModels{
    CGFloat totalPrice = 0;
    for (TSCart *model in cartModels) {
        if (model.isSelected == YES) {
            totalPrice = totalPrice + model.finalPrice.floatValue * model.buyNum;
        }
    }
    return [NSString stringWithFormat:@"%.2f", totalPrice];
}

@end
