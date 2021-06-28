//
//  TSProductDetailBottomView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailBottomView.h"


@interface TSProductDetailBottomView()

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIView *buyView;

/// 商城
@property(nonatomic, strong) TSDetailFunctionButton *mallButton;
/// 客服
@property(nonatomic, strong) TSDetailFunctionButton *customButton;
/// 加入购物车
@property(nonatomic, strong) TSDetailFunctionButton *addButton;
/// 自己买
@property(nonatomic, strong) UIButton *buyButton;
/// 卖别人
@property(nonatomic, strong) UIButton *sellButton;

@end

@implementation TSProductDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(54);
    }];
    
    [self.contentView addSubview:self.mallButton];
    [self.contentView addSubview:self.customButton];
    [self.contentView addSubview:self.addButton];
    [self.contentView addSubview:self.buyView];
    [self.buyView addSubview:self.buyButton];
    [self.buyView addSubview:self.sellButton];
    
    [self.mallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(20);
        make.top.equalTo(self.contentView).offset(12);
    }];
    
    [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mallButton.mas_right).offset(22);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(20);
        make.top.equalTo(self.contentView).offset(12);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.customButton.mas_right).offset(12);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(50);
        make.top.equalTo(self.contentView).offset(12);
    }];
    
    [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addButton.mas_right).offset(11);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self.addButton);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buyView.mas_left);
        make.right.equalTo(self.buyView.mas_centerX);
        make.top.bottom.equalTo(self.buyView);
    }];
    
    [self.sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buyView.mas_centerX);
        make.right.equalTo(self.buyView);
        make.top.bottom.equalTo(self.buyView);
    }];
}

#pragma mark - Actions
-(void)mallAction:(TSDetailFunctionButton *)sender{
    if ([self.delegate respondsToSelector:@selector(productDetailBottomView:mallClick:)]) {
        [self.delegate productDetailBottomView:self mallClick:sender];
    }
}

-(void)customAction:(TSDetailFunctionButton *)sender{
    if ([self.delegate respondsToSelector:@selector(productDetailBottomView:customClick:)]) {
        [self.delegate productDetailBottomView:self customClick:sender];
    }
}

-(void)addAction:(TSDetailFunctionButton *)sender{
    if ([self.delegate respondsToSelector:@selector(productDetailBottomView:addClick:)]) {
        [self.delegate productDetailBottomView:self addClick:sender];
    }
}

-(void)buyAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(productDetailBottomView:buyClick:)]) {
        [self.delegate productDetailBottomView:self buyClick:sender];
    }
}

-(void)sellAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(productDetailBottomView:sellClick:)]) {
        [self.delegate productDetailBottomView:self sellClick:sender];
    }
}

#pragma mark - Getter
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UIView *)buyView{
    if (!_buyView) {
        _buyView = [[UIView alloc] init];
        _buyView.backgroundColor = [UIColor clearColor];
    }
    return _buyView;
}

-(TSDetailFunctionButton *)mallButton{
    if (!_mallButton) {
        _mallButton = [TSDetailFunctionButton buttonWithType:UIButtonTypeCustom];
        [_mallButton setTitle:@"商城" forState:UIControlStateNormal];
        [_mallButton setImage:KImageMake(@"mall_detail_store") forState:UIControlStateNormal];
        [_mallButton setImage:KImageMake(@"mall_detail_store") forState:UIControlStateHighlighted];
        [_mallButton addTarget:self action:@selector(mallAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mallButton;
}

-(TSDetailFunctionButton *)customButton{
    if (!_customButton) {
        _customButton = [TSDetailFunctionButton buttonWithType:UIButtonTypeCustom];
        [_customButton setTitle:@"客服" forState:UIControlStateNormal];
        [_customButton setImage:KImageMake(@"mall_detail_customer") forState:UIControlStateNormal];
        [_customButton setImage:KImageMake(@"mall_detail_customer") forState:UIControlStateHighlighted];
        [_customButton addTarget:self action:@selector(customAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

-(TSDetailFunctionButton *)addButton{
    if (!_addButton) {
        _addButton = [TSDetailFunctionButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addButton setImage:KImageMake(@"mall_detail_addCart") forState:UIControlStateNormal];
        [_addButton setImage:KImageMake(@"mall_detail_addCart") forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

-(UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setTitle:@"自己买" forState:UIControlStateNormal];
        _buyButton.titleLabel.font = KRegularFont(16);
        [_buyButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_buyButton setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
        [_buyButton setBackgroundColor:[UIColor orangeColor]];
        [_buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton setCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) radius:20];
    }
    return _buyButton;
}

-(UIButton *)sellButton{
    if (!_sellButton) {
        _sellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sellButton setTitle:@"卖别人" forState:UIControlStateNormal];
        _sellButton.titleLabel.font = KRegularFont(16);
        [_sellButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_sellButton setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
        [_sellButton setBackgroundColor:[UIColor redColor]];
        [_sellButton addTarget:self action:@selector(sellAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sellButton setCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:20];
    }
    return _sellButton;
}

@end
