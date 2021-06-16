//
//  TSAboutMeDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSAboutMeDataController.h"
#import "TSSettingSectionModel.h"

@interface TSAboutMeDataController ()

@property (nonatomic, strong) NSMutableArray <TSAboutMeSectionModel *> *sections;

@end

@implementation TSAboutMeDataController

- (void)fetchContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAboutMeSectionItemModel *item = [[TSAboutMeSectionItemModel alloc] init];
        item.cellHeight = 224;
        item.version = @"版本：1.0.0";
        item.identify = @"TSAboutMeTopCell";
        [items addObject:item];
        TSAboutMeSectionModel *section = [[TSAboutMeSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *titles = @[@"版本信息", @"意见反馈", @"服务协议", @"隐私政策", @"版本更新"];
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
            item.title = title;
            item.detail = @"";
            item.identify = @"TSSettingCommonCell";
            if (i == titles.count - 1) {
                item.cellHeight = 56;
                item.showLine = NO;
                item.updateFlag = YES;
            } else {
                item.cellHeight = 56.5;
                item.showLine = YES;
                item.updateFlag = NO;
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
        TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight - 508 - GK_STATUSBAR_NAVBAR_HEIGHT;
        item.identify = @"TSAboutMeBottomCell";
        [items addObject:item];
        TSAboutMeSectionModel *section = [[TSAboutMeSectionModel alloc] init];
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
