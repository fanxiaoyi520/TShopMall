//
//  TSMakeOrderGoodsCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderGoodsCell.h"
#import "TSCartCell.h"
#import "TSMakeOrderGoodsViewModel.h"

@interface TSMakeOrderGoodsCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *specification;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *num;
@property (nonatomic, strong) TSCartGiftButton *giftBtn;
@property (nonatomic, strong) UIView *line;
@end

@implementation TSMakeOrderGoodsCell


- (void)setObj:(id)obj{
    if ([obj isKindOfClass:[TSMakeOrderGoodsViewModel class]]) {
        TSMakeOrderGoodsViewModel *vm = (TSMakeOrderGoodsViewModel *)obj;
        [self.icon  sd_setImageWithURL:[NSURL URLWithString:vm.productImgUrl]];
        self.name.text = vm.productName;
        self.specification.text = vm.attr;
        self.price.text = [@"¥ " stringByAppendingString:vm.price];
        self.num.text = [NSString stringWithFormat:@"x%ld", vm.buyNum];
    }
}

- (void)configUI{
//    self.icon.image = KImageMake(@"image_test");
//    self.name.text = @"XESS 65寸 家庭浮窗场景TV标题标题 标题踢踢踢标题踢踢踢标…";
//    self.specification.text = @"已选规格";
//    self.price.text = @"¥ 4999";
//    self.num.text = @"x1";
    
//    [self configGiftView];
}

- (void)configGiftView{
        self.giftBtn.hidden = NO;
        self.giftBtn.tips.text = @"赠品: ";
        self.giftBtn.img.image = KImageMake(@"image_test");
        self.giftBtn.name.text = @"产品信息和标题标题产品信息和标题标题…";
        self.giftBtn.indeImg.image = KImageMake(@"inde_right_small");

    [self.giftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(KRateW(20.0));
    }];
}


- (void)layoutView{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.width.height.mas_equalTo(KRateW(88.0)).priorityHigh();
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.icon.mas_top);
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(KRateW(16.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.right.equalTo(self.price.mas_left).offset(-KRateW(16.0)).priorityHigh();
    }];
    
    [self.specification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.height.mas_equalTo(KRateW(18.0));
        make.bottom.mas_equalTo(self.icon.mas_bottom).offset(-KRateW(18.0));
    }];
    
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.specification);
        make.right.equalTo(self.price.mas_right);
    }];
    
    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.price.mas_right);
        make.left.equalTo(self.name.mas_left);
        make.top.mas_equalTo(self.specification.mas_bottom).offset(KRateW(26.0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(16.0)).priorityHigh();
        make.height.mas_equalTo(0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (UIImageView *)icon{
    if (_icon) {
        return _icon;
    }
    self.icon = [UIImageView new];
    [self.contentView addSubview:self.icon];
    
    return self.icon;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.numberOfLines = 2;
    self.name.font = KFont(PingFangSCRegular, 14.0);
    self.name.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.name];
    
    return self.name;
}

- (UILabel *)specification{
    if (_specification) {
        return _specification;
    }
    self.specification = [UILabel new];
    self.specification.font = KFont(PingFangSCRegular, 12.0);
    self.specification.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
    [self.contentView addSubview:self.specification];
    
    return self.specification;
}

- (UILabel *)num{
    if (_num) {
        return _num;
    }
    self.num = [UILabel new];
    self.num.font = KFont(PingFangSCMedium, 16.0);
    self.num.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.num];
    
    return self.num;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.font = KFont(PingFangSCMedium,14.0);
    self.price.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.price];
    
    return self.price;
}

- (TSCartGiftButton *)giftBtn{
    if (_giftBtn) {
        return _giftBtn;
    }
    self.giftBtn = [TSCartGiftButton new];
//    [self.giftBtn addTarget:self action:@selector(checkGift) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.giftBtn];
    
    return self.giftBtn;
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
