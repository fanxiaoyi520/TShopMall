//
//  TSChangePriceView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import "TSChangePriceView.h"

@interface TSChangePriceView()<UITextFieldDelegate>

/// 关闭按钮
@property(nonatomic, strong) UIButton *closeButton;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 统一零售价
@property(nonatomic, strong) UIView *retailView;
/// 统一零售价label
@property(nonatomic, strong) UILabel *retailLabel;

/// 代理特惠价
@property(nonatomic, strong) UIView *preferenceView;
@property(nonatomic, strong) UIButton *preferenceButton;
@property(nonatomic, strong) UILabel *preferenceLabel;
@property(nonatomic, strong) UILabel *adjustLabel;
@property(nonatomic, strong) UIButton *reduceButton;
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) UITextField *inputTF;

/// 提货价
@property(nonatomic, strong) UIView *pickupView;
@property(nonatomic, strong) UILabel *guidePriceLabel;
@property(nonatomic, strong) UILabel *guidePriceValueLabel;

/// 提示语
@property(nonatomic, strong) UIView *promptView;
@property(nonatomic, strong) UILabel *promptLabel;

/// 微信
@property(nonatomic, strong) UIButton *shareButton;
@property(nonatomic, strong) UILabel *weixinLabel;

@end

@implementation TSChangePriceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    [self addSubview:self.closeButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.retailView];
    [self.retailView addSubview:self.retailLabel];
    
    [self addSubview:self.preferenceView];
    [self.preferenceView addSubview:self.preferenceButton];
    [self.preferenceView addSubview:self.preferenceLabel];
    [self.preferenceView addSubview:self.adjustLabel];
    [self.preferenceView addSubview:self.addButton];
    [self.preferenceView addSubview:self.inputTF];
    [self.preferenceView addSubview:self.reduceButton];
    
    [self addSubview:self.pickupView];
    [self.pickupView addSubview:self.guidePriceLabel];
    [self.pickupView addSubview:self.guidePriceValueLabel];

    [self addSubview:self.promptView];
    [self.promptView addSubview:self.promptLabel];
    [self addSubview:self.shareButton];
    [self addSubview:self.weixinLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(24);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-15);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.retailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(57);
    }];
    
    [self.retailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self.retailView);
    }];
    
    [self.preferenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.retailView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(60);
    }];
    
    [self.preferenceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.preferenceView);
    }];
    
    [self.preferenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.preferenceButton.mas_right).offset(1);
        make.centerY.equalTo(self.preferenceView);
    }];
    
    [self.adjustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.preferenceView.mas_right).offset(-39);
        make.bottom.equalTo(self.preferenceView.mas_bottom).offset(-2);
        make.height.mas_equalTo(18);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.preferenceView.mas_top).offset(5);
        make.right.equalTo(self.preferenceView.mas_right).offset(-15);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(32);
    }];
    
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addButton);
        make.right.equalTo(self.addButton.mas_left).offset(-1);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(32);
    }];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addButton);
        make.right.equalTo(self.inputTF.mas_left).offset(-1);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(32);
    }];
    
    //提货价
    [self.pickupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.preferenceView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(42);
    }];
    
    [self.guidePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pickupView.mas_left).offset(16);
        make.height.mas_equalTo(22);
        make.centerY.equalTo(self.pickupView);
    }];
    
    [self.guidePriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.guidePriceLabel.mas_right).offset(6);
        make.height.mas_equalTo(22);
        make.centerY.equalTo(self.pickupView);
    }];
    
    [self.promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickupView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self.promptView);
    }];
    
    CGFloat bottom = 9;
    if (GK_SAFEAREA_BTM > 0) {
        bottom = GK_SAFEAREA_BTM;
    }
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.weixinLabel.mas_top).offset(-8);
        make.width.height.mas_equalTo(56);
    }];
    
    [self.weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bottom);
        make.centerX.equalTo(self);
    }];
}

#pragma mark - Actions
-(void)closeAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changePriceView:closeClick:)]) {
        [self.delegate changePriceView:self closeClick:sender];
    }
}

-(void)shareAction:(UIButton *)sender{
    
}

-(void)preferenceAction:(UIButton *)sender{
    
}

-(void)reduceAction:(UIButton *)sender{
    NSUInteger currentPrice = [_inputTF.text integerValue];
    if (currentPrice <= [_model.staffPrice integerValue]) {
        sender.enabled = NO;
        return;
    }
    sender.enabled = YES;
    currentPrice = currentPrice - 1;
    self.inputTF.text = [NSString stringWithFormat:@"%lu",(unsigned long)currentPrice];
    
    if (currentPrice >= [_model.marketPrice integerValue]) {
        _addButton.enabled = NO;
    }else{
        _addButton.enabled = YES;
    }
}

-(void)addAction:(UIButton *)sender{
    NSUInteger currentPrice = [_inputTF.text integerValue];
    if (currentPrice >= [_model.marketPrice integerValue]) {
        sender.enabled = NO;
        return;
    }
    sender.enabled = YES;
    currentPrice = currentPrice + 1;
    self.inputTF.text = [NSString stringWithFormat:@"%lu",(unsigned long)currentPrice];
    
    if (currentPrice <= [_model.staffPrice integerValue]) {
        _reduceButton.enabled = NO;
    }else{
        _reduceButton.enabled = YES;
    }
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSUInteger currentPrice = [_inputTF.text integerValue];
    if (currentPrice <= [_model.staffPrice integerValue]) {
        textField.text = [NSString stringWithFormat:@"%@",_model.staffPrice];
    }
    
    if (currentPrice >= [_model.marketPrice integerValue]) {
        textField.text = [NSString stringWithFormat:@"%@",_model.marketPrice];
    }
}

