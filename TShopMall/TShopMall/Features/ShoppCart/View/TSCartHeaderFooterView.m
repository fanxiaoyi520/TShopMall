//
//  TSCartHeaderFooterView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartHeaderFooterView.h"

@implementation TSCartHeaderFooterView
@end


@implementation TSCartInvalidHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self layoutView];
    }
    return self;
}

- (void)layoutView{
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(self.title);
        make.width.mas_equalTo(KRateW(36));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.33);
    }];
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"已失效商品";
    self.title.font = KFont(PingFangSCRegular, 14.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.title];
    
    return self.title;
}

- (UIButton *)clear{
    if (_clear) {
        return _clear;
    }
    self.clear = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clear setTitle:@"清空" forState:UIControlStateNormal];
    self.clear.titleLabel.font = KRegularFont(14.0);
    [self.clear setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    [self.contentView addSubview:self.clear];
    
    return self.clear;
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self.contentView addSubview:self.line];
    
    return self.line;
}
@end


@implementation TSCartRecomendHeader

- (void)layoutSubviews{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(KRateW(24.0));
    }];
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"热销推荐";
    self.title.font = KFont(PingFangSCRegular, 16.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.title];
    
    return self.title;
}
@end
