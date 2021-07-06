//
//  TSHotGoodsHeaderView.m
//  TShopMall
//
//  Created by oneyian on 2021/7/5.
//

#import "TSHotGoodsHeaderView.h"

@implementation TSHotGoodsHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KGrayColor;
        
        _title_label = [UILabel new];
        _title_label.textColor = KBlackColor;
        _title_label.textAlignment = NSTextAlignmentCenter;
        _title_label.font = KRegularFont(16);
        [self addSubview:_title_label];
        
        [_title_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
