//
//  TSEarnView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSEarnView.h"

@interface TSEarnView()
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIView *tipsBg;
@property (nonatomic, strong) UILabel *tips;
@end

@implementation TSEarnView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = KHexColor(@"#FF4D49");
        self.layer.cornerRadius = 2.0;
        self.layer.masksToBounds = YES;
        [self  layoutView];
    }
    return self;
}

- (void)updatePrice:(NSString *)price{
    price = [NSString stringWithFormat:@"¥ %@", price];
    self.price.text = price;
    self.tips.text = @"最高赚";
    
    CGFloat width = [price widthForFont:KRegularFont(9.0)];
    [self.tips mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    [self.tipsBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width + KRateW(10.0));
    }];
    [self.tipsBg layoutIfNeeded];
    [self layoutIfNeeded];
    
}

- (void)layoutView{
    
    [self.tipsBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(KRateW(30.0));
    }];
    
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.tipsBg.mas_left).offset(KRateW(4.0));
//           make.right.equalTo(self.tipsBg.mas_right).offset(KRateW(6.0));
           make.top.bottom.equalTo(self.tipsBg);
       }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-KRateW(2.0));
        make.left.equalTo(self.tipsBg.mas_right).offset(KRateW(4.0)).priorityHigh();
    }];
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price  = [UILabel new];
    self.price.font = KRegularFont(9.0);
    self.price.textColor = KHexColor(@"#FFFFFF");
    [self addSubview:self.price];
    
    return self.price;
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    self.tips.textAlignment = NSTextAlignmentLeft;
    self.tips.font = KRegularFont(10.0);
    self.tips.textColor = KHexColor(@"#FFFFFF");
    [self.tipsBg addSubview:self.tips];
    
    return self.tips;
}

- (UIView *)tipsBg{
    if (_tipsBg) {
        return _tipsBg;
    }
    self.tipsBg = [UIView new];
    [self.tipsBg setCorners:(UIRectCornerTopRight|UIRectCornerBottomRight) radius:KRateW(9.0)];
    self.tipsBg.backgroundColor = KHexColor(@"#F9AB50");
    [self addSubview:self.tipsBg];
    
    return self.tipsBg;
}

@end
