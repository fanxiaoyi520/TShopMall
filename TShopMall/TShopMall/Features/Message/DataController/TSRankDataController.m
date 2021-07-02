//
//  TSRankDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankDataController.h"

@interface TSRankDataController()

@property (nonatomic, strong) NSMutableArray <TSRankSectionModel *> *coronalSections;

@end

@implementation TSRankDataController

-(void)fetchRankCoronalComplete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
        item.cellHeight = 280;
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
            item.cellHeight = 55;
            item.identify = @"TSRankCell";
            item.rank = i;
            item.isLast = i == 8;
            [items addObject:item];
        }
        
        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerSize = CGSizeMake(0, 44);
        section.headerIdentify = @"TSRankHeaderView";
        section.column = 1;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];

        TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
        item.identify = @"TSRankRecommendCell";
        [items addObject:item];

        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
        section.hasHeader = NO;
        section.items = items;
        
        [sections addObject:section];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.coronalSections = sections;
        if (complete) {
            complete(YES);
        }
    });
    
    
}



@end
