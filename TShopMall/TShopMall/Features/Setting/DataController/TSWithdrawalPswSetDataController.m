//
//  TSWithdrawalPswSetDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSWithdrawalPswSetDataController.h"

@interface TSWithdrawalPswSetDataController ()

@property (nonatomic, strong) NSMutableArray <TSWithdrawalPswSetSectionModel *> *sections;

@end


@implementation TSWithdrawalPswSetDataController

- (void)fetchWithdrawalPswSetContentsWithHasSet:(BOOL)hasSet complete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSWithdrawalPswSetSectionItemModel *item = [[TSWithdrawalPswSetSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.hasSet = hasSet;
        item.identify = @"TSWithdrawalPswSettingCell";
        [items addObject:item];
        TSWithdrawalPswSetSectionModel *section = [[TSWithdrawalPswSetSectionModel alloc] init];
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
