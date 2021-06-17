//
//  TSProductDetailHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailHeaderView.h"

@interface TSProductDetailHeaderView()

/// 分割线1
@property(nonatomic, strong) UIView *seperateOne;
/// 名字
@property(nonatomic, strong) UILabel *nameLabel;
/// 分割线2
@property(nonatomic, strong) UIView *seperateTwo;

@end

@implementation TSProductDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.seperateOne];
    [self addSubview:self.nameLabel];
    [self addSubview:self.seperateTwo];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(56);
    }];
    
    [self.seperateOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nameLabel.mas_left).offset(-8);
        make.centerY.equalTo(self.nameLabel);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(36);
    }];
    
    [self.seperateTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
        make.centerY.equalTo(self.nameLabel);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(36);
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

-(UIView *)seperateOne{
    if (!_seperateOne) {
        _seperateOne = [[UIView alloc] init];
        _seperateOne.backgroundColor = KlineColor;
    }
    return _seperateOne;
}

-(UIView *)seperateTwo{
    if (!_seperateTwo) {
        _seperateTwo = [[UIView alloc] init];
        _seperateTwo.backgroundColor = KlineColor;
    }
    return _seperateTwo;
}

@end
