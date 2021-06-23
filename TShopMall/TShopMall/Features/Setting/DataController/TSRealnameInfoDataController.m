//
//  TSRealnameInfoDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSRealnameInfoDataController.h"

@interface TSRealnameInfoDataController ()
/** sections  */
@property(nonatomic, strong) NSMutableArray<TSRealnameInfoSectionModel *> *sections;

@end



@implementation TSRealnameInfoDataController


- (void)fetchRealnameInfoContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSRealnameInfoSectionItemModel *item = [[TSRealnameInfoSectionItemModel alloc] init];
        item.realname = @"谭*辉";
        item.idcard = @"6224******777";
        item.cellHeight = kScreenHeight;
        item.identify = @"TSRealNameInfoCell";
        [items addObject:item];
        TSRealnameInfoSectionModel *section = [[TSRealnameInfoSectionModel alloc] init];
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
