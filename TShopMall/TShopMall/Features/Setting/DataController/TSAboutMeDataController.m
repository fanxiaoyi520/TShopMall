//
//  TSAboutMeDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSAboutMeDataController.h"
#import "TSSettingSectionModel.h"
#import "TSTools.h"

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
        item.version = [NSString stringWithFormat:@"版本：%@", [TSTools getVersion]];
        item.identify = @"TSAboutMeTopCell";
        [items addObject:item];
        TSAboutMeSectionModel *section = [[TSAboutMeSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        NSMutableArray *titles = [NSMutableArray arrayWithArray:@[@"版权信息", @"意见反馈"]];
    
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
            item.title = title;
            item.detail = @"";
            item.serverURL = @"home";
            item.identify = @"TSSettingCommonCell";
            item.cellHeight = 57;
            item.showLine = YES;
            item.updateFlag = NO;
            [items addObject:item];
        }
        for (TSAgreementModel *agreementModel in [TSGlobalManager shareInstance].agreementModels) {
            [titles addObject:agreementModel.title];
            TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
            item.title = agreementModel.title;
            item.detail = @"";
            item.serverURL = agreementModel.serverUrl;
            item.identify = @"TSSettingCommonCell";
            item.cellHeight = 57;
            item.showLine = YES;
            item.updateFlag = NO;
            [items addObject:item];
        }
        TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
        item.title = @"版本更新";
        item.detail = @"";
        item.identify = @"TSSettingCommonCell";
        item.cellHeight = 57;
        item.showLine = NO;
        item.updateFlag = YES;
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
        {
            NSMutableArray *items = [NSMutableArray array];
            TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
            CGFloat height = kScreenHeight - 57 * (titles.count + 1) - GK_STATUSBAR_NAVBAR_HEIGHT - 224;
            if (height < 50) {
                height = 50;
            }
            item.cellHeight = height;
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
}

@end
