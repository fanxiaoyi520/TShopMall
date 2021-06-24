//
//  TSWithdrawalRecordCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSWithdrawalRecordCell.h"

@interface TSWithdrawalRecordCell ()

@property (nonatomic ,strong)UIButton *profitLab;
@property (nonatomic ,strong)UILabel *oddNumbersLab;
@property (nonatomic ,strong)UILabel *recordSattusLab;
@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UILabel *taxDeductionAmountNameLab;
@property (nonatomic ,strong)UILabel *taxDeductionAmount;

@property (nonatomic ,strong)UILabel *WithdrawalLab;
@property (nonatomic ,strong)UILabel *WithdrawalNumLab;

@property (nonatomic ,strong)UILabel *afterTaxLab;
@property (nonatomic ,strong)UILabel *afterTaxNumLab;

@property (nonatomic ,strong)UILabel *withdrawalCardLab;
@property (nonatomic ,strong)UILabel *WithdrawalCardNumLab;

@property (nonatomic ,strong)UILabel *applicationTimeLab;
@property (nonatomic ,strong)UILabel *applicationTimeNumLab;
@end

@implementation TSWithdrawalRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    [self addSubview:self.profitLab];
    [self.profitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(16);
    }];
    [_profitLab jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];


    [self addSubview:self.oddNumbersLab];
    [self.oddNumbersLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(17);
        make.left.equalTo(@[self.profitLab.mas_right]).offset(6);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.recordSattusLab];
    [self.recordSattusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(56);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.taxDeductionAmountNameLab];
    [self.taxDeductionAmountNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.lineView.mas_bottom]).offset(11);
        make.right.equalTo(self).offset(-121);
        make.height.mas_equalTo(24);
    }];
    
    [self addSubview:self.taxDeductionAmount];
    [self.taxDeductionAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.lineView.mas_bottom]).offset(11);
        make.left.equalTo(@[self.taxDeductionAmountNameLab.mas_right]).offset(31);
        make.height.mas_equalTo(24);
    }];
    
    [self addSubview:self.WithdrawalLab];
    [self addSubview:self.WithdrawalNumLab];
    [self addSubview:self.afterTaxLab];
    [self addSubview:self.afterTaxNumLab];
    [self addSubview:self.withdrawalCardLab];
    [self addSubview:self.WithdrawalCardNumLab];
    [self addSubview:self.applicationTimeLab];
    [self addSubview:self.applicationTimeNumLab];
    NSArray *nameViews = @[self.WithdrawalLab,self.afterTaxLab,self.withdrawalCardLab,self.applicationTimeLab];
    [nameViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:12 leadSpacing:68 tailSpacing:12];
    [nameViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.width.equalTo(@80);
    }];

    NSArray *numViews = @[self.WithdrawalNumLab,self.afterTaxNumLab,self.WithdrawalCardNumLab,self.applicationTimeNumLab];
    [numViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:12 leadSpacing:68 tailSpacing:12];
    [numViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(103);
    }];
}

- (void)setModel:(TSWithdrawalRecordModel * _Nullable)model {
    //if (!model) return;
    
}

// MARK: get
- (UIButton *)profitLab {
    if (!_profitLab) {
        _profitLab = [UIButton buttonWithType:UIButtonTypeCustom];
        _profitLab.backgroundColor = KHexAlphaColor(@"#E64C3D",.4);
        [_profitLab setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        _profitLab.userInteractionEnabled = NO;
        _profitLab.titleLabel.font = KRegularFont(10);
        [_profitLab setTitle:@"收益" forState:UIControlStateNormal];
    }
    return _profitLab;
}

- (UILabel *)oddNumbersLab {
    if (!_oddNumbersLab) {
        _oddNumbersLab = [UILabel new];
        _oddNumbersLab.font = KRegularFont(14);
        _oddNumbersLab.textColor = KHexColor(@"#2D3132");
        _oddNumbersLab.text = @"T20210529B00104990";
    }
    return _oddNumbersLab;
}

- (UILabel *)recordSattusLab {
    if (!_recordSattusLab) {
        _recordSattusLab = [UILabel new];
        _recordSattusLab.font = KRegularFont(14);
        _recordSattusLab.textColor = KHexColor(@"#E64C3D");
        _recordSattusLab.text = @"审批中";
    }
    return _recordSattusLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"#E6E6E6");
    }
    return _lineView;
}

- (UILabel *)taxDeductionAmountNameLab {
    if (!_taxDeductionAmountNameLab) {
        _taxDeductionAmountNameLab = [UILabel new];
        _taxDeductionAmountNameLab.font = KRegularFont(14);
        _taxDeductionAmountNameLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _taxDeductionAmountNameLab.text = @"扣税金额";
    }
    return _taxDeductionAmountNameLab;
}

- (UILabel *)taxDeductionAmount {
    if (!_taxDeductionAmount) {
        _taxDeductionAmount = [UILabel new];
        _taxDeductionAmount.font = KRegularFont(14);
        _taxDeductionAmount.textColor = KHexColor(@"#2D3132");
        _taxDeductionAmount.text = @"¥0";
    }
    return _taxDeductionAmount;
}

