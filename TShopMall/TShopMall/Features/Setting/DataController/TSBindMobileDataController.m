//
//  TSBindMobileDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBindMobileDataController.h"

@interface TSBindMobileDataController ()

@property (nonatomic, strong) NSMutableArray <TSBindMobileSectionModel *> *sections;

@end

@implementation TSBindMobileDataController

- (void)fetchBindMobileContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSBindMobileSectionItemModel *item = [[TSBindMobileSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.identify = @"TSBindMobileCell";
        [items addObject:item];
        TSBindMobileSectionModel *section = [[TSBindMobileSectionModel alloc] init];
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