#pragma mark - Getter
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:KImageMake(@"mall_detail_close") forState:UIControlStateNormal];
        [_closeButton setImage:KImageMake(@"mall_detail_close") forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = KRegularFont(16);
        _titleLabel.text = @"修改商品价格";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)retailView{
    if (!_retailView) {
        _retailView = [[UIView alloc] init];
        _retailView.backgroundColor = KHexColor(@"#FF4D49");
    }
    return _retailView;
}

-(UILabel *)retailLabel{
    if (!_retailLabel) {
        _retailLabel = [[UILabel alloc] init];
        _retailLabel.textColor = KWhiteColor;
        _retailLabel.font = KRegularFont(14);
        _retailLabel.text = @"统一零售价 ¥";
        _retailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _retailLabel;
}

-(UIView *)preferenceView{
    if (!_preferenceView) {
        _preferenceView = [[UIView alloc] init];
        _preferenceView.backgroundColor = KWhiteColor;
    }
    return _preferenceView;
}

-(UIButton *)preferenceButton{
    if (!_preferenceButton) {
        _preferenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preferenceButton setImage:KImageMake(@"mall_detail_normal") forState:UIControlStateNormal];
        [_preferenceButton setImage:KImageMake(@"mall_detail_selected") forState:UIControlStateSelected];
        [_preferenceButton addTarget:self action:@selector(preferenceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _preferenceButton;
}

-(UILabel *)preferenceLabel{
    if (!_preferenceLabel) {
        _preferenceLabel = [[UILabel alloc] init];
        _preferenceLabel.textColor = KTextColor;
        _preferenceLabel.font = KRegularFont(14);
        _preferenceLabel.text = @"代理特惠价";
        _preferenceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _preferenceLabel;
}

-(UILabel *)adjustLabel{
    if (!_adjustLabel) {
        _adjustLabel = [[UILabel alloc] init];
        _adjustLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _adjustLabel.font = KRegularFont(9);
        _adjustLabel.text = @"可调整区间 ￥";
        _adjustLabel.textAlignment = NSTextAlignmentRight;
    }
    return _adjustLabel;
}

-(UIButton *)reduceButton{
    if (!_reduceButton) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setImage:KImageMake(@"mall_detail_reduce_able") forState:UIControlStateNormal];
        [_reduceButton setImage:KImageMake(@"mall_detail_reduce_disable") forState:UIControlStateDisabled];
        [_reduceButton addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceButton;
}

-(UITextField *)inputTF{
    if (!_inputTF) {
        _inputTF = [[UITextField alloc] init];
        _inputTF.textColor = KTextColor;
        _inputTF.font = KRegularFont(14);
        _inputTF.backgroundColor = KHexColor(@"#F4F4F4");
        _inputTF.keyboardType = UIKeyboardTypeNumberPad;
        _inputTF.textAlignment = NSTextAlignmentCenter;
        _inputTF.delegate = self;
    }
    return _inputTF;
}

-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:KImageMake(@"mall_detail_add") forState:UIControlStateNormal];
        [_addButton setImage:KImageMake(@"mall_detail_add_disable") forState:UIControlStateDisabled];
        [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

-(UIView *)pickupView{
    if (!_pickupView) {
        _pickupView = [[UIView alloc] init];
        _pickupView.backgroundColor = KHexAlphaColor(@"#F9AB50", 0.2);
    }
    return _pickupView;
}

-(UILabel *)guidePriceLabel{
    if (!_guidePriceLabel) {
        _guidePriceLabel = [[UILabel alloc] init];
        _guidePriceLabel.textColor = KTextColor;
        _guidePriceLabel.font = KRegularFont(14);
        _guidePriceLabel.text = @"提货价";
        _guidePriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _guidePriceLabel;
}

-(UILabel *)guidePriceValueLabel{
    if (!_guidePriceValueLabel) {
        _guidePriceValueLabel = [[UILabel alloc] init];
        _guidePriceValueLabel.textColor = KMainColor;
        _guidePriceValueLabel.font = KRegularFont(14);
        _guidePriceValueLabel.text = @"¥";
        _guidePriceValueLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _guidePriceValueLabel;
}

-(UIView *)promptView{
    if (!_promptView) {
        _promptView = [[UIView alloc] init];
        _promptView.backgroundColor = KHexColor(@"#FFF5F5");
    }
    return _promptView;
}

-(UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.textColor = KTextColor;
        _promptLabel.font = KRegularFont(12);
        _promptLabel.text = @"*转发出去的页面不会透露提货价，请放心转";
        _promptLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLabel;
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:KImageMake(@"mall_detail_share") forState:UIControlStateNormal];
        [_shareButton setImage:KImageMake(@"mall_detail_share") forState:UIControlStateHighlighted];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

-(UILabel *)weixinLabel{
    if (!_weixinLabel) {
        _weixinLabel = [[UILabel alloc] init];
        _weixinLabel.textColor = KTextColor;
        _weixinLabel.font = KRegularFont(12);
        _weixinLabel.text = @"微信";
        _weixinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weixinLabel;
}

-(void)setModel:(TSGoodDetailItemPriceModel *)model{
    _model = model;
    _retailLabel.text = [NSString stringWithFormat:@"¥%@",model.marketPrice];
    _guidePriceValueLabel.text = [NSString stringWithFormat:@"¥%@",model.staffPrice];
    _adjustLabel.text = [NSString stringWithFormat:@"可调整区间 ￥%@-%@",model.staffPrice,model.marketPrice];
    _inputTF.text = [NSString stringWithFormat:@"%@",model.marketPrice];
    _addButton.enabled = NO;
}


@end
