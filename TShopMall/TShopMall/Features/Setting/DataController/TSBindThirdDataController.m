//
//  TSBindThirdDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBindThirdDataController.h"

@interface TSBindThirdDataController ()

@property (nonatomic, strong) NSMutableArray <TSBindThirdSectionModel *> *sections;

@end

@implementation TSBindThirdDataController

- (void)fetchBindThirdContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSBindThirdSectionItemModel *item = [[TSBindThirdSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.identify = @"TSBindThirdAppCell";
        item.wechat = YES;
        [items addObject:item];
        TSBindThirdSectionModel *section = [[TSBindThirdSectionModel alloc] init];
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
