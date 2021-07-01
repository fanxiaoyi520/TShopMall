//
//  TSAccountCancelController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSAccountCancelDataController.h"

@interface TSAccountCancelDataController ()

@property (nonatomic, strong) NSMutableArray <TSAccountCancelSectionModel *> *sections;

@end

@implementation TSAccountCancelDataController

- (void)fetchContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.title = @"账号注销后，将放弃以下资产和权益";
        item.cellHeight = 148;
        item.identify = @"TSAccountCancelTopCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.content = @"1、身份、账号信息、会员权益将清空且无法恢复 \n2、交易记录将被清空 \n    ·请确保所有交易已完结且无纠纷 \n    ·账号删除后历史交易可能产生的资金退回权益等视为自动放弃\n3、您购买的会员影视服务、上门服务、售后维修等将被视作放弃 \n4、您的物联网设备将自动解绑，无法通过本账号进行操控和使用\n5、您的物联网设备场景设置将自动删除，无法通过本账号进行设备场景的智能操控";
        item.cellHeight = 300;//[item.content heightForFont:KRegularFont(12) width:kScreenWidth - 50];
        item.identify = @"TSAccountCancelContentCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight - 448 - KNaviBarHeight - 50;
        item.identify = @"TSAccountCancelBottomCell";
        item.nextTitle = @"确认，进入下一步";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}


- (void)fetchCancelNextContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.title = @"请确定是否进行账号注销";
        item.cellHeight = 148;
        item.identify = @"TSAccountCancelTopCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.content = @"1、本次账号注销申请是本账号所有人进行操作，若产生的纠纷均为本账号所有人承担\n2、本次账号注销所会影响的情况和范围，本账号所有人已经知悉\n3、本次账号注销后，会在15个工作日内进行相关数据的信息删除\n4、账号注销在15个工作日完成后，可使用本账号再次进行账号注册";
        item.cellHeight = 300;//[item.content heightForFont:KRegularFont(12) width:kScreenWidth - 50];
        item.identify = @"TSAccountCancelContentCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight - 448 - KNaviBarHeight - 50;
        item.identify = @"TSAccountCancelBottomCell";
        item.nextTitle = @"确认注销";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

- (void)fetchCancelLastConfirmContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.title = @"将放弃以下资产和权益";
        item.nickname = @"昵称昵称昵称昵称昵称昵称昵称";
        item.cellHeight = 178;
        item.identify = @"TSAccountCancelTopCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.content = @"1、身份、账号信息、会员权益将清空且无法恢复 \n2、交易记录将被清空 \n    ·请确保所有交易已完结且无纠纷 \n    ·账号删除后历史交易可能产生的资金退回权益等视为自动放弃\n3、您购买的会员影视服务、上门服务、售后维修等将被视作放弃 \n4、您的物联网设备将自动解绑，无法通过本账号进行操控和使用\n5、您的物联网设备场景设置将自动删除，无法通过本账号进行设备场景的智能操控";
        item.cellHeight = 300;//[item.content heightForFont:KRegularFont(12) width:kScreenWidth - 50];
        item.identify = @"TSAccountCancelContentCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight - 478 - KNaviBarHeight - 50;
        item.identify = @"TSCommitCell";
        item.title = @"确认";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

- (void)fetchDropConfirmContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.title = @"将放弃以下资产和权益";
        item.nickname = @"昵称昵称昵称昵称昵称昵称昵称";
        item.cellHeight = 178;
        item.identify = @"TSAccountCancelTopCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.content = @"1、身份、账号信息、会员权益将清空且无法恢复 \n2、交易记录将被清空 \n    ·请确保所有交易已完结且无纠纷 \n    ·账号删除后历史交易可能产生的资金退回权益等视为自动放弃\n3、您购买的会员影视服务、上门服务、售后维修等将被视作放弃 \n4、您的物联网设备将自动解绑，无法通过本账号进行操控和使用\n5、您的物联网设备场景设置将自动删除，无法通过本账号进行设备场景的智能操控";
        item.cellHeight = 300;//[item.content heightForFont:KRegularFont(12) width:kScreenWidth - 50];
        item.identify = @"TSAccountCancelContentCell";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAccountCancelSectionItemModel *item = [[TSAccountCancelSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight - 478 - KNaviBarHeight - 50;
        item.identify = @"TSCommitCell";
        item.title = @"取消";
        [items addObject:item];
        TSAccountCancelSectionModel *section = [[TSAccountCancelSectionModel alloc] init];
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
