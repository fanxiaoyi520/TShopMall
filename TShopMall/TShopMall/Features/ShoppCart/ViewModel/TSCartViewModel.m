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
        TSCartModel *model = [TSCartModel new];
        model.hasGift = i;
        
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = @"TSCartCell";
        row.obj = model;

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
    
    TSCartGoodsRow *recomendRow = [TSCartGoodsRow new];
    recomendRow.cellIdentifier = @"TSCartRecomendCell";
    
    TSCartGoodsSection *recomendSection =  [TSCartGoodsSection new];
    recomendSection.heightForHeader = KRateW(62.0);
    recomendSection.headerIdentifier = @"TSCartRecomendHeader";
    recomendSection.heightForFooter = 0.1f;
    recomendSection.rows = @[recomendRow];
    [sections addObject:recomendSection];
    
    return sections;
}

+ (NSArray<TSCartModel *> *)canOperationGoodsInSections:(NSArray<TSCartGoodsSection *> *)sections{
    NSMutableArray *arr = [NSMutableArray array];
    for (TSCartGoodsSection *section in sections) {
        TSCartGoodsRow *row = [section.rows lastObject];
        if ([row.cellIdentifier isEqualToString:@"TSCartCell"]) {
            [arr addObject:row.obj];
        }
    }
    return arr;
}

+ (BOOL)isAllGoodsSelected:(NSArray<TSCartModel *> *)goods{
    for (TSCartModel *model in goods) {
        if (model.isSelected == NO) {
            return NO;
        }
    }
    return YES;
}

+ (NSArray<TSCartModel *> *)selectedInfo:(NSArray<TSCartModel *> *)cartModels{
    NSMutableArray *arr = [NSMutableArray array];
    for (TSCartModel *model in cartModels) {
        if (model.isSelected == YES) {
            [arr addObject:model];
        }
    }
    return arr;
}
+ (NSString *)totalPrice:(NSArray<TSCartModel *> *)cartModels{
    CGFloat totalPrice = 0;
    for (TSCartModel *model in cartModels) {
        if (model.isSelected == YES) {
            totalPrice = totalPrice + model.price.floatValue * model.num;
        }
    }
    return [NSString stringWithFormat:@"%.2f", totalPrice];
}

@end
