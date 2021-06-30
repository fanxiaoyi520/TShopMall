//
//  TSWalletHeaderView.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/23.
//

#import "TSWalletHeaderView.h"

@interface TSWalletHeaderView ()

@property (nonatomic ,strong) UILabel *revenueAmountLab;
@property (nonatomic ,strong) UIButton *eyeBtn;
@property (nonatomic ,strong) UILabel *amountNumLab;
@property (nonatomic ,strong) UILabel *amountReceivedLab;
@property (nonatomic ,strong) UILabel *amountReceivedNumLab;
@property (nonatomic ,strong) UILabel *amountNotReceivedLab;
@property (nonatomic ,strong) UILabel *amountNotReceivedNumLab;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIButton *withdrawalRecordBtn;
@property (nonatomic ,strong) TSMyIncomeModel *model;
@end

@implementation TSWalletHeaderView

- (instancetype)initWithModel:(TSMyIncomeModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    [self addSubview:self.revenueAmountLab];
    [self addSubview:self.eyeBtn];
    [self addSubview:self.amountNumLab];
    [self addSubview:self.amountReceivedLab];
    [self addSubview:self.amountReceivedNumLab];
    [self addSubview:self.amountNotReceivedLab];
    [self addSubview:self.amountNotReceivedNumLab];
    [self addSubview:self.lineView];
    [self addSubview:self.withdrawalRecordBtn];
    
    [self.revenueAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.height.mas_equalTo(17);
        make.centerX.equalTo(self);
    }];
    
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.revenueAmountLab).offset(-5);
        make.left.equalTo(@[self.revenueAmountLab.mas_right]).offset(6);
        make.height.mas_equalTo(30);
    }];

    [self.amountNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(75);
        make.centerX.equalTo(self);
    }];
    
    [self.amountReceivedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(109);
        make.left.equalTo(self).offset(62);
        make.height.mas_equalTo(15);
    }];
    
    [self.amountReceivedNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(126);
        make.centerX.equalTo(self.amountReceivedLab);
        make.height.mas_equalTo(20);
    }];
    
    [self.amountNotReceivedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(109);
        make.right.equalTo(self).offset(-62);
        make.height.mas_equalTo(15);
    }];
    
    [self.amountNotReceivedNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(126);
        make.centerX.equalTo(self.amountNotReceivedLab);
        make.height.mas_equalTo(20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(120);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(1);
    }];
    
    [self.withdrawalRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-61);
        make.right.equalTo(self).offset(-17);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(77);
    }];
    
    [_withdrawalRecordBtn jaf_customFilletRectCorner:UIRectCornerTopLeft|UIRectCornerBottomLeft  cornerRadii:CGSizeMake(12, 12)];
}

/**布局有误*/
//// MARK: model
//- (void)setModel:(TSMyIncomeModel *)model {
//    if (!model) return;
//    self.model = model;
//}

// MARK: actions
- (void)eyeAction:(UIButton *)sender {
    if (sender.selected) {
        _amountNumLab.text = @"****";
        sender.selected = NO;
    } else {
        _amountNumLab.text = [NSString stringWithFormat:@"¥%@",self.model.totalRevenue];
        sender.selected = YES;
    }
    if ([self.kDelegate respondsToSelector:@selector(walletHeaderEyeAction:)]) {
        [self.kDelegate walletHeaderEyeAction:sender];
    }
}

- (void)withdrawalRecordAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(walletHeaderWithdrawalRecordAction:)]) {
        [self.kDelegate walletHeaderWithdrawalRecordAction:sender];
    }
}

// MARK: get
- (UILabel *)revenueAmountLab {
    if (!_revenueAmountLab) {
        _revenueAmountLab = [UILabel new];
        _revenueAmountLab.textColor = KWhiteColor;
        _revenueAmountLab.text = @"创收金额(元)";
        _revenueAmountLab.font = KRegularFont(12);
    }
    return _revenueAmountLab;
}

- (UIButton *)eyeBtn {
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn setImage:KImageMake(@"mall_mine_invisiable") forState:UIControlStateNormal];
        [_eyeBtn setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateSelected];
        [_eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_eyeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        _eyeBtn.selected = YES;
    }
    return _eyeBtn;
}

- (UILabel *)amountNumLab {
    if (!_amountNumLab) {
        _amountNumLab = [UILabel new];
        _amountNumLab.textColor = KWhiteColor;
        _amountNumLab.text = [NSString stringWithFormat:@"¥%@",self.model.totalRevenue];
        _amountNumLab.font = KRegularFont(20);
    }
    return _amountNumLab;
}

- (UILabel *)amountReceivedLab {
    if (!_amountReceivedLab) {
        _amountReceivedLab = [UILabel new];
        _amountReceivedLab.textColor = KWhiteColor;
        _amountReceivedLab.text = @"已到账金额";
        _amountReceivedLab.font = KRegularFont(10);
    }
    return _amountReceivedLab;
}

- (UILabel *)amountReceivedNumLab {
    if (!_amountReceivedNumLab) {
        _amountReceivedNumLab = [UILabel new];
        _amountReceivedNumLab.textColor = KWhiteColor;
        _amountReceivedNumLab.text = [NSString stringWithFormat:@"¥%@",self.model.arrivalAmount];
        _amountReceivedNumLab.font = KRegularFont(14);
    }
    return _amountReceivedNumLab;
}

- (UILabel *)amountNotReceivedLab {
    if (!_amountNotReceivedLab) {
        _amountNotReceivedLab = [UILabel new];
        _amountNotReceivedLab.textColor = KWhiteColor;
        _amountNotReceivedLab.text = @"未到账金额";
        _amountNotReceivedLab.font = KRegularFont(10);
    }
    return _amountNotReceivedLab;
}

