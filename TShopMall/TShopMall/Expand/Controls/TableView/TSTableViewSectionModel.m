//
//  TSTableViewSectionModel.m
//  TShopMall
//
//  Created by sway on 2021/6/12.
//

#import "TSTableViewSectionModel.h"

@implementation TSTableViewSectionModel
-(instancetype)initWithRowData:(NSArray *)datas {
    if (self = [super init]) {
        self.rowDatas = datas;
    }
    return self;
}
@end
