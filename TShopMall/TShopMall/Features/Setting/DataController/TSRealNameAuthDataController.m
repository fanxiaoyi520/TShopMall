//
//  TSRealNameAuthDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSRealNameAuthDataController.h"


@interface TSRealNameAuthDataController ()
/** sections  */
@property(nonatomic, strong) NSMutableArray<TSRealNameAuthSectionModel *> *sections;

@end

@implementation TSRealNameAuthDataController

- (void)fetchRealNameAuthContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSRealNameAuthSectionItemModel *item = [[TSRealNameAuthSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.identify = @"TSRealNameAuthCell";
        [items addObject:item];
        TSRealNameAuthSectionModel *section = [[TSRealNameAuthSectionModel alloc] init];
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
    
}

@end
