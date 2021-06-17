//
//  TSMakeOrderCommitView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderCommitView.h"

@implementation TSMakeOrderCommitView

- (void)layoutSubviews{
    self.backgroundColor = UIColor.whiteColor;
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.mas_top).offset(KRateW(8.0));
        make.width.mas_equalTo(KRateW(96.0));
        make.height.mas_equalTo(KRateW(40.0));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commitBtn.mas_left).offset(-KRateW(8.0));
        make.top.bottom.equalTo(self.commitBtn);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.price.mas_left).offset(-KRateW(8.0));
        make.top.bottom.equalTo(self.commitBtn);
    }];
}

- (UIButton *)commitBtn{
    if (_commitBtn) {
        return _commitBtn;
    }
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setBackgroundImage:KImageMake(@"cart_settle_bg") forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = KFont(PingFangSCRegular, 14.0);
    [self.commitBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [self.commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [self addSubview:self.commitBtn];
    
    return self.commitBtn;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.font = KFont(PingFangSCMedium, 20.0);
    self.price.textColor = KHexColor(@"#E64C3D");
    [self addSubview:self.price];
    
    return self.price;
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"应付金额: ";
    self.title.font = KRegularFont(12.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.title];
    
    return self.title;
}

@end
