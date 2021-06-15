//
//  TSGoodsListCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSGoodsListCell.h"
#import "TSEarnView.h"

@interface TSGoodsListCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *thPrice;
@property (nonatomic, strong) TSEarnView *earnView;
@end

@implementation TSGoodsListCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self layoutView];
    }
    return self;
}

- (void)setObj:(id)obj{
    [self testUI];
}

- (void)setFrame:(CGRect)frame{
    CGRect aFrame = frame;
    aFrame.size.height = frame.size.height - KRateW(8.0);
    
    [super setFrame:aFrame];
}

- (void)testUI{
    self.backgroundColor = [UIColor whiteColor];
    self.icon.image = KImageMake(@"");
    self.icon.backgroundColor = UIColor.cyanColor;
    self.name.text = @"XESS  55寸艺术电55寸艺术电55寸艺术…";
    self.price.text = @"¥ 18990";
    self.thPrice.text = @"提货价: ¥29999";
    [self.earnView updatePrice:@"1999"];
}

- (void)layoutView{
    self.layer.cornerRadius = KRateW(8.0);
    self.layer.masksToBounds = YES;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(KRateW(168.0));
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(KRateW(8.0));
        make.left.equalTo(self.mas_left).offset(KRateW(8.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(8.0));
        make.height.mas_lessThanOrEqualTo(KRateW(44.0));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(8.0));
        make.top.equalTo(self.icon.mas_bottom).offset(KRateW(60.0)).priorityHigh();
        make.height.mas_equalTo(KRateW(30.0));
        make.right.mas_equalTo(self.mas_centerX);
    }];
    
    [self.thPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.top.equalTo(self.price.mas_bottom).offset(KRateW(0));
        make.height.mas_equalTo(KRateW(16.0));
        make.bottom.equalTo(self.mas_bottom).offset(-KRateW(8.0));
    }];
    
    [self.earnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.name.mas_right);
        make.centerY.equalTo(self.price);
        make.height.mas_equalTo(KRateW(18.0));
    }];
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
    self.name.font = KRegularFont(14.0);
    self.name.textColor = KHexColor(@"#2D3132");
    self.name.numberOfLines = 2;
    [self addSubview:self.name];
    
    return self.name;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.font = KRegularFont(20.0);
    self.price.textColor = KHexColor(@"#E64C3D");
    [self addSubview:self.price];
    
    return self.price;
}

- (UILabel *)thPrice{
    if (_thPrice) {
        return _thPrice;
    }
    self.thPrice = [UILabel new];
    self.thPrice.font = KRegularFont(8.0);
    self.thPrice.textColor = KHexColor(@"#333333");
    [self addSubview:self.thPrice];
    
    return self.thPrice;
}

- (TSEarnView *)earnView{
    if (_earnView) {
        return _earnView;
    }
    self.earnView = [TSEarnView new];
    [self addSubview:self.earnView];
    
    return self.earnView;
}
@end


@implementation TSGoodsListRailCell

- (void)layoutView{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.height.mas_equalTo(KRateW(120.0)).priorityHigh();
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
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
