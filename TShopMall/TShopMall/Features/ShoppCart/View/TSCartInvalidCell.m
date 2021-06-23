//
//  TSCartInvalidCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartInvalidCell.h"

@interface TSCartInvalidCell()
@property (nonatomic, strong) TSCartInvalideGoodView *goodView;
@end

@implementation TSCartInvalidCell

- (void)setObj:(id)obj{
    [self.goodView updateUIWithCart:(TSCart *)obj];
}

- (void)layoutView{
    [self.goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(KRateW(114.0));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (TSCartInvalideGoodView *)goodView{
    if (_goodView) {
        return _goodView;
    }
    self.goodView = [TSCartInvalideGoodView new];
    [self.goodView performSelector:@selector(testUI)];
    [self.contentView addSubview:self.goodView];
    
    return self.goodView;
}

@end


@implementation TSCartInvalidTaoCanCell

- (void)testUI{
    self.tips.text = @"失效";
    self.taocanName.text = @"套装名称标标题标题标题标题…";
    for (NSInteger i=0; i<3; i++) {
        TSCartInvalideGoodView *goodView = [TSCartInvalideGoodView new];
        goodView.isTaoCan = YES;
        [goodView performSelector:@selector(testUI)];
        goodView.tips.hidden = YES;
        [self.contentView addSubview:goodView];
        [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.taocanName.mas_bottom).offset(KRateW(7.0) + KRateW(114.0) * i);
            make.height.mas_equalTo(KRateW(114.0));
            if (i ==2) {
                make.bottom.equalTo(self.contentView.mas_bottom);
            }
        }];
    }
}

- (void)layoutView{
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(12.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(18.0));
        make.width.mas_equalTo(KRateW(32.0));
        make.height.mas_equalTo(KRateW(16.0));
    }];
    
    [self.taocanName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tips.mas_right).offset(KRateW(6.0));
        make.centerY.equalTo(self.tips);
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.height.mas_equalTo(KRateW(22.0));
    }];
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    self.tips.backgroundColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.4];
    self.tips.textAlignment = NSTextAlignmentCenter;
    self.tips.font = KRegularFont(10.0);
    self.tips.textColor = KHexColor(@"#FFFFFF");
    [self.contentView addSubview:self.tips];
    
    return self.tips;
}

- (UILabel *)taocanName{
    if (_taocanName) {
        return _taocanName;
    }
    self.taocanName = [UILabel new];
    self.taocanName.font = KRegularFont(14.0);
    self.taocanName.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.taocanName];
    
    return self.taocanName;
}
@end



@implementation TSCartInvalideGoodView


- (void)updateUIWithCart:(TSCart *)cart{
    self.tips.text = @"失效";
    [self.icon sd_setImageWithURL:[NSURL URLWithString:cart.productImgUrl]];
    self.name.text = cart.productName;
    self.mark.text = cart.invalidReson;
}

- (void)layoutSubviews{
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(12.0));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(KRateW(32.0));
        make.height.mas_equalTo(KRateW(16.0));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tips.mas_right).offset(KRateW(12.0));
        make.width.height.mas_equalTo(KRateW(88.0));
        make.top.equalTo(self.mas_top).offset(KRateW(15.0));
//        make.bottom.equalTo(self.mas_bottom).offset(-KRateW(11.0));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(KRateW(16.0));
        make.top.equalTo(self.icon.mas_top);
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
    }];
    
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.bottom.equalTo(self.icon.mas_bottom).offset(-KRateW(6.0));
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.isTaoCan == YES) {
            make.left.equalTo(self.name.mas_left);
            make.right.equalTo(self.mas_right);
        } else {
            make.left.equalTo(self.mas_left).offset(KRateW(16.0));
            make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        }
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    self.tips.backgroundColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.4];
    self.tips.textAlignment = NSTextAlignmentCenter;
    self.tips.font = KRegularFont(10.0);
    self.tips.textColor = KHexColor(@"#FFFFFF");
    [self addSubview:self.tips];
    
    return self.tips;
}

- (UIImageView *)icon{
    if (_icon) {
        return _icon;
    }
    self.icon = [UIImageView new];
    [self addSubview:self.icon];
    
    return self.icon;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.numberOfLines = 2;
    self.name.font = KFont(PingFangSCRegular, 14.0);
    self.name.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.4];
    [self addSubview:self.name];
    
    return self.name;
}

- (UILabel *)mark{
    if (_mark) {
        return _mark;
    }
    self.mark = [UILabel new];
    self.mark.font = KRegularFont(14.0);
    self.mark.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.mark];
    
    return self.mark;
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self addSubview:self.line];
    
    return self.line;
}

@end
