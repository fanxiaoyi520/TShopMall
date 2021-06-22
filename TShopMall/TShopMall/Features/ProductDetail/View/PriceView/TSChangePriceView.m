//
//  TSChangePriceView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import "TSChangePriceView.h"

@interface TSChangePriceView()

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
/// 提货价
@property(nonatomic, strong) UIView *pickupView;
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
    [self addSubview:self.pickupView];
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
    
    [self.pickupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.preferenceView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(60);
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
    
}

-(void)shareAction:(UIButton *)sender{
    
}

#pragma mark - Getter
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:UIColor.redColor];
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
        _retailLabel.text = @"统一零售价 ¥891999";
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

-(UIView *)pickupView{
    if (!_pickupView) {
        _pickupView = [[UIView alloc] init];
        _pickupView.backgroundColor = KHexAlphaColor(@"#F9AB50", 0.2);
    }
    return _pickupView;
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

@end
