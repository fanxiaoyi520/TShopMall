//
//  TSPaySuccessDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/24.
//

#import "TSPaySuccessDataController.h"

@implementation TSPaySuccessDataController


- (instancetype)init{
    if (self == [super init]) {
        [self configHeaderSection];
    }
    return self;
}

- (void)configHeaderSection{
    TSPaySuccessItem *item = [TSPaySuccessItem new];
    item.identify = @"TSPaySuccessHeaderCell";
    item.cellHeight = GK_STATUSBAR_NAVBAR_HEIGHT + KRateW(180.0);
    
    TSPaySuccessSection *section = [[TSPaySuccessSection alloc] init];
    section.hasHeader = NO;
    section.column = 1;
    section.headerIdentify = @"UICollectionReusableView";
    section.headerSize = CGSizeZero;
    section.footerSize = CGSizeMake(kScreenWidth, KRateW(8.0));
    section.footerIdentify = @"UICollectionReusableView";
    section.items = @[item];
    
    [self.sections addObject:section];
}

- (void)configRecomendSection:(NSArray<TSRecomendGoods *> *)goods isGrid:(BOOL)isGrid{
    
    NSMutableArray *rows = [NSMutableArray array];
    for (TSRecomendGoods *good in goods) {
        TSPaySuccessItem *item = [TSPaySuccessItem new];
        item.identify = isGrid==NO? @"":@"TSPaySuccessRecomendCell";
        item.cellHeight = KRateW(282.0);
        item.obj = good;
        [rows addObject:item];
    }
    
    TSPaySuccessSection *section = [[TSPaySuccessSection alloc] init];
    section.hasHeader = YES;
    section.hasFooter = YES;
    section.column = 2;
    section.headerIdentify = @"TSPaySuccessRecomendHeaderView";
    section.headerSize = CGSizeMake(kScreenWidth, KRateW(56.0));
    section.footerSize = CGSizeMake(kScreenWidth, GK_SAFEAREA_BTM);
    section.footerIdentify = @"UICollectionReusableView";
    section.interitemSpacing = KRateW(8.0);
    section.lineSpacing = KRateW(8.0);
    section.sectionInset = UIEdgeInsetsMake(0, KRateW(16.0), 0, KRateW(16.0));
    section.items = rows;
    
    [self.sections addObject:section];
}


- (NSMutableArray<TSPaySuccessSection *> *)sections{
    if (_sections) {
        return _sections;
    }
    self.sections = [NSMutableArray array];
    
    return self.sections;
}

@end
