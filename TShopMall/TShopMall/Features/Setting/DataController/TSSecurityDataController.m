//
//  TSSecurityController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSecurityDataController.h"

@interface TSSecurityDataController ()

@property (nonatomic, strong) NSMutableArray <TSSettingSectionModel *> *sections;

@end

@implementation TSSecurityDataController

- (void)fetchSecurityContentsComplete:(void (^)(BOOL))complete {
    
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"手机号码", @"账号注销"];
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
            item.title = title;
            item.cellHeight = 56.5;
            item.identify = @"TSSettingCommonCell";
            item.showLine = YES;
            if (i == titles.count - 1) {
                item.showLine = NO;
                item.cellHeight = 56;
            }
            [items addObject:item];
        }
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
        item.title = @"提现密码设置";
        item.cellHeight = 56.5;
        item.identify = @"TSSettingCommonCell";
        item.showLine = NO;
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        section.spacingWithLastSection = 10;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"登录绑定", @"微信号码", @"Apple号码"];
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
            item.title = title;
            item.cellHeight = 56.5;
            if (i == 0) {
                item.identify = @"TSSecurityCenterTitleCell";
            } else {
                item.identify = @"TSSecurityCell";
                item.detail = @"347****990";
                item.on = YES;
                if (i == titles.count - 1) {
                    item.showLine = NO;
                    item.cellHeight = 56;
                    item.detail = @"";
                    item.on = NO;
                }
            }
            item.showLine = YES;
            [items addObject:item];
        }
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        section.spacingWithLastSection = 10;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
        item.title = @"安全中心";
        item.cellHeight = 56.5;
        item.identify = @"TSSettingCommonCell";
        item.showLine = NO;
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        section.spacingWithLastSection = 10;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

@end
