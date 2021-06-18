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
        item.cellHeight = 300;
        item.identify = @"TSRankHonourCell";
        
        [items addObject:item];
        
        TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
        item.cellHeight = 55;
        item.identify = @"TSRankCell";
        
        [items addObject:item];
        
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
        
        for (int i = 0; i < 10; i++) {
            TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
            item.cellHeight = 282;
            item.identify = @"TSRankRecommendCell";
            
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
        
        [sections addObject:section];
    }
    
    self.coronalSections = sections;
    
    if (complete) {
        complete(YES);
    }
}

@end
