//
//  TSPayOrderViewController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSPayOrderViewController.h"

@interface TSPayOrderViewController ()
/** top视图 */
@property(nonatomic, weak) UIView *topView;
/** 背景模糊图片 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 提交按钮 */
@property(nonatomic, weak) UIButton *commitButton;
/** back按钮 */
@property(nonatomic, weak) UIButton *backButton;
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 倒计时图标  */
@property(nonatomic, weak) UIImageView *timerImgV;
/** 支付金额  */
@property(nonatomic, weak) UILabel *payAmountLabel;
/** 时间倒计时视图 */
@property(nonatomic, weak) UIButton *showTimeButton;
/** 支付视图  */
@property(nonatomic, weak) UIView *payView;
/** 支付宝支付视图  */
@property(nonatomic, weak) UIView *alipayView;
/** 支付宝图标  */
@property(nonatomic, weak) UIImageView *aliImgV;
/** 支付宝名称  */
@property(nonatomic, weak) UILabel *aliLabel;
/** 支付宝check按钮  */
@property(nonatomic, weak) UIButton *alipayButton;
/** 微信支付视图  */
@property(nonatomic, weak) UIView *wechatView;
/** 微信图标  */
@property(nonatomic, weak) UIImageView *wechatImgV;
/** 微信名称  */
@property(nonatomic, weak) UILabel *wechatLabel;
/** 微信check按钮  */
@property(nonatomic, weak) UIButton *wechatButton;

@end

@implementation TSPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)fillCustomView {
    [super fillCustomView];
    ///设置约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(197 + self.view.ts_safeAreaInsets.top);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_top).with.offset(GK_STATUSBAR_NAVBAR_HEIGHT - 34);
        make.left.equalTo(self.topView.mas_left).with.offset(20);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(28);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton.mas_centerY).with.offset(0);
        make.centerX.equalTo(self.topView.mas_centerX).with.offset(0);
    }];
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).with.offset(0);
        make.top.equalTo(self.topView.mas_top).with.offset(0);
        make.right.equalTo(self.topView.mas_right).with.offset(0);
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(0);
    }];
    [self.showTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(-47);
        make.centerX.equalTo(self.topView.mas_centerX).with.offset(0);
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(24);
    }];
    [self.payAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.showTimeButton.mas_bottom).with.offset(-17);
        make.centerX.equalTo(self.showTimeButton.mas_centerX).with.offset(0);
    }];
    [self.timerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payAmountLabel.mas_left).with.offset(-8);
        make.centerY.equalTo(self.payAmountLabel.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(20);
    }];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(-21);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.commitButton.mas_top).with.offset(0);
    }];
    [self.alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payView.mas_top).with.offset(0);
        make.left.equalTo(self.payView.mas_left).with.offset(0);
        make.right.equalTo(self.payView.mas_right).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.aliImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alipayView.mas_left).with.offset(30);
        make.centerY.equalTo(self.alipayView.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(20);
    }];
    [self.aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aliImgV.mas_right).with.offset(10);
        make.centerY.equalTo(self.alipayView.mas_centerY).with.offset(0);
    }];
    [self.alipayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.alipayView.mas_right).with.offset(30);
        make.centerY.equalTo(self.alipayView.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(24);
    }];
    [self.wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alipayView.mas_bottom).with.offset(0);
        make.left.equalTo(self.payView.mas_left).with.offset(0);
        make.right.equalTo(self.payView.mas_right).with.offset(0);
        make.height.mas_equalTo(56);
    }];
    [self.wechatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wechatView.mas_left).with.offset(30);
        make.centerY.equalTo(self.wechatView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(17.5);
    }];
    [self.wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wechatImgV.mas_right).with.offset(10);
        make.centerY.equalTo(self.wechatView.mas_centerY).with.offset(0);
    }];
    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wechatView.mas_right).with.offset(30);
        make.centerY.equalTo(self.wechatView.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(24);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-48);
        make.height.mas_equalTo(41);
    }];
}


- (UIView *)topView {
    if (_topView == nil) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        UIButton *backButton = [[UIButton alloc] init];
        _backButton = backButton;
        [_backButton setBackgroundImage:KImageMake(@"mall_white_naviback") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_backButton];
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KWhiteColor;
        _titleLabel.font = KRegularFont(18);
        _titleLabel.text = @"支付订单";
        [self.topView addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (UIButton *)commitButton {
    if (_commitButton == nil) {
        UIButton *commitButton = [[UIButton alloc] init];
        _commitButton = commitButton;
        _commitButton.backgroundColor = KHexColor(@"#FF4D49");
        [_commitButton setCorners:UIRectCornerAllCorners radius:20.5];
        _commitButton.clipsToBounds = YES;
        _commitButton.titleLabel.font = KRegularFont(16);
        _commitButton.enabled = NO;
        [_commitButton setTitle:@"确定付款" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_commitButton];
    }
    return _commitButton;
}

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_pay_bg");
        [self.topView insertSubview:_bgImgV atIndex:0];
    }
    return _bgImgV;
}

