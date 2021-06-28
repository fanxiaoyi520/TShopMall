//
//  TSPayChannelItem.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPayChannelItem.h"

@interface TSPayChannelItem()
@property (nonatomic, strong) UIImageView *payImg;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *selIndeImg;
@end

@implementation TSPayChannelItem

- (instancetype)init{
    if (self == [super init]) {
        self.selected = NO;
    }
    return self;
}

- (void)setModel:(TSPayStyleModel *)model{
    _model = model;
    [self.payImg sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.name.text = model.channelName;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.selIndeImg.image = KImageMake(@"btn_sel");
    } else {
        self.selIndeImg.image = KImageMake(@"btn_normal");
    }
}

- (void)layoutSubviews{
    [self.payImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(30.0));
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payImg.mas_right).offset(KRateW(10.0));
        make.centerY.equalTo(self);
        make.height.mas_equalTo(KRateW(18.0));
    }];
    
    [self.selIndeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(30.0));
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(KRateW(20.0));
    }];
}

- (UIImageView *)payImg{
    if (_payImg) {
        return _payImg;
    }
    self.payImg = [UIImageView new];
    self.payImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.payImg];
    
    return self.payImg;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.font = KRegularFont(14.0);
    self.name.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.name];
    
    return self.name;
}

- (UIImageView *)selIndeImg{
    if (_selIndeImg) {
        return _selIndeImg;
    }
    self.selIndeImg = [UIImageView new];
    [self addSubview:self.selIndeImg];
    
    return self.selIndeImg;
}

@end
