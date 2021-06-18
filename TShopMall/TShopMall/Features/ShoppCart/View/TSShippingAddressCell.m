//
//  TSShippingAddressCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSShippingAddressCell.h"

@interface TSShippingAddressCell()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *mark;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UIView *line;
@end

@implementation TSShippingAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
            
        [self layoutView];
        [self configUI];
    }
    return self;
}

- (void)setAddressStr:(NSString *)addressStr{
    self.address.text = addressStr;
}

- (void)editBtnAction{
    self.addressEdit(self.addressModel);
}

- (void)configUI{
    self.name.text = @"张小四的啊啊啊";
    self.phone.text = @"136****2380";
    self.address.text = @"广东省深圳市南山区西丽街道TCL国际e城808有多的就两行";
}

- (void)layoutView{
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(40.0));
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.width.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(KRateW(8.0));
        make.top.bottom.equalTo(self.name);
    }];
    
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phone.mas_right).offset(KRateW(8.0));
        make.height.mas_equalTo(KRateW(16.0));
        make.centerY.equalTo(self.name);
        make.width.mas_equalTo(KRateW(30.0));
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(90.0));
        make.top.equalTo(self.name.mas_bottom).offset(KRateW(10.0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(16.0)).priorityHigh();
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(0.33));
    }];
}

- (UIButton *)editBtn{
    if (_editBtn) {
        return _editBtn;
    }
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setBackgroundImage:KImageMake(@"cart_address_edit") forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.editBtn];
    
    return self.editBtn;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.font = KRegularFont(16.0);
    self.name.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.name];
    
    return self.name;
}

- (UILabel *)phone{
    if (_phone) {
        return _phone;
    }
    self.phone = [UILabel new];
    self.phone.font = KRegularFont(16.0);
    self.phone.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.phone];
    
    return self.phone;
}

- (UILabel *)mark{
    if (_mark) {
        return _mark;
    }
    self.mark = [UILabel new];
    self.mark.text = @"默认";
    self.mark.backgroundColor = KHexColor(@"#FF4D49");
    self.mark.textColor = UIColor.whiteColor;
    self.mark.font = KRegularFont(9.0);
    self.mark.textAlignment = NSTextAlignmentCenter;
    self.mark.layer.cornerRadius = KRateW(8.0);
    self.mark.layer.masksToBounds = YES;
    [self.contentView addSubview:self.mark];
    
    return self.mark;
}

- (UILabel *)address{
    if (_address) {
        return _address;
    }
    self.address = [UILabel new];
    self.address.font = KRegularFont(14.0);
    self.address.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
    self.address.numberOfLines = 0;
    [self.contentView addSubview:self.address];
    
    return self.address;
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