- (UIButton *)showTimeButton {
    if (_showTimeButton == nil) {
        UIButton *showTimeButton = [[UIButton alloc] init];
        _showTimeButton = showTimeButton;
        _showTimeButton.enabled = NO;
        [_showTimeButton setCorners:UIRectCornerAllCorners radius:12];
        _showTimeButton.titleLabel.font = KRegularFont(12);
        [_showTimeButton setTitle:@"支付剩余时间14:50:00" forState:UIControlStateNormal];
        [_showTimeButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _showTimeButton.backgroundColor = KHexAlphaColor(@"#FFFFFF", 0.2);
        [self.topView addSubview:_showTimeButton];
    }
    return _showTimeButton;
}

- (UIImageView *)timerImgV {
    if (_timerImgV == nil) {
        UIImageView *timerImgV = [[UIImageView alloc] init];
        _timerImgV = timerImgV;
        _timerImgV.image = KImageMake(@"mall_pay_timer");
        [self.topView addSubview: _timerImgV];
    }
    return _timerImgV;
}

- (UILabel *)payAmountLabel {
    if (_payAmountLabel == nil) {
        UILabel *payAmountLabel = [[UILabel alloc] init];
        _payAmountLabel = payAmountLabel;
        _payAmountLabel.text = @"￥3599.00";
        _payAmountLabel.textColor = KWhiteColor;
        _payAmountLabel.font = KFont(PingFangSCMedium, 20);
        [self.topView addSubview: _payAmountLabel];
    }
    return _payAmountLabel;
}

- (UIView *)payView {
    if (_payView == nil) {
        UIView *payView = [[UIView alloc] init];
        _payView = payView;
        _payView.clipsToBounds = YES;
        [_payView setCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:12];
        [self.view insertSubview:_payView aboveSubview:self.topView];
    }
    return _payView;
}

- (UIView *)alipayView {
    if (_alipayView == nil) {
        UIView *alipayView = [[UIView alloc] init];
        _alipayView = alipayView;
        [self.view addSubview: _alipayView];
    }
    return _alipayView;
}

- (UIImageView *)aliImgV {
    if (_aliImgV == nil) {
        UIImageView *aliImgV = [[UIImageView alloc] init];
        _aliImgV = aliImgV;
        _aliImgV.image = KImageMake(@"mall_pay_alipay");
        [self.aliImgV addSubview: _aliImgV];
    }
    return _aliImgV;
}

- (UILabel *)aliLabel {
    if (_aliLabel == nil) {
        UILabel *aliLabel = [[UILabel alloc] init];
        _aliLabel = aliLabel;
        _aliLabel.text = @"支付宝";
        _aliLabel.font = KRegularFont(14);
        _aliLabel.textColor = KTextColor;
        [self.alipayView addSubview: _aliLabel];
    }
    return _aliLabel;
}

- (UIButton *)alipayButton {
    if (_alipayButton == nil) {
        UIButton *alipayButton = [[UIButton alloc] init];
        _alipayButton = alipayButton;
        [_alipayButton setBackgroundImage:KImageMake(@"mall_pay_uncheck") forState:(UIControlStateNormal)];
        [_alipayButton setBackgroundImage:KImageMake(@"mall_pay_checked") forState:(UIControlStateSelected)];
        [_alipayButton addTarget:self action:@selector(alipay) forControlEvents:(UIControlEventTouchUpInside)];
        [self.alipayView addSubview: _alipayButton];
    }
    return _alipayButton;
}

- (UIButton *)wechatButton {
    if (_wechatButton == nil) {
        UIButton *wechatButton = [[UIButton alloc] init];
        _wechatButton = wechatButton;
        [_wechatButton setBackgroundImage:KImageMake(@"mall_pay_uncheck") forState:(UIControlStateNormal)];
        [_wechatButton setBackgroundImage:KImageMake(@"mall_pay_checked") forState:(UIControlStateSelected)];
        [_wechatButton addTarget:self action:@selector(wechat) forControlEvents:(UIControlEventTouchUpInside)];
        [self.wechatView addSubview: _wechatButton];
    }
    return _wechatButton;
}

- (UILabel *)wechatLabel {
    if (_wechatLabel == nil) {
        UILabel *wechatLabel = [[UILabel alloc] init];
        _wechatLabel = wechatLabel;
        _wechatLabel.text = @"微信支付";
        _wechatLabel.font = KRegularFont(14);
        _wechatLabel.textColor = KTextColor;
        [self.wechatView addSubview: _wechatLabel];
    }
    return _wechatLabel;
}

- (UIImageView *)wechatImgV {
    if (_wechatImgV == nil) {
        UIImageView *wechatImgV = [[UIImageView alloc] init];
        _wechatImgV = wechatImgV;
        _wechatImgV.image = KImageMake(@"mall_pay_wechat");
        [self.wechatView addSubview: _wechatImgV];
    }
    return _wechatImgV;
}

- (UIView *)wechatView {
    if (_wechatView == nil) {
        UIView *wechatView = [[UIView alloc] init];
        _wechatView = wechatView;
        [self.view addSubview: _wechatView];
    }
    return _wechatView;
}

#pragma mark - Actions
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
/** 确定付款 */
- (void)commitAction {
    
}
/** 选中支付宝支付 */
- (void)alipay {
    if (!self.alipayButton.selected) {
        self.alipayButton.selected = YES;
        self.wechatButton.selected = NO;
    }
}

/** 选中微信支付 */
- (void)wechat {
    if (!self.wechatButton.selected) {
        self.alipayButton.selected = NO;
        self.wechatButton.selected = YES;
    }
}

@end
