//
//  TSHotDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/21.
//

#import "TSHotDataController.h"

@interface TSHotDataController ()

@property (nonatomic, strong) NSMutableArray <TSHotSectionModel *> *sections;

@end

@implementation TSHotDataController

- (void)fetchHotGoodsComplete:(void(^)(BOOL isSucess))complete {
    
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSHotSectionItemModel *item = [[TSHotSectionItemModel alloc] init];
        item.cellHeight = 265;
        item.identify = @"TSGoodsShowCell";
        [items addObject:item];
        
        TSHotSectionModel *section = [[TSHotSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            TSHotSectionItemModel *item = [[TSHotSectionItemModel alloc] init];
            item.cellHeight = 120;
            item.identify = @"TSGoodsHotRankCell";
            item.rank = i;
            [items addObject:item];
        }
        TSHotSectionModel *section = [[TSHotSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

@end
