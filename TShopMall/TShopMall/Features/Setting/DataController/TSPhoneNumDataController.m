//
//  TSPhoneNumDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSPhoneNumDataController.h"

@interface TSPhoneNumDataController ()

@property (nonatomic, strong) NSMutableArray <TSPhoneNumSectionModel *> *sections;

@end

@implementation TSPhoneNumDataController

- (void)fetchPhoneNumContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSPhoneNumSectionItemModel *item = [[TSPhoneNumSectionItemModel alloc] init];
        item.phoneNum = @"133-7869-2380";
        item.cellHeight = kScreenHeight;
        item.identify = @"TSPhoneNumVeriCell";
        [items addObject:item];
        TSPhoneNumSectionModel *section = [[TSPhoneNumSectionModel alloc] init];
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
