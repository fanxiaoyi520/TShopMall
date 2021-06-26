//
//  TSProductHeaderView.m
//  TSale
//
//  Created by Daisy  on 2020/12/9.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSProductHeaderView.h"


@interface TSProductHeaderView()<UITextFieldDelegate>

/// 商品图片
@property (nonatomic, strong) UIImageView *iconImge;
/// 关闭弹窗按钮
@property (nonatomic, strong) UIButton *closeBtn;
/// 价格
@property (nonatomic, strong) UILabel *priceLable;
/// 已选参数
@property (nonatomic, strong) UILabel *selectedCount;
/// 库存状态
@property (nonatomic, strong) UILabel *statusLable;
/// 数量
@property(nonatomic, strong) UILabel *numLabel;
/// 减
@property(nonatomic, strong) UIButton *reduceButton;
/// 加
@property(nonatomic, strong) UIButton *addButton;
/// 输入
@property(nonatomic, strong) UITextField *inputTF;

@end

@implementation TSProductHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeConstraintsUI];
    }
    return self;
}

#pragma mark -UI布局
-(void)makeConstraintsUI {
    [self addSubview:self.iconImge];
    [self addSubview:self.closeBtn];
    [self addSubview:self.statusLable];
//    [self addSubview:self.selectedCount];
    [self addSubview:self.priceLable];
    [self addSubview:self.numLabel];
    [self addSubview:self.addButton];
    [self addSubview:self.inputTF];
    [self addSubview:self.reduceButton];
    
    [self.iconImge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88, 88));
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(16);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self.mas_right).offset(-18);
        make.top.equalTo(self.mas_top).offset(18);
    }];

    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImge);
        make.height.equalTo(@(28));
        make.left.equalTo(self.iconImge.mas_right).offset(8);
    }];
    
//    [self.selectedCount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.priceLable);
//        make.right.equalTo(self.mas_right).offset(-10);
//        make.top.equalTo(self.priceLable.mas_bottom).offset(4);
//        make.height.equalTo(@(22));
//    }];

    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLable);
        make.bottom.equalTo(self.iconImge);
        make.height.equalTo(@(22));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImge.mas_bottom).offset(50);
        make.right.equalTo(self).offset(1);
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
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.addButton);
    }];
}

#pragma mark - Actions
-(void)closePopupEvent:(UIButton *)sender{
    
}

-(void)reduceAction:(UIButton *)sender{
    NSUInteger current = [self.inputTF.text integerValue];
    if (current <= 1) {
        sender.enabled = NO;
        [Popover popToastOnWindowWithText:@"不能在少了"];
        return;
    }
    sender.enabled = YES;
    current = current - 1;
    self.inputTF.text = [NSString stringWithFormat:@"%ld",current];
}

-(void)addAction:(UIButton *)sender{
    if ([self.inputTF.text integerValue] >= self.purchaseModel.totalNum) {
        sender.enabled = NO;
        return;
    }
    sender.enabled = YES;
    NSUInteger current = [self.inputTF.text integerValue];
    current = current + 1;
    self.inputTF.text = [NSString stringWithFormat:@"%ld",current];
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{

}

#pragma mark - Getter
-(UIImageView *)iconImge{
    if (!_iconImge) {
        _iconImge = [UIImageView new];
        _iconImge.layer.cornerRadius = 8;
        _iconImge.clipsToBounds = YES;
    }
    return _iconImge;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:KImageMake(@"mall_detail_close") forState:UIControlStateNormal];
        [_closeBtn setBackgroundImage:KImageMake(@"mall_detail_close") forState:UIControlStateHighlighted];
        [_closeBtn addTarget:self action:@selector(closePopupEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UILabel *)priceLable{
    if (!_priceLable) {
        _priceLable = [UILabel new];
        _priceLable.textColor = KMainColor;
        _priceLable.textAlignment = NSTextAlignmentCenter;
        _priceLable.text = @"¥";
    }
    return _priceLable;
}

-(UILabel *)selectedCount{
    if (!_selectedCount) {
        _selectedCount = [UILabel new];
        _selectedCount.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        _selectedCount.font = KRegularFont(14);
        _selectedCount.text = @"已选：75寸";
    }
    return _selectedCount;
}

-(UILabel *)statusLable{
    if (!_statusLable) {
        _statusLable = [UILabel new];
        _statusLable.textColor = KMainColor;
        _statusLable.font = KRegularFont(14.0);
        _statusLable.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _statusLable.text = @"尺寸";
        _statusLable.backgroundColor = [UIColor clearColor];
    }
    return _statusLable;;
}


-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.textAlignment  = NSTextAlignmentLeft;
        _numLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _numLabel.font = KRegularFont(14.0);
        _numLabel.text = @"数量";
    }
    return _numLabel;;
}

-(UIButton *)reduceButton{
    if (!_reduceButton) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setImage:KImageMake(@"mall_detail_reduce_able") forState:UIControlStateNormal];
        [_reduceButton setImage:KImageMake(@"mall_detail_reduce_able") forState:UIControlStateHighlighted];
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
        _inputTF.textAlignment = NSTextAlignmentCenter;
        _inputTF.delegate = self;
        _inputTF.text = @"1";
    }
    return _inputTF;
}

-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:KImageMake(@"mall_detail_add") forState:UIControlStateNormal];
        [_addButton setImage:KImageMake(@"mall_detail_add") forState:UIControlStateHighlighted];
        [_addButton setImage:KImageMake(@"mall_detail_add_disable") forState:UIControlStateDisabled];
        [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setBackgroundColor:UIColor.redColor];
    }
    return _addButton;
}

-(void)setPurchaseModel:(TSGoodDetailItemPurchaseModel *)purchaseModel{
    _purchaseModel = purchaseModel;
    [_iconImge sd_setImageWithURL:[NSURL URLWithString:purchaseModel.iconUrl]];
    _priceLable.text = [NSString stringWithFormat:@"¥%@",purchaseModel.price];
    
}

@end
