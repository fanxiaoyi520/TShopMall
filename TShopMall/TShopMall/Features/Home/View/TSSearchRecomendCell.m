//
//  TSSearchRecomendCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSSearchRecomendCell.h"
#import "TSEarnView.h"

@interface TSSearchRecomendCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) TSEarnView *earnView;
@property (nonatomic, strong) UILabel *thPrice;
@property (nonatomic, strong) UIView *line;
@end

@implementation TSSearchRecomendCell

- (void)setObj:(id)obj{
    [self testUI];
}

- (void)testUI{
    self.icon.backgroundColor = UIColor.cyanColor;
    self.name.text = @"XESS 65寸 家庭浮窗场景TV标题TV标题TV标题TV标题TV标题";
    self.thPrice.text = [NSString stringWithFormat:@"提货价: ¥%@", @"23990"];
    self.price.text = @"¥ 18900";
    [self.earnView updatePrice:@"19999"];
}


- (void)layoutView{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.height.mas_equalTo(KRateW(120.0)).priorityHigh();
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-KRateW(239 - 16));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(KRateW(8.0));
        make.width.mas_equalTo(KRateW(215.0));
        make.right.mas_equalTo(self.contentView.mas_right).priorityHigh();
        make.top.equalTo(self.icon.mas_top).offset(KRateW(11.0));
    }];
    
    [self.thPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.bottom.equalTo(self.icon.mas_bottom).offset(-KRateW(11.0));
        make.height.mas_equalTo(KRateW(16.0));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.thPrice.mas_top);
        make.height.mas_equalTo(KRateW(30.0));
        make.left.equalTo(self.name.mas_left);
    }];
    
    [self.earnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.price.mas_right).offset(KRateW(14.0));
        make.centerY.equalTo(self.price);
        make.height.mas_equalTo(KRateW(18.0));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.icon.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

- (UIImageView *)icon{
    if (_icon) {
        return _icon;
    }
    self.icon = [UIImageView new];
    self.icon.contentMode  = UIViewContentModeScaleAspectFit;
    self.icon.layer.cornerRadius = KRateW(8.0);
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    
    return self.icon;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.font = KRegularFont(14.0);
    self.name.textColor = KHexColor(@"#2D3132");
    self.name.numberOfLines = 2;
    [self.contentView addSubview:self.name];
    
    return self.name;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.textColor = KMainColor;
    self.price.font = KFont(PingFangSCMedium, 20.0);
    [self.contentView addSubview:self.price];
    
    return self.price;
}

- (TSEarnView *)earnView{
    if (_earnView) {
        return _earnView;
    }
    self.earnView = [TSEarnView new];
    [self.contentView addSubview:self.earnView];
    
    return self.earnView;
}

- (UILabel *)thPrice{
    if (_thPrice) {
        return _thPrice;
    }
    self.thPrice = [UILabel new];
    self.thPrice.font = KRegularFont(8.0);
    self.thPrice.textColor = KHexAlphaColor(@"#333333", 0.6);
    [self.contentView addSubview:self.thPrice];
    
    return self.thPrice;
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UILabel new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self.contentView addSubview:self.line];
    
    return self.line;
}

@end
