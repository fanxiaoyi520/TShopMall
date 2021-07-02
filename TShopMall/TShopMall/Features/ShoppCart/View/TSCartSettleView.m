//
//  TSCartSettleView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartSettleView.h"

@interface TSCartSettleView()
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, strong) UILabel *selBtnTips;
@property (nonatomic, strong) UIButton *settleBtn;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *tips;

@property (nonatomic, assign) BOOL isEdit;
@end

@implementation TSCartSettleView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.selBtn.selected = NO;
        self.selBtnTips.text = @"全选";
        [self updateSettleBtnText:0];
        [self updatePrice:@"0"];
        self.tips.text = @"合计:";
    }
    return self;
}

- (void)updateSettleBtnText:(NSInteger)number{
    if (self.isEdit == YES) {
        return ;
    }
    [self.settleBtn setTitle:[NSString stringWithFormat:@"结算 (%ld)", number] forState:UIControlStateNormal];
}

- (void)updatePrice:(NSString *)price{
    self.price.text = [NSString stringWithFormat:@"¥%ld", price.integerValue];
}

- (void)updateSelBtnStatus:(BOOL)status{
    self.selBtn.selected = status;
}

- (void)selBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.delegate allSelected:sender.selected];
}

- (void)hideSelBtn:(BOOL)hide{
    self.selBtn.hidden = hide;
    self.selBtnTips.hidden = hide;
}

- (void)settlement{
    [self.delegate goToSettle];
}

- (void)updateSettleViewStates:(BOOL)isEdit{
    _isEdit = isEdit;
    if (isEdit == YES) {
        self.price.hidden = YES;
        self.tips.hidden = YES;
        [self.settleBtn setBackgroundImage:KImageMake(@"") forState:UIControlStateNormal];
        self.settleBtn.layer.cornerRadius = KRateW(20.0);
        self.settleBtn.layer.borderWidth = 0.5;
        self.settleBtn.layer.borderColor = KHexColor(@"2D3132").CGColor;
        [self.settleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.settleBtn setTitleColor:KHexColor(@"2D3132") forState:UIControlStateNormal];
    } else {
        self.price.hidden = NO;
        self.tips.hidden = NO;
        [self.settleBtn setBackgroundImage:KImageMake(@"cart_settle_bg") forState:UIControlStateNormal];
        self.settleBtn.layer.cornerRadius = 0;
        self.settleBtn.layer.borderWidth = 0;
        self.settleBtn.layer.borderColor = [UIColor clearColor].CGColor;
        [self.settleBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [self updateSettleBtnText:0];
    }
}

- (void)layoutSubviews{
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(KRateW(20.0));
        make.left.equalTo(self.mas_left).offset(KRateW(18.0));
    }];
    
    [self.selBtnTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selBtn.mas_right).offset(KRateW(10.0));
        make.centerY.equalTo(self);
        make.height.mas_equalTo(KRateW(18.0));
    }];
    
    self.settleBtn.layer.cornerRadius = KRateW(20.0);
    self.settleBtn.layer.masksToBounds = YES;
    [self.settleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(KRateW(96.0));
        make.height.mas_equalTo(KRateW(40.0));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.settleBtn.mas_left).offset(-KRateW(28.0));
        make.centerY.equalTo(self);
        make.height.mas_equalTo(KRateW(30.0));
    }];
    
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.price.mas_left).offset(-KRateW(6.0));
        make.top.bottom.equalTo(self.price);
    }];
}

- (UIButton *)selBtn{
    if (_selBtn) {
        return _selBtn;
    }
    self.selBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_normal") forState:UIControlStateNormal];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_sel") forState:UIControlStateSelected];
    [self.selBtn addTarget:self action:@selector(selBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selBtn];
    
    return self.selBtn;
}

- (UIButton *)settleBtn{
    if (_settleBtn) {
        return _settleBtn;
    }
    self.settleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settleBtn setBackgroundColor:KHexColor(@"#FF4D49")];
    self.settleBtn.titleLabel.font = KFont(PingFangSCRegular, 14.0);
    [self.settleBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [self.settleBtn addTarget:self action:@selector(settlement) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settleBtn];
    
    return self.settleBtn;
}

- (UILabel *)selBtnTips{
    if (_selBtnTips) {
        return _selBtnTips;
    }
    self.selBtnTips  = [UILabel new];
    self.selBtnTips.font = KFont(PingFangSCRegular, 12.0);
    self.selBtnTips.textColor = KHexColor(@"#333333");
    [self addSubview:self.selBtnTips];
    
    return self.selBtnTips;
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

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips  = [UILabel new];
    self.tips.font = KFont(PingFangSCRegular, 12.0);
    self.tips.textColor = KHexColor(@"#333333");
    [self addSubview:self.tips];
    
    return self.tips;
}


@end
