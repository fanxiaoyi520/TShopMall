//
//  TSMakeOrderDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderDataController.h"

@implementation TSMakeOrderDataController

- (instancetype)init{
    if (self == [super init]) {
        self.sections = [NSMutableArray array];
    }
    return self;
}

- (void)initData:(void (^)(void))finished{
    [self configAddressSection];
    [self configGoodsSection];
    [self configOperationSection];
    [self confitPriceSection];
    
    finished();
}

- (void)configAddressSection{
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderAddressTipsCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(56.0);
    
//    row.cellIdentifier = @"TSMakeOrderAddressCell";
//    row.isAutoHeight = YES;
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)configGoodsSection{
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderGoodsCell";
    row.isAutoHeight = YES;

    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)configOperationSection{    
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderOperationCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(168.0);
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)confitPriceSection{
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderPriceCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(82.0);
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

@end
