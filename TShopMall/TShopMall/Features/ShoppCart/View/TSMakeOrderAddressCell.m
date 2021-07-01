//
//  TSMakeOrderAddressCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderAddressCell.h"
#import "TSAddressModel.h"

@interface TSMakeOrderAddressCell()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UILabel *address;
@end

@implementation TSMakeOrderAddressCell

- (void)setObj:(id)obj{
    if ([obj isKindOfClass:[TSAddressModel class]]) {
        TSAddressModel *address = (TSAddressModel *)obj;
        self.name.text = address.consignee;
        self.phone.text = [self securtyPhone:address.mobile];
        self.address.text = [NSString stringWithFormat:@"%@%@", address.area, address.address];
    }
}

- (NSString *)securtyPhone:(NSString *)phone{
    if (phone.length < 7) {
        return phone;
    }
    NSRange range = NSMakeRange(3, 4);
    return [phone stringByReplacingCharactersInRange:range withString:@"****"];
}

- (void)layoutView{
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.height.mas_equalTo(KRateW(24.0));
        make.width.mas_lessThanOrEqualTo(KRateW(96.0));
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(KRateW(16.0));
        make.top.bottom.equalTo(self.name);
    }];
    
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.name);
        make.width.height.mas_equalTo(KRateW(16.0));
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.right.equalTo(self.indeImg.mas_left);
        make.top.equalTo(self.name.mas_bottom).offset(KRateW(8.0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(16.0));
    }];
}



- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.font = KFont(PingFangSCMedium, 16.0);
    self.name.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.name];
    
    return self.name;
}

- (UILabel *)phone{
    if (_phone) {
        return _phone;
    }
    self.phone = [UILabel new];
    self.phone.font = KFont(PingFangSCMedium, 16.0);
    self.phone.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.phone];
    
    return self.phone;
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    self.indeImg.image = KImageMake(@"inde_right_small");
    [self.contentView addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UILabel *)address{
    if (_address) {
        return _address;
    }
    self.address = [UILabel new];
    self.address.font = KRegularFont(14.0);
    self.address.textColor = KHexColor(@"#2D3132");
    self.address.numberOfLines = 2;
    [self.contentView addSubview:self.address];
    
    return self.address;
}
@end

@implementation TSMakeOrderAddressTipsCell

- (void)layoutSubviews{
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(KRateW(16.0));
    }];
    
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.contentView);
//        make.height.mas_equalTo(1);
//    }];
    
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    self.tips.text = @"请添加收货地址";
    self.tips.font = KRegularFont(16.0);
    self.tips.textColor = KHexColor(@"#333333");
    [self.contentView addSubview:self.tips];
    
    return self.tips;
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    self.indeImg.image = KImageMake(@"inde_right_small");
    [self.contentView addSubview:self.indeImg];
    
    return self.indeImg;
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
