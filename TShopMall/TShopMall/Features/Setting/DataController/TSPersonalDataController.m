//
//  TSPersonalDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSPersonalDataController.h"

@interface TSPersonalDataController ()

@property (nonatomic, strong) NSMutableArray <TSPersonalSectionModel *> *sections;

@end

@implementation TSPersonalDataController

- (void)fetchPersonalContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *titles = @[@"头像", @"姓名", @"身份证", @"性别", @"出生年月"];
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSPersonalSectionItemModel *item = [[TSPersonalSectionItemModel alloc] init];
            item.title = title;
            item.cellHeight = 56.5;
            item.sex = none;
            item.identify = @"TSPersonalCommonCell";
            if (i == 0) {///头像
                item.head = @"mall_setting_defautlhead";
            } else if(i == 1) {///姓名
                item.detail = @"JERRY";
            } else if(i == 2) {///身份证
                item.detail = @"62241999****";
            } else if(i == 3) {///性别
                item.sex = male;
            } else if(i == 4) {///出生年月
                item.detail = @"1997-09-13";
            }
            [items addObject:item];
        }
        TSPersonalSectionModel *section = [[TSPersonalSectionModel alloc] init];
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