- (UILabel *)amountNotReceivedNumLab {
    if (!_amountNotReceivedNumLab) {
        _amountNotReceivedNumLab = [UILabel new];
        _amountNotReceivedNumLab.textColor = KWhiteColor;
        _amountNotReceivedNumLab.text = [NSString stringWithFormat:@"¥%@",self.model.noArrivalAmount];
        _amountNotReceivedNumLab.font = KRegularFont(14);
    }
    return _amountNotReceivedNumLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KWhiteColor;
    }
    return _lineView;
}

- (UIButton *)withdrawalRecordBtn {
    if (!_withdrawalRecordBtn) {
        _withdrawalRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawalRecordBtn setTitle:@"提现记录 >>" forState:UIControlStateNormal];
        [_withdrawalRecordBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        _withdrawalRecordBtn.backgroundColor = KYellowTipColor;
        [_withdrawalRecordBtn addTarget:self action:@selector(withdrawalRecordAction:) forControlEvents:UIControlEventTouchUpInside];
        _withdrawalRecordBtn.titleLabel.font = KRegularFont(13);
    }
    return _withdrawalRecordBtn;
}
@end


@interface TSWalletCellView ()

@property (nonatomic ,strong) UIImageView *bankImageView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *cardNumberLab;
@property (nonatomic ,strong) UIButton *isBindingLab;
@property (nonatomic ,strong) UIImageView *instrucImgView;
@property (nonatomic ,strong) TSMyIncomeModel *model;
@end

@implementation TSWalletCellView

- (instancetype)initWithModel:(TSMyIncomeModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    
    [self addSubview:self.bankImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.cardNumberLab];
    [self addSubview:self.isBindingLab];
    [self addSubview:self.instrucImgView];
    
    [self.bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.height.mas_offset(25);
        make.left.equalTo(self).offset(16);
    }];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankImageView).offset(2);
        make.height.mas_offset(21);
        make.left.equalTo(self).offset(46);
    }];

    [self.cardNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(33);
        make.height.mas_offset(24);
        make.left.equalTo(self).offset(16);
    }];
    
    [self.isBindingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(21);
        make.height.mas_offset(22);
        make.right.equalTo(self).offset(-41);
    }];
    
    [self.instrucImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.isBindingLab.mas_top]).offset(1.5);
        make.height.mas_offset(19);
        make.width.mas_offset(16);
        make.right.equalTo(self).offset(-19);
    }];
}

// MARK: actions
- (void)isBindingAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(walletCellViewIsBindingAction:)]) {
        [self.kDelegate walletCellViewIsBindingAction:sender];
    }
}

//// MARK: model
//- (void)setModel:(TSMyIncomeModel *)model {
//    if (!model) return;
//
//    _cardNumberLab.text = model.bankCardNo;
//}

// 银行卡部分秘文显示
-(NSString *)returnBankCard:(NSString *)BankCardStr {
    NSString *formerStr = [BankCardStr substringToIndex:4];
    NSString *str1 = [BankCardStr stringByReplacingOccurrencesOfString:formerStr withString:@""];
    NSString *endStr = [BankCardStr substringFromIndex:BankCardStr.length-4];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:endStr withString:@""];
    NSString *middleStr = [str2 stringByReplacingOccurrencesOfString:str2 withString:@"****"];
    NSString *CardNumberStr = [formerStr stringByAppendingFormat:@"%@%@",middleStr,endStr];
    return CardNumberStr;
}

// MARK: get
- (UIImageView *)bankImageView {
    if (!_bankImageView) {
        _bankImageView = [UIImageView new];
        _bankImageView.image = KImageMake(@"mall_mine_wallet_bank");
    }
    return _bankImageView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = KHexColor(@"#333333");
        _titleLab.font = KRegularFont(16);
        _titleLab.text = @"银行卡提现";
    }
    return _titleLab;
}

- (UILabel *)cardNumberLab {
    if (!_cardNumberLab) {
        _cardNumberLab = [UILabel new];
        _cardNumberLab.textColor = KHexColor(@"#2D3132");
        _cardNumberLab.font = KRegularFont(10);
        if (self.model.bankCardNo) {
            _cardNumberLab.text = [NSString stringWithFormat:@"提现到银行卡账号:%@",[self returnBankCard:self.model.bankCardNo]];
        } else {
            _cardNumberLab.textColor = KHexAlphaColor(@"#2D3132", .5);
            _cardNumberLab.text =  @"请先绑定提现银行卡账号";
        }
    }
    return _cardNumberLab;
}

- (UIButton *)isBindingLab {
    if (!_isBindingLab) {
        _isBindingLab = [UIButton buttonWithType:UIButtonTypeCustom];
        [_isBindingLab setTitleColor:KHexAlphaColor(@"#2D3132", .5) forState:UIControlStateNormal];
        _isBindingLab.titleLabel.font = KRegularFont(14);
        if (self.model.bankCardNo) {
            [_isBindingLab setTitle:@"已绑定" forState:UIControlStateNormal];
        } else {
            [_isBindingLab setTitle:@"去绑定" forState:UIControlStateNormal];
            [_isBindingLab addTarget:self action:@selector(isBindingAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _isBindingLab;
}

- (UIImageView *)instrucImgView {
    if (!_instrucImgView) {
        _instrucImgView = [UIImageView new];
        _instrucImgView.image = KImageMake(@"mine_tips_right");
    }
    return _instrucImgView;
}
@end
