//
//  TSBankCardCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSBankCardCell.h"
#import "NSString+Plugin.h"

@implementation TSBankCardCell {
    UIImageView * _bankImageCion;
    UILabel * _bankNameLabel;
    UILabel * _accountLabel;
    UIImageView * _masterLabelBackImageView;
    UILabel * _masterLabel;
    UIImageView * _bgImageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 12;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0, 0);
//        self.layer.shadowRadius = 5.0f;
//        self.layer.shadowOpacity = 1.f;
        self.layer.masksToBounds = NO;
        [self uiConfigue];
    }
    return self;
}
- (void)uiConfigue {
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _bgImageView.image=[UIImage imageNamed:@"mine_red_bg"];
     [self.contentView addSubview:_bgImageView];
    
    _bankImageCion = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    _bankImageCion.backgroundColor=[UIColor colorWithRed: arc4random_uniform(256)/255.0f green: arc4random_uniform(256)/255.0f blue: arc4random_uniform(256)/255.0f alpha:1];
    _bankImageCion.image=[UIImage imageNamed:@""];
    _bankImageCion.layer.cornerRadius=_bankImageCion.width/2;
    _bankImageCion.layer.masksToBounds=YES;
    [_bgImageView addSubview:_bankImageCion];
    
    _bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bankImageCion.right+15, 18, 200, 40)];
    _bankNameLabel.font=KRegularFont(16);
    _bankNameLabel.textColor=[UIColor whiteColor];
    [_bgImageView addSubview:_bankNameLabel];
    
    
    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 200 - 10, 18, 200, 30)];
    _accountLabel.font=KRegularFont(16);
    _accountLabel.textColor=KWhiteColor;
    _accountLabel.textAlignment = NSTextAlignmentRight;
    [_bgImageView addSubview:_accountLabel];
}

// MARK: model
- (void)setModel:(id)model {
    if (!model) return;
    TSBankCardModel *kModel = model;
    _bankNameLabel.text = kModel.accountBank;
    _accountLabel.text = [NSString returnBankCard:kModel.bankCardNo];
    
    if (self.height == 120) {
        _accountLabel.top = 87;
        
        if ([kModel.bankStatus isEqualToString:@"0"]) {
            _bgImageView.image=[UIImage imageNamed:@"mine_shenhezhong_da"];
            _accountLabel.text = kModel.bankStatusName;
        } else if ([kModel.bankStatus isEqualToString:@"1"]) {
            _bgImageView.image=[UIImage imageNamed:@"mine_bankstatus_hong"];
        } else {
            _bgImageView.image=[UIImage imageNamed:@"mine_yellow_bg1"];
        }
    } else {
        if ([kModel.bankStatus isEqualToString:@"0"]) {
            _bgImageView.image=[UIImage imageNamed:@"mine_grey_bg"];
            _accountLabel.text = kModel.bankStatusName;
        } else if ([kModel.bankStatus isEqualToString:@"1"]) {
            _bgImageView.image=[UIImage imageNamed:@"mine_red_bg"];
        } else {
            _bgImageView.image=[UIImage imageNamed:@"mine_yellow_bg2"];
        }
    }
    

}

@end

@interface TSBankCardHeader ()

@property (nonatomic ,strong) UIImageView *tipImageView;
@property (nonatomic ,strong) UILabel *tipLab;
@end

@implementation TSBankCardHeader

- (void)layoutSubviews {
    [super layoutSubviews];
    [self jaf_layoutSubview];
}

- (void)jaf_layoutSubview {
    [self addSubview:self.tipImageView];
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64);
        make.height.mas_equalTo(220);
        make.width.mas_equalTo(220);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.tipLab];
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.tipImageView.mas_bottom]);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self);
    }];
}

// MARK: get
- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [UIImageView new];
        _tipImageView.image = KImageMake(@"mine_bg_tips");
    }
    return _tipImageView;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.textColor = KHexColor(@"#333333");
        _tipLab.font = KRegularFont(14);
        _tipLab.text = @"银行卡未添加";
    }
    return _tipLab;
}
@end

@interface TSBankCardFooter ()

@property (nonatomic ,strong)UIButton *addBankCardBtn;
@end

@implementation TSBankCardFooter
- (void)layoutSubviews {
    [super layoutSubviews];
    [self jaf_layoutSubview];
}

- (void)jaf_layoutSubview {
    [self addSubview:self.addBankCardBtn];
    [self.addBankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(27);
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.height.mas_equalTo(40);
    }];
    [_addBankCardBtn.layer setMasksToBounds:YES];
    [_addBankCardBtn.layer setCornerRadius:20];
    [_addBankCardBtn.layer setBorderWidth:.5];
    [_addBankCardBtn.layer setBorderColor:KHexColor(@"#535558").CGColor];
}

// MARK: actions
- (void)addBankCardAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(bankCardFooterAddBankCardAction:)]) {
        [self.kDelegate bankCardFooterAddBankCardAction:sender];
    }
}

// MARK: get
- (UIButton *)addBankCardBtn {
    if (!_addBankCardBtn) {
        _addBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBankCardBtn.backgroundColor = KWhiteColor;
        [_addBankCardBtn setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
        _addBankCardBtn.titleLabel.font = KRegularFont(16);
        [_addBankCardBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        [_addBankCardBtn addTarget:self action:@selector(addBankCardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBankCardBtn;
}
@end


@interface TSBankCardUnbundlingFooter ()

@property (nonatomic ,strong) UIButton *unbundlingBankBtn;
@property (nonatomic ,strong) UILabel *unbundlingLab;
@property (nonatomic ,strong) UIImageView *tipsImageView;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation TSBankCardUnbundlingFooter

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.unbundlingBankBtn];
    [self.unbundlingBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.height.mas_equalTo((self.height-16));
        make.width.mas_equalTo(self.width);
    }];
    
    [self addSubview:self.unbundlingLab];
    [self.unbundlingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.unbundlingBankBtn);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.tipsImageView];
    [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.unbundlingBankBtn);
        make.right.equalTo(self).offset(-19);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.unbundlingBankBtn.mas_bottom]);
        make.right.equalTo(self).offset(-25);
        make.left.equalTo(self).offset(25);
        make.height.mas_equalTo(1);
    }];
}

//MARK: actions
- (void)unbundlingBankAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(bankCardFooterBankCardUnbundlingAction:)]) {
        [self.kDelegate bankCardFooterBankCardUnbundlingAction:sender];
    }
}

// MARK: get
- (UIButton *)unbundlingBankBtn {
    if (!_unbundlingBankBtn) {
        _unbundlingBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unbundlingBankBtn addTarget:self action:@selector(unbundlingBankAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unbundlingBankBtn;
}

- (UILabel *)unbundlingLab {
    if (!_unbundlingLab) {
        _unbundlingLab = [UILabel new];
        _unbundlingLab.textColor = KHexColor(@"#2D3132");
        _unbundlingLab.font = KRegularFont(14);
        _unbundlingLab.text = @"解绑银行卡";
    }
    return _unbundlingLab;
}

- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        _tipsImageView = [UIImageView new];
        _tipsImageView.image = KImageMake(@"mine_tips_right");
    }
    return _tipsImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"#E6E6E6");
    }
    return _lineView;
}
@end
