//
//  TSProductFooterView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import "TSProductFooterView.h"

@interface TSProductFooterView()

/// 自己买
@property(nonatomic, strong) UIButton *buyButton;
/// 卖别人
@property(nonatomic, strong) UIButton *sellButton;

@end

@implementation TSProductFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    
    [self addSubview:self.buyButton];
    [self addSubview:self.sellButton];
    
    CGFloat bottom = 24;
    if (GK_SAFEAREA_BTM > 0) {
        bottom = GK_SAFEAREA_BTM;
    }
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.right.equalTo(self.mas_centerX);
        make.bottom.equalTo(self).offset(-bottom);
        make.height.mas_equalTo(40);
    }];
    
    [self.sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self).offset(-25);
        make.bottom.equalTo(self).offset(-bottom);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - Action
-(void)addAction:(UIButton *)sender{
    if (self.cartBlock) {
        self.cartBlock();
    }
}

-(void)buyAction:(UIButton *)sender{
    if (self.buyBlock) {
        self.buyBlock();
    }
}

#pragma mark - Getter
-(UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        _buyButton.titleLabel.font = KRegularFont(16);
        [_buyButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_buyButton setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
        [_buyButton setBackgroundColor:[UIColor orangeColor]];
        [_buyButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton setCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) radius:20];
    }
    return _buyButton;
}

-(UIButton *)sellButton{
    if (!_sellButton) {
        _sellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sellButton setTitle:@"立即购买" forState:UIControlStateNormal];
        _sellButton.titleLabel.font = KRegularFont(16);
        [_sellButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_sellButton setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
        [_sellButton setBackgroundColor:[UIColor redColor]];
        [_sellButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sellButton setCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:20];
    }
    return _sellButton;
}

@end
