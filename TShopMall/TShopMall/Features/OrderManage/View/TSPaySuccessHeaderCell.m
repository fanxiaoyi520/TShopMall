//
//  TSPaySuccessHeaderCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPaySuccessHeaderCell.h"

@interface TSPaySuccessHeaderCell()
@property (nonatomic, strong) UIImageView *redImg;

@property (nonatomic, strong) UIView *operationView;
@property (nonatomic, strong) UIButton *backHomeBtn;
@property (nonatomic, strong) UIButton *orderDetailBtn;

@property (nonatomic, strong) UIView *tipsBgView;
@property (nonatomic, strong) UIImageView *tipsImg;
@property (nonatomic, strong) UILabel *tips;

@end

@implementation TSPaySuccessHeaderCell

- (void)backHomeAction{
    if ([self.theDelegate respondsToSelector:@selector(backToHome)]) {
        [self.theDelegate backToHome];
    }
}

- (void)orderDetailAction{
    if ([self.theDelegate respondsToSelector:@selector(goToOrderDetail)]) {
        [self.theDelegate goToOrderDetail];
    }
}

- (void)layoutSubviews{
    [self.redImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(62.0));
    }];
    
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(72.0));
    }];
    
    [self.backHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.operationView.mas_left).offset(KRateW(56.0));
        make.centerY.equalTo(self.operationView);
        make.height.mas_equalTo(KRateW(32.0));
    }];
    
    [self.orderDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.operationView.mas_right).offset(-KRateW(56.0));
        make.centerY.width.height.equalTo(self.backHomeBtn);
        make.left.equalTo(self.backHomeBtn.mas_right).offset(KRateW(24.0)).priorityHigh();
    }];
    
    [self.tipsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.operationView.mas_top).offset(-KRateW(44.0));
        make.height.mas_equalTo(KRateW(20.0));
    }];

    [self.tipsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.tipsBgView);
        make.width.height.mas_equalTo(KRateW(20.0));
    }];

    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsImg.mas_right).offset(KRateW(8.0));
        make.top.bottom.equalTo(self.tipsBgView);
        make.right.equalTo(self.tipsBgView.mas_right).priorityHigh();
    }];
    
}

- (UIImageView *)redImg{
    if (_redImg) {
        return _redImg;
    }
    self.redImg = [UIImageView new];
    self.redImg.image = KImageMake(@"mall_pay_bg");
    [self.contentView addSubview:self.redImg];
    
    return self.redImg;
}

- (UIView *)operationView{
    if (_operationView) {
        return _operationView;
    }
    self.operationView = [UIView new];
    self.operationView.layer.cornerRadius = KRateW(8.0);
    self.operationView.layer.masksToBounds = YES;
    self.operationView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.operationView];
    
    return self.operationView;
}

- (UIButton *)backHomeBtn{
    if (_backHomeBtn) {
        return _backHomeBtn;
    }
    self.backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backHomeBtn setTitle:@"返回商城首页" forState:UIControlStateNormal];
    [self.backHomeBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
    self.backHomeBtn.titleLabel.font = KRegularFont(14.0);
    self.backHomeBtn.layer.cornerRadius = KRateW(16.0);
    self.backHomeBtn.layer.borderWidth = 1;
    self.backHomeBtn.layer.borderColor = KHexColor(@"#E64C3D").CGColor;
    [self.operationView addSubview:self.backHomeBtn];
    
    return self.backHomeBtn;
}

- (UIButton *)orderDetailBtn{
    if (_orderDetailBtn) {
        return _orderDetailBtn;
    }
    self.orderDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderDetailBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [self.orderDetailBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
    self.orderDetailBtn.titleLabel.font = KRegularFont(14.0);
    self.orderDetailBtn.layer.cornerRadius = KRateW(16.0);
    self.orderDetailBtn.layer.borderWidth = 1;
    self.orderDetailBtn.layer.borderColor = KHexColor(@"#E64C3D").CGColor;
    [self.operationView addSubview:self.orderDetailBtn];
    
    return self.orderDetailBtn;
}

- (UIView *)tipsBgView{
    if (_tipsBgView) {
        return _tipsBgView;
    }
    self.tipsBgView = [UIView new];
    [self.contentView addSubview:self.tipsBgView];
    
    return self.tipsBgView;
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    self.tips.font = KFont(PingFangSCMedium, 20.0);
    self.tips.text = @"支付成功";
    self.tips.textColor = KHexColor(@"#FFFFFF");
    [self.tipsBgView addSubview:self.tips];
    
    return self.tips;
}

- (UIImageView *)tipsImg{
    if (_tipsImg) {
        return _tipsImg;
    }
    self.tipsImg = [UIImageView new];
    self.tipsImg.image = KImageMake(@"mall_pay_success");
    [self.tipsBgView addSubview:self.tipsImg];
    
    return self.tipsImg;
}

@end
