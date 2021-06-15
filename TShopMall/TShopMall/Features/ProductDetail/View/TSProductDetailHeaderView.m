//
//  TSProductDetailHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailHeaderView.h"

@interface TSProductDetailHeaderView()

@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation TSProductDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(56);
    }];
}

#pragma mark - Getter
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = KRegularFont(14);
        _nameLabel.textColor = KTextColor;
        _nameLabel.text = @"商品详情";
    }
    return _nameLabel;
}

@end
