//
//  TSCartGoodsSection.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartGoodsSection.h"

@implementation TSCartGoodsSection
- (instancetype)init{
    if (self == [super init]) {
        self.heightForFooter = 0.1f;
        self.heightForHeader = 0.1;
        self.headerIdentifier = @"UITableViewHeaderFooterView";
        self.footerIdentifier = @"UITableViewHeaderFooterView";
    }
    return self;
}
@end

@implementation TSCartGoodsRow

- (instancetype)init{
    if (self == [super init]) {
        self.cellIdentifier = @"UITableViewCell";
        self.isAutoHeight = YES;
    }
    return self;
}


- (CGFloat)rowHeight{
    if (_isAutoHeight == NO) {
        return _rowHeight;
    }
    return UITableViewAutomaticDimension;
}
@end
