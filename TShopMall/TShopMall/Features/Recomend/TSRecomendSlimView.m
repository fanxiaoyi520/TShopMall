//
//  TSRecomendSlimView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSRecomendSlimView.h"

@implementation TSRecomendSlimView

- (void)layoutSubviews{
    self.layer.cornerRadius = KRateW(8.0);
    self.layer.masksToBounds = YES;
    self.backgroundColor = UIColor.whiteColor;
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
    }];
    
    [self.earnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.name.mas_right);
        make.centerY.equalTo(self.price);
        make.height.mas_equalTo(KRateW(18.0));
    }];
}

@end