- (UILabel *)WithdrawalLab {
    if (!_WithdrawalLab) {
        _WithdrawalLab = [UILabel new];
        _WithdrawalLab.font = KRegularFont(14);
        _WithdrawalLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _WithdrawalLab.text = @"提现金额";
    }
    return _WithdrawalLab;
}

- (UILabel *)WithdrawalNumLab {
    if (!_WithdrawalNumLab) {
        _WithdrawalNumLab = [UILabel new];
        _WithdrawalNumLab.font = KRegularFont(14);
        _WithdrawalNumLab.textColor = KHexColor(@"#2D3132");
        _WithdrawalNumLab.text = @"¥255";
    }
    return _WithdrawalNumLab;
}

- (UILabel *)afterTaxLab {
    if (!_afterTaxLab) {
        _afterTaxLab = [UILabel new];
        _afterTaxLab.font = KRegularFont(14);
        _afterTaxLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _afterTaxLab.text = @"税后金额";
    }
    return _afterTaxLab;
}

- (UILabel *)afterTaxNumLab {
    if (!_afterTaxNumLab) {
        _afterTaxNumLab = [UILabel new];
        _afterTaxNumLab.font = KRegularFont(14);
        _afterTaxNumLab.textColor = KHexColor(@"#2D3132");
        _afterTaxNumLab.text = @"¥255";
    }
    return _afterTaxNumLab;
}

- (UILabel *)withdrawalCardLab {
    if (!_withdrawalCardLab) {
        _withdrawalCardLab = [UILabel new];
        _withdrawalCardLab.font = KRegularFont(14);
        _withdrawalCardLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _withdrawalCardLab.text = @"提现银行卡";
    }
    return _withdrawalCardLab;
}

- (UILabel *)WithdrawalCardNumLab {
    if (!_WithdrawalCardNumLab) {
        _WithdrawalCardNumLab = [UILabel new];
        _WithdrawalCardNumLab.font = KRegularFont(14);
        _WithdrawalCardNumLab.textColor = KHexColor(@"#2D3132");
        _WithdrawalCardNumLab.text = @"6455********6688";
    }
    return _WithdrawalCardNumLab;
}

- (UILabel *)applicationTimeLab {
    if (!_applicationTimeLab) {
        _applicationTimeLab = [UILabel new];
        _applicationTimeLab.font = KRegularFont(14);
        _applicationTimeLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _applicationTimeLab.text = @"申请时间";
    }
    return _applicationTimeLab;
}

- (UILabel *)applicationTimeNumLab {
    if (!_applicationTimeNumLab) {
        _applicationTimeNumLab = [UILabel new];
        _applicationTimeNumLab.font = KRegularFont(14);
        _applicationTimeNumLab.textColor = KHexColor(@"#2D3132");
        _applicationTimeNumLab.text = @"2020-06-01  15:00:00";
    }
    return _applicationTimeNumLab;
}
@end



@interface TSWithdrawalRecordHeader ()

@property (nonatomic ,assign) NSInteger oldBtnTag;
@end

@implementation TSWithdrawalRecordHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    [[TSWithdrawalRecordModel getFixedFata] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx + 10;
        [btn setTitleColor:KHexAlphaColor(@"#2D3132",.5) forState:UIControlStateNormal];
        btn.titleLabel.font = KRegularFont(16);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (idx == 0) {
            self.oldBtnTag = 10;
            [btn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        }
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = KHexColor(@"#E6E6E6");
        lineView.tag = idx + 20;
        [self addSubview:lineView];
    }];
}

- (void)setModel:(TSWithdrawalRecordModel *)model {
    NSArray *arrayModel = [TSWithdrawalRecordModel getFixedFata];
    [[TSWithdrawalRecordModel getFixedFata] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *btn = [self viewWithTag:idx + 10];
        [btn setTitle:arrayModel[idx] forState:UIControlStateNormal];
        btn.frame = CGRectMake(idx*(kScreenWidth/arrayModel.count), 0, kScreenWidth/arrayModel.count, self.height);
        
        UIView *lineView = [self viewWithTag:20+idx];
        lineView.frame = CGRectMake(kScreenWidth/arrayModel.count+idx*(1+kScreenWidth/arrayModel.count), 21, 1, 14);
    }];
}



// MARK: actions
- (void)btnAction:(UIButton *)sender {
    UIButton *clickBtn = (UIButton *)[self viewWithTag:sender.tag];
    UIButton *oldBtn = (UIButton *)[self viewWithTag:self.oldBtnTag];
    [oldBtn setTitleColor:KHexAlphaColor(@"#2D3132",.5) forState:UIControlStateNormal];
    [clickBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
    self.oldBtnTag = clickBtn.tag;
    
    if ([self.kDelegate respondsToSelector:@selector(withdrawalRecordHeaderBtnAction:)]) {
        [self.kDelegate withdrawalRecordHeaderBtnAction:sender];
    }
}

@end
