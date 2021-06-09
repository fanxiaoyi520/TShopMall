//
//  TSCartBaseCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartBaseCell.h"

@implementation TSCartBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self layoutView];
        [self testUI];
    }
    return self;
}

- (void)layoutView{};
- (void)testUI{};

@end
