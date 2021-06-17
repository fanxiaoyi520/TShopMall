//
//  TSSettingDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/12.
//

#import "TSSettingDataController.h"

@interface TSSettingDataController ()

@property (nonatomic, strong) NSMutableArray <TSSettingSectionModel *> *sections;

@end

@implementation TSSettingDataController

- (void)fetchSettingContentsComplete:(void (^)(BOOL))complete {
    
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingSectionItemModel *item = [[TSSettingSectionItemModel alloc] init];
        item.cellHeight = 74;
        item.identify = @"TSSettingUserCell";
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingCommonSectionItemModel *item1 = [[TSSettingCommonSectionItemModel alloc] init];
        item1.title = @"账号安全";
        item1.detail = @"";
        item1.showLine = NO;
        item1.cellHeight = 56;
        item1.identify = @"TSSettingCommonCell";
        [items addObject:item1];
        TSSettingCommonSectionItemModel *item2 = [[TSSettingCommonSectionItemModel alloc] init];
        item2.title = @"地址管理";
        item2.detail = @"";
        item2.showLine = NO;
        item2.cellHeight = 56;
        item2.identify = @"TSSettingCommonCell";
        [items addObject:item2];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        section.lineSpacing = 10;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingCommonSectionItemModel *item1 = [[TSSettingCommonSectionItemModel alloc] init];
        item1.title = @"清理缓存";
        item1.detail = @"";
        item1.showLine = YES;
        item1.cellHeight = 56.5;
        item1.identify = @"TSSettingCommonCell";
        [items addObject:item1];
        TSSettingCommonSectionItemModel *item2 = [[TSSettingCommonSectionItemModel alloc] init];
        item2.title = @"关于我们";
        item2.detail = @"";
        item2.showLine = NO;
        item2.cellHeight = 56;
        item2.identify = @"TSSettingCommonCell";
        [items addObject:item2];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 10;
        section.lineSpacing = 0;
        section.items = items;
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingExitSectionItemModel *item = [[TSSettingExitSectionItemModel alloc] init];
        item.cellHeight = 56;
        item.identify = @"TSSettingExitCell";
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 10;
        section.lineSpacing = 0;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}

@end
