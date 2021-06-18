//
//  TSMakeOrderBaseCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSMakeOrderBaseCell.h"

@implementation TSMakeOrderBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self layoutView];
        [self configUI];
    }
    return self;
}

- (void)layoutView{};
- (void)configUI{};

@end
