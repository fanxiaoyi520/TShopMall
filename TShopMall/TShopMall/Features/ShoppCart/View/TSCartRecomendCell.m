//
//  TSCartRecomendCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartRecomendCell.h"

@interface TSCartRecomendCell()
@property (nonatomic, strong) TSCartRecomendView *leftView;
@property (nonatomic, strong) TSCartRecomendView *rightView;
@end

@implementation TSCartRecomendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#F4F4F4");
    }
    return self;
}

- (void)layoutSubviews{
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo((kScreenWidth - KRateW(16.0 * 2 + 8.0))/2.0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(8.0));
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.leftView.mas_right).offset(KRateW(8.0));
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.top.bottom.equalTo(self.leftView);
        make.width.equalTo(self.leftView.mas_width);
    }];
}

- (TSCartRecomendView *)leftView{
    if (_leftView) {
        return _leftView;
    }
    self.leftView = [TSCartRecomendView new];
    [self.leftView performSelector:@selector(testUI)];
    [self.contentView addSubview:self.leftView];
    
    return self.leftView;
}

- (TSCartRecomendView *)rightView{
    if (_rightView) {
        return _rightView;
    }
    self.rightView = [TSCartRecomendView new];
    [self.rightView performSelector:@selector(testUI)];
    [self.contentView addSubview:self.rightView];
    
    return self.rightView;
}

@end

@implementation TSCartRecomendView

- (instancetype)init{
    if (self == [super init]) {
        [self layoutView];
    }
    return self;
}

- (void)testUI{
    self.backgroundColor = [UIColor whiteColor];
    self.icon.image = KImageMake(@"");
    self.icon.backgroundColor = UIColor.cyanColor;
    self.name.text = @"XESS  55寸艺术电55寸艺术电55寸艺术…";
    self.price.text = @"¥ 18990";
    self.thPrice.text = @"提货价: ¥29999";
}

- (void)layoutView{
    self.layer.cornerRadius = KRateW(8.0);
    self.layer.masksToBounds = YES;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(self.mas_width);
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

@end
