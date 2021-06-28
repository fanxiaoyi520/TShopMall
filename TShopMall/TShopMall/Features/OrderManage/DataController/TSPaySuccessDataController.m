//
//  TSPaySuccessDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/24.
//

#import "TSPaySuccessDataController.h"
#import "TSProductBaseModel.h"


@interface TSPaySuccessDataController ()
/** sections  */
@property(nonatomic, strong) NSMutableArray<TSPaySuccessSectionModel *> *sections;

@end

@implementation TSPaySuccessDataController


- (void)fetchPaySuccessComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSPaySuccessSectionItemModel *item = [[TSPaySuccessSectionItemModel alloc] init];
        item.cellHeight = GK_STATUSBAR_NAVBAR_HEIGHT + 244;
        item.identify = @"TSPaySuccessCell";
        [items addObject:item];
        TSPaySuccessSectionModel *section = [[TSPaySuccessSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];

        for (int i = 0; i < 10; i++) {
            TSProductBaseModel *item = [[TSProductBaseModel alloc] init];
            item.cellHeight = 282;
            item.identify = @"TSHomePageContainerCollectionViewCell";

            [items addObject:item];
        }
        TSPaySuccessSectionModel *section = [[TSPaySuccessSectionModel alloc] init];
        section.column = 2;
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.lineSpacing = 8;
        section.interitemSpacing = 8;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

@end
