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
    
    //热销
    [[TSServicesManager sharedInstance].bestSellingRecommendService getRecommendListWithType:@"hotSellList_page" success:^(NSArray<id<TSRecomendGoodsProtocol>> * _Nullable list) {
        
        // 列表数据
        NSMutableArray *sections = [NSMutableArray array];
        // 前三名列表
        NSMutableArray<TSRecomendGoods *> *topRankList = [NSMutableArray new];
        // 排行榜列表
        NSMutableArray<TSHotSectionItemModel *> *rankList = [NSMutableArray new];
        
        for (NSInteger i = 0; i < list.count; i++) {
            id<TSRecomendGoodsProtocol> goodItem = list[i];
            
            TSHotSectionItemModel *item = [[TSHotSectionItemModel alloc] init];
            item.cellHeight = 120;
            item.identify = @"TSGoodsHotRankCell";
            item.goodModel = goodItem;
            [rankList addObject:item];
            
            // 保存前三名
            if (topRankList.count < 3) {
                [topRankList addObject:goodItem];
            }
        }
        
        // top
        {
            NSMutableArray *items = [NSMutableArray array];
            TSHotSectionItemModel *item = [[TSHotSectionItemModel alloc] init];
            item.cellHeight = KRateW(250 + 10 + 10);
            item.identify = @"TSGoodsShowCell";
            item.rankList = topRankList;
            [items addObject:item];
            
            TSHotSectionModel *section = [[TSHotSectionModel alloc] init];
            section.column = 1;
            section.items = items;
            [sections addObject:section];
        }
        
        //列表
        {
            TSHotSectionModel *section = [[TSHotSectionModel alloc] init];
            section.column = 1;
            section.items = rankList;
            [sections addObject:section];
        }
        
        self.sections = sections;
        
        if (complete) {
            complete(YES);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (complete) {
            complete(NO);
        }
    }];
}

@end
