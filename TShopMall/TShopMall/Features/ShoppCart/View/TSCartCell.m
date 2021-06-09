//
//  TSCartCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import "TSCartCell.h"

@interface TSCartGiftButton : UIButton
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *indeImg;
@end

@interface TSCartCell()
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *specification;
@property (nonatomic, strong) UILabel *priceTitle;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIView *numView;
@property (nonatomic, strong) TSCartGiftButton *giftBtn;
@end

@implementation TSCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self layoutView];
        [self testUI];
    }
    return self;
}

- (void)testUI{
    self.selBtn.selected = NO;
    self.icon.image = KImageMake(@"image_test");
    self.name.text = @"XESS 65寸 家庭浮窗场景TV标题标题 标题踢踢踢标题踢踢踢标…";
    self.specification.text = @"已选规格";
    self.numView.hidden  = NO;
    self.priceTitle.text = @"提货价";
    self.price.text = @"¥ 4999";
    
    self.giftBtn.tips.text = @"赠品: ";
    self.giftBtn.img.image = KImageMake(@"image_test");
    self.giftBtn.name.text = @"产品信息和标题标题产品信息和标题标题…";
    self.giftBtn.indeImg.image = KImageMake(@"inde_right_small");
}

- (void)layoutView{
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(50.0));
        make.width.height.mas_equalTo(KRateW(20.0));
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(14.0));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selBtn.mas_right).offset(KRateW(22.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.width.height.mas_equalTo(KRateW(88.0)).priorityHigh();
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(KRateW(8.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
    }];
    
    [self.specification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.name.mas_bottom).offset(KRateW(4.0));
        make.height.mas_equalTo(KRateW(18.0));
    }];
    
    [self.priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.centerY.equalTo(self.icon.mas_bottom);
        make.height.mas_equalTo(KRateW(18.0));
    }];
    
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.name.mas_right);
        make.centerY.equalTo(self.priceTitle);
        make.height.mas_equalTo(KRateW(18.0));
        make.width.mas_equalTo(KRateW(58.0));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceTitle.mas_right).offset(KRateW(3.0)).priorityHigh();
        make.right.equalTo(self.numView.mas_left).offset(-KRateW(8.0));
        make.centerY.equalTo(self.priceTitle);
        make.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.name.mas_right);
        make.height.mas_equalTo(KRateW(20.0));
        make.left.equalTo(self.name.mas_left);
        make.top.mas_equalTo(self.price.mas_bottom).offset(KRateW(16.0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(16.0));
    }];
}

- (UIButton *)selBtn{
    if (_selBtn) {
        return _selBtn;
    }
    self.selBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_normal") forState:UIControlStateNormal];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_sel") forState:UIControlStateSelected];
    [self.contentView addSubview:self.selBtn];
    
    return self.selBtn;
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

- (UILabel *)priceTitle{
    if (_priceTitle) {
        return _priceTitle;
    }
    self.priceTitle = [UILabel new];
    self.priceTitle.font = KFont(PingFangSCRegular, 12.0);
    self.priceTitle.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
    [self.contentView addSubview:self.priceTitle];
    
    return self.priceTitle;
}

- (UIView *)numView{
    if (_numView) {
        return _numView;
    }
    self.numView = [UIView new];
    self.numView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.numView];
    
    return self.numView;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.font = KFont(PingFangSCMedium,16.0);
    self.price.textColor = KHexColor(@"#E64C3D");
    [self.contentView addSubview:self.price];
    
    return self.price;
}

- (TSCartGiftButton *)giftBtn{
    if (_giftBtn) {
        return _giftBtn;
    }
    self.giftBtn = [TSCartGiftButton new];
    [self.contentView addSubview:self.giftBtn];
    
    return self.giftBtn;
}

@end

@implementation TSCartGiftButton

- (void)layoutSubviews{
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(KRateW(12.0));
    }];
    
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(KRateW(36.0));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tips.mas_right).offset(KRateW(3.0));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(KRateW(20.0));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(KRateW(6.0));
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.indeImg.mas_left).offset(-KRateW(6.0));
    }];
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    [self.tips setTextColor:KHexColor(@"#2D3132")];
    self.tips.font = KFont(PingFangSCRegular, 12.0);
    [self addSubview:self.tips];
    
    return self.tips;
}

- (UIImageView *)img{
    if (_img) {
        return _img;
    }
    self.img = [UIImageView new];
    [self addSubview:self.img];
    
    return self.img;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.textColor = KHexColor(@"#2D3132");
    self.name.font = KFont(PingFangSCRegular, 12.0);
    [self addSubview:self.name];
    
    return self.name;
}
@end
