//
//  TSAddBankCardCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSAddBankCardCell.h"

@interface TSAddBankCardCell ()

@property (nonatomic ,strong)UILabel *infoLab;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,strong)UIImageView *tipsImgView;
@property (nonatomic ,strong)UITextField *inputInfoTextField;
@property (nonatomic ,strong)UIButton *funcBtn;
@end

@implementation TSAddBankCardCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jaf_layoutSubviews];
    }
    return self;
}

- (void)jaf_layoutSubviews {
    [self addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(25);
        make.right.equalTo(self).offset(-25);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.tipsImgView];
    [self.tipsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    [self addSubview:self.inputInfoTextField];
    [self.inputInfoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(127);
        make.height.mas_equalTo(40);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.funcBtn];
    [self.funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(127);
        make.height.mas_equalTo(40);
        make.right.equalTo(self).offset(-16);
    }];
}

// MARK: model
- (void)setModel:(id _Nullable)model indexPath:(NSIndexPath *)indexPath {
    //if (!model) return;
    _infoLab.text = (NSString *)model;
    if (indexPath.row == 0) {
        _inputInfoTextField.hidden = NO;
        _inputInfoTextField.placeholder = @"请绑定持卡本人的银行卡";
        _inputInfoTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.row == 3) {
        _inputInfoTextField.hidden = NO;
        _inputInfoTextField.placeholder = @"请输入开户银行";
        _inputInfoTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    
    if (indexPath.row == 1 || indexPath.row == 2){
        _funcBtn.hidden = NO;
        _tipsImgView.hidden = NO;
    }
}

// MARK: actions
- (void)inputInfoTextFieldAction:(UITextField *)textField {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardInputInfoTextFieldAction:)]) {
        [self.kDelegate addBankCardInputInfoTextFieldAction:textField];
    }
}

- (void)funcAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardfuncAction:)]) {
        [self.kDelegate addBankCardfuncAction:sender];
    }
}

// MARK: get
- (UILabel *)infoLab {
    if (!_infoLab) {
        _infoLab = [UILabel new];
        _infoLab.textColor = KHexColor(@"#2D3132");
        _infoLab.font = KRegularFont(14);
    }
    return _infoLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"#E6E6E6");
    }
    return _lineView;
}

- (UIImageView *)tipsImgView {
    if (!_tipsImgView) {
        _tipsImgView = [UIImageView new];
        _tipsImgView.image = KImageMake(@"mine_tips_right");
        _tipsImgView.hidden = YES;
    }
    return _tipsImgView;
}

- (UITextField *)inputInfoTextField {
    if (!_inputInfoTextField) {
        _inputInfoTextField = [[UITextField alloc] init];
        [_inputInfoTextField addTarget:self action:@selector(inputInfoTextFieldAction:) forControlEvents:UIControlEventEditingChanged];
        _inputInfoTextField.hidden = YES;
    }
    return _inputInfoTextField;
}

- (UIButton *)funcBtn {
    if (!_funcBtn) {
        _funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _funcBtn.hidden = YES;
        [_funcBtn addTarget:self action:@selector(funcAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funcBtn;
}
@end

@interface TSAddBankCardHeader ()

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *tipsImgView;
@property (nonatomic ,strong) UILabel *tipsLable;
@end
@implementation TSAddBankCardHeader
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    [self addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(23);
        make.height.mas_equalTo(24);
        make.left.equalTo(self).offset(16);
    }];
    
    [self addSubview:self.tipsImgView];
    [self.tipsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.titleLable.mas_bottom]).offset(16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
        make.left.equalTo(self).offset(16);
    }];
    
    [self addSubview:self.tipsLable];
    [self.tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.titleLable.mas_bottom]).offset(12);
        make.height.mas_equalTo(24);
        make.left.equalTo(@[self.tipsImgView.mas_right]).offset(5);
    }];
}

// MARK: model
- (void)setModel:(id _Nullable)model {}

// MARK: get
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.textColor = KHexColor(@"#2D3132");
        _titleLable.font = KRegularFont(16);
        _titleLable.text = @"您好，JERRYJUICE";
    }
    return _titleLable;
}

- (UIImageView *)tipsImgView {
    if (!_tipsImgView) {
        _tipsImgView = [UIImageView new];
        _tipsImgView.image = KImageMake(@"mine_tips_add");
    }
    return _tipsImgView;
}

- (UILabel *)tipsLable {
    if (!_tipsLable) {
        _tipsLable = [UILabel new];
        _tipsLable.textColor = KHexAlphaColor(@"#2D3132",.5);
        _tipsLable.font = KRegularFont(10);
        _tipsLable.text = @"将为您加密处理信息，放心使用";
    }
    return _tipsLable;
}
@end

@interface TSAddBankCardFooter ()

@property (nonatomic ,strong) UIButton *sureBtn;
@end

@implementation TSAddBankCardFooter
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    
    [self addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
}

// MARK: model
- (void)setModel:(id)model {}

// MARK: actions
- (void)sureAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardFooterSureAction:)]) {
        [self.kDelegate addBankCardFooterSureAction:sender];
    }
}

// MARK: get
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = KRegularFont(16);
        [_sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
