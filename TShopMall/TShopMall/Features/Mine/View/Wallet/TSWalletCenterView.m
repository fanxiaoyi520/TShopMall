//
//  TSWalletCenterView.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSWalletCenterView.h"

@interface TSWalletCenterView ()
@property (nonatomic ,strong)TSWalletModel *model;
@property (nonatomic ,strong)UILabel *mineAssetsLab;
@property (nonatomic ,strong)UIButton *eyeBtn;
@property (nonatomic ,strong)UIButton *mineProfitBtn;
@property (nonatomic ,strong)UILabel *mineProfitLab;
@property (nonatomic ,strong)UILabel *mineProfitNumLab;

@property (nonatomic ,strong)UIButton *mineBankCardBtn;
@property (nonatomic ,strong)UILabel *mineBankCardLab;
@property (nonatomic ,strong)UILabel *mineBankCardNumLab;

@end
@implementation TSWalletCenterView

- (instancetype)initWithModel:(TSWalletModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    [self addSubview:self.mineAssetsLab];
    [self addSubview:self.eyeBtn];
    [self addSubview:self.mineProfitBtn];
    [self addSubview:self.mineBankCardBtn];
    [self addSubview:self.mineProfitLab];
    [self addSubview:self.mineProfitNumLab];
    [self addSubview:self.mineBankCardLab];
    [self addSubview:self.mineBankCardNumLab];
    
    [self.mineAssetsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(43);
        make.left.equalTo(self).offset(32);
        make.height.mas_equalTo(24);
    }];
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mineAssetsLab).offset(-3);
        make.left.equalTo(@[self.mineAssetsLab.mas_right]).offset(6);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    
    
    NSArray *views = @[self.mineProfitBtn, self.mineBankCardBtn];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:(kScreenWidth-40)/2-10 leadSpacing:20 tailSpacing:20];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(100);
        make.height.equalTo(@60);
    }];
    
    [self.mineProfitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.left.equalTo(self).offset(77);
        make.height.mas_equalTo(17);
    }];
    
    [self.mineProfitNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.mineProfitLab.mas_bottom]).offset(9);
        make.centerX.equalTo(self.mineProfitLab);
        make.height.mas_equalTo(28);
    }];

    [self.mineBankCardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.right.equalTo(self).offset(-71);
        make.height.mas_equalTo(17);
    }];

    [self.mineBankCardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.mineBankCardLab.mas_bottom]).offset(9);
        make.centerX.equalTo(self.mineBankCardLab);
        make.height.mas_equalTo(28);
    }];
}

// MARK: actions
- (void)eyeAction:(UIButton *)sender {
    if (sender.selected) {
        self.mineProfitNumLab.text = @"****";
        sender.selected = NO;
    } else {
        self.mineProfitNumLab.text = [NSString stringWithFormat:@"¥%@",self.model.totalRevenue];
        sender.selected = YES;
    }
}

- (void)mineProfitAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(walletCenterMineIncomeAction:)]) {
        [self.kDelegate walletCenterMineIncomeAction:sender];
    }
}

- (void)mineBankCardAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(walletBindingCardAction:)]) {
        [self.kDelegate walletBindingCardAction:sender];
    }
}

// MARK: get
- (UILabel *)mineAssetsLab {
    if (!_mineAssetsLab) {
        _mineAssetsLab = [UILabel new];
        _mineAssetsLab.textColor = KHexColor(@"#EFEFEF");
        _mineAssetsLab.font = KRegularFont(16);
        _mineAssetsLab.text = @"我的资产";
    }
    return _mineAssetsLab;
}

- (UIButton *)eyeBtn {
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_eyeBtn setImage:KImageMake(@"mall_mine_invisiable") forState:UIControlStateNormal];
        [_eyeBtn setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateSelected];
        _eyeBtn.selected = YES;
        [_eyeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    }
    return _eyeBtn;
}

- (UIButton *)mineProfitBtn {
    if (!_mineProfitBtn) {
        _mineProfitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mineProfitBtn addTarget:self action:@selector(mineProfitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mineProfitBtn;
}

- (UILabel *)mineProfitLab {
    if (!_mineProfitLab) {
        _mineProfitLab = [UILabel new];
        _mineProfitLab.textColor = KHexColor(@"#FFFFFF");
        _mineProfitLab.font = KRegularFont(12);
        _mineProfitLab.text = @"我的收益";
    }
    return _mineProfitLab;
}

- (UILabel *)mineProfitNumLab {
    if (!_mineProfitNumLab) {
        _mineProfitNumLab = [UILabel new];
        _mineProfitNumLab.textColor = KHexColor(@"#FFFFFF");
        _mineProfitNumLab.font = KRegularFont(20);
        _mineProfitNumLab.text = [NSString stringWithFormat:@"¥%@",self.model.totalRevenue];
    }
    return _mineProfitNumLab;
}

- (UIButton *)mineBankCardBtn {
    if (!_mineBankCardBtn) {
        _mineBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mineBankCardBtn addTarget:self action:@selector(mineBankCardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mineBankCardBtn;
}

- (UILabel *)mineBankCardLab {
    if (!_mineBankCardLab) {
        _mineBankCardLab = [UILabel new];
        _mineBankCardLab.textColor = KHexColor(@"#FFFFFF");
        _mineBankCardLab.font = KRegularFont(12);
        _mineBankCardLab.text = @"银行卡";
    }
    return _mineBankCardLab;
}

- (UILabel *)mineBankCardNumLab {
    if (!_mineBankCardNumLab) {
        _mineBankCardNumLab = [UILabel new];
        _mineBankCardNumLab.textColor = KHexColor(@"#FFFFFF");
        _mineBankCardNumLab.font = KRegularFont(20);
        _mineBankCardNumLab.text = self.model.count;
    }
    return _mineBankCardNumLab;
}

@end
