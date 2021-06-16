//
//  TSSecurityCenterDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSecurityCenterDataController.h"

@interface TSSecurityCenterDataController ()

@property (nonatomic, strong) NSMutableArray <TSSettingSectionModel *> *sections;

@end

@implementation TSSecurityCenterDataController

- (void)fetchSecurityCenterContentsComplete:(void (^)(BOOL))complete {
    
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"账户协议", @"TCL App用户隐私政策", @"TCL App应用服务协议", @"TCL App帐号注册协议"];
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
            item.title = title;
            item.cellHeight = 54;
            if (i == 0) {
                item.identify = @"TSSecurityCenterTitleCell";
            } else {
                item.identify = @"TSSettingCommonCell";
                item.showLine = YES;
                if (i == titles.count - 1) {
                    item.showLine = NO;
                }
            }
            [items addObject:item];
        }
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
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
