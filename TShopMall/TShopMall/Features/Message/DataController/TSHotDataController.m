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
    // 列表数据
    __block NSMutableArray *sections = [NSMutableArray array];
    // 列表数据
    __block TSHotSectionModel *lastSection = [[TSHotSectionModel alloc] init];
    
    //线程组
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //开启任务1
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        
        //热销
        [[TSServicesManager sharedInstance].bestSellingRecommendService getRecommendListWithType:@"hotSellList_page" success:^(NSArray<id<TSRecomendGoodsProtocol>> * _Nullable list) {
            // 前三名列表
            NSMutableArray<TSRecomendGoods *> *topRankList = [NSMutableArray new];
            // 热销列表
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
            
            dispatch_group_leave(group);
            
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(group);
        }];
    });
    
    //开启任务2
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        
        //热销推荐
        [[TSServicesManager sharedInstance].bestSellingRecommendService getRecommendListWithType:@"rank_page" success:^(NSArray<id<TSRecomendGoodsProtocol>> * _Nullable list) {
            
            // 推荐列表
            NSMutableArray<TSHotSectionItemModel *> *hotList = [NSMutableArray new];
            
            for (NSInteger i = 0; i < list.count; i++) {
                id<TSRecomendGoodsProtocol> goodItem = list[i];
                
                TSHotSectionItemModel *hotItem = [[TSHotSectionItemModel alloc] init];
                hotItem.cellHeight = 282;
                hotItem.identify = @"TSGridGoodsCollectionViewCell";
                hotItem.goodModel = goodItem;
                [hotList addObject:hotItem];
            }
            
            //热销推荐
            lastSection.hasHeader = YES;
            lastSection.headerSize = CGSizeMake(0, 56);
            lastSection.headerIdentify = @"TSHotGoodsHeaderView";
            lastSection.header_title = @"热销推荐";
            
            lastSection.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
            lastSection.column = 2;
            lastSection.lineSpacing = 8;
            lastSection.interitemSpacing = 8;
            lastSection.items = hotList;
            
            dispatch_group_leave(group);
            
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(group);
        }];
    });
    
    //完成
    @weakify(self);
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            NSMutableArray *allList = [NSMutableArray array];
            [allList addObjectsFromArray:sections];
            [allList addObject:lastSection];
            self.sections = allList;
            
            if (complete) {
                complete(YES);
            }
        });
    });
    
    
}

@end
