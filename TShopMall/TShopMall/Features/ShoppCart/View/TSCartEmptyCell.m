//
//  TSCartEmptyCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/10.
//

#import "TSCartEmptyCell.h"
#import "TSEmptyAlertView.h"

@implementation TSCartEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        TSEmptyAlertView.new.alertBackColor(KHexColor(@"#F4F4F5")).alertInfo(@"购物车是空的", @"去购物").show(self.contentView, @"center", ^{
            [self.delegate goToShopping];
        });
    }
    return self;
}

@end
