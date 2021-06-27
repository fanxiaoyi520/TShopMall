//
//  TSRankDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankDataController.h"
#import "TSServicesManager.h"

@interface TSRankDataController()

@property (nonatomic, strong) NSMutableArray <TSRankSectionModel *> *coronalSections;

@end

@implementation TSRankDataController

-(void)fetchRankCoronalComplete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
        item.cellHeight = 340;
        item.identify = @"TSRankHonourCell";
        
        [items addObject:item];
        
        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        for (int i = 1; i <= 8; i++) {
            TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
            item.cellHeight = 55.5;
            item.identify = @"TSRankCell";
            item.rank = i;
            [items addObject:item];
        }
        
        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerSize = CGSizeMake(0, 56);
        section.headerIdentify = @"TSRankHeaderView";
        section.column = 1;
        section.items = items;
        
        [sections addObject:section];
    }
    
//    {
//        NSMutableArray *items = [NSMutableArray array];
//
//        for (int i = 0; i < 10; i++) {
//            TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
//            item.cellHeight = 282;
//            item.identify = @"TSRankRecommendCell";
//            [items addObject:item];
//        }
//
//        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
//        section.hasHeader = YES;
//        section.headerSize = CGSizeMake(0, 64);
//        section.headerIdentify = @"TSRankRecommendHeaderView";
//        section.column = 2;
//        section.interitemSpacing = 8;
//        section.lineSpacing = 10;
//        section.items = items;
//
//        [sections addObject:section];
//    }
    
    self.coronalSections = sections;
    
    if (complete) {
        complete(YES);
    }
}

-(void)fetchRecomendComplete:(void(^)(BOOL isSucess))complete{

    [[TSServicesManager sharedInstance].bestSellingRecommendService getRecommendListWithType:@"searchResult_page" success:^(NSArray<id<TSRecomendGoodsProtocol>> * _Nullable list) {
        
        NSMutableArray *items = [NSMutableArray array];

        for (int i = 0; i < list.count; i++) {
            TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
            item.cellHeight = 282;
            item.identify = @"TSRankRecommendCell";
            item.recomendGoods = list[i];
            [items addObject:item];
        }

        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerSize = CGSizeMake(0, 64);
        section.headerIdentify = @"TSRankRecommendHeaderView";
        section.column = 2;
        section.interitemSpacing = 8;
        section.lineSpacing = 10;
        section.items = items;

        [self.coronalSections addObject:section];
        
        if (complete) {
            complete(YES);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
