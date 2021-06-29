//
//  TSPayController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSPayController.h"
#import "TSPayChannelItem.h"
#import "TSPayTimeView.h"
#import "TSPayInfoDataController.h"
#import "TSPayStyleDataController.h"
#import "TSPayDataController.h"
#import "WechatPayManager.h"
#import "TSPaySuccessController.h"

@interface TSPayController(){
    TSPayStyleModel *currentPayStyle;
}
@property (nonatomic, strong) TSPayTimeView *timeView;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) UIButton *mockPayBtn;
@property (nonatomic, strong) UIView *payStyleBackView;
@property (nonatomic, strong) TSPayInfoDataController *payInfoDataCon;
@property (nonatomic, strong) TSPayStyleDataController *payStyleDataCon;
@property (nonatomic, strong) TSPayDataController *payDataCon;

@end

@implementation TSPayController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self fetchData];
}

- (void)setupNavigationBar{
    self.gk_navTitle = @"支付订单";
    self.gk_backImage = KImageMake(@"mall_white_naviback");
    self.gk_navTitleFont = KRegularFont(18);
    self.gk_navTitleColor = KWhiteColor;
    self.gk_navigationBar.gk_navBarBackgroundAlpha = 0;
    self.gk_navigationBar.layer.zPosition = 1;
}

- (void)fetchData{
    __weak typeof(self) weakSelf = self;
    [self.payInfoDataCon fetchPayInfo:self.payOrderId isGroup:self.isGroup finished:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.timeView updateOrederPriec:weakSelf.payInfoDataCon.totalPayMoney];
            [weakSelf.timeView orderCurrentTime:weakSelf.payInfoDataCon.currentTimestamp endTime:weakSelf.payInfoDataCon.payEndTimestamp];
            [weakSelf updatePayBtnWithPrice:weakSelf.payInfoDataCon.totalPayMoney];
        }
    }];
    [self.payStyleDataCon fetchPayStyle:self.payOrderId finished:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf setUpPayStyles];
        }
    }];
}


//支付
- (void)pay{
    __weak typeof(self) weakSelf = self;
    self.payDataCon.orderId = self.payOrderId;
    self.payDataCon.payChannel = currentPayStyle.payChannel;
    [self.payDataCon goToPay:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf awakeAppToCompletePay];
        }
    }];
}

- (void)awakeAppToCompletePay{
    if ([currentPayStyle.channelName containsString:@"微信"]) {
        [WechatPayManager payWithParamas:self.payDataCon.awakeAppInfo paySuccess:^(BOOL paySuccess) {
            if (paySuccess) {
                [self paySuccess];
            } else {
                
            }
        }];
    } else if ([currentPayStyle.channelName containsString:@"支付宝"]) {
        
    } else if ([currentPayStyle.channelName containsString:@"TCL分期"]) {
        
    }
}

- (void)paySuccess{
    TSPaySuccessController *con = [TSPaySuccessController new];
    con.orderId = self.payOrderId;
    [self.navigationController pushViewController:con animated:YES];
}

- (void)updatePayBtnWithPrice:(NSString *)price{
    price = [NSString stringWithFormat:@"确定付款 ¥%@", price];
    [self.payBtn setTitle:price forState:UIControlStateNormal];
    
    price = [NSString stringWithFormat:@"模拟付款 ¥%@", price];
    [self.mockPayBtn setTitle:price forState:UIControlStateNormal];
}

- (void)payStyleChanged:(TSPayChannelItem *)sender{
    if (sender.selected == YES) {
        return;
    }
    for (UIView *view in self.payStyleBackView.subviews) {
        if ([view isKindOfClass:[TSPayChannelItem class]]) {
            TSPayChannelItem *item = (TSPayChannelItem *)view;
            if (item.tag == sender.tag) {
                item.selected = YES;
                currentPayStyle = item.model;
            } else {
                item.selected = NO;
            }
        }
    }
}

- (void)setUpPayStyles{
    for (NSInteger i=0; i<self.payStyleDataCon.payStyles.count; i++) {
        TSPayChannelItem *item = [TSPayChannelItem new];
        item.model = self.payStyleDataCon.payStyles[i];
        item.tag = i;
        [self.payStyleBackView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.payStyleBackView);
            make.top.equalTo(self.payStyleBackView.mas_top).offset(KRateW(20.0) + KRateW(44.0)*i);
            make.height.mas_offset(KRateW(44.0));
        }];
        if (i == 0) {
            item.selected = YES;
            currentPayStyle = self.payStyleDataCon.payStyles[i];
        }
        
        [item addTarget:self action:@selector(payStyleChanged:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewWillLayoutSubviews{
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(KRateW(120.0) + GK_STATUSBAR_NAVBAR_HEIGHT);
    }];
    
    [self.payStyleBackView setCorners:(UIRectCornerTopRight|UIRectCornerTopLeft) radius:KRateW(12.0)];
    [self.payStyleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.timeView.mas_bottom).offset(-KRateW(10.0));
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRateW(24.0));
        make.right.equalTo(self.view.mas_right).offset(-KRateW(24.0));
        make.height.mas_equalTo(KRateW(44.0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-GK_SAFEAREA_BTM-KRateW(48.0));
    }];
    
    [self.mockPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRateW(24.0));
        make.right.equalTo(self.view.mas_right).offset(-KRateW(24.0));
        make.height.mas_equalTo(KRateW(44.0));
        make.bottom.equalTo(self.payBtn.mas_top).offset(-KRateW(24.0));
    }];
}

- (TSPayTimeView *)timeView{
    if (_timeView) {
        return  _timeView;
    }
    self.timeView = [TSPayTimeView new];
    [self.view addSubview:self.timeView];

    return self.timeView;
}

- (UIButton *)payBtn{
    if (_payBtn) {
        return _payBtn;
    }
    self.payBtn = [[UIButton alloc] init];
    [self.payBtn setTitle:@"确定付款" forState:UIControlStateNormal];
    self.payBtn.backgroundColor = KHexColor(@"#FF4D49");
    self.payBtn.layer.cornerRadius = KRateW(22.0);
    self.payBtn.layer.masksToBounds = YES;
    self.payBtn.clipsToBounds = YES;
    self.payBtn.titleLabel.font = KRegularFont(16);
    [self.payBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payBtn];
    
    return self.payBtn;
}

- (UIView *)payStyleBackView{
    if (_payStyleBackView) {
        return _payStyleBackView;
    }
    self.payStyleBackView = [UIView new];
    self.payStyleBackView.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:self.payStyleBackView];
    
    return self.payStyleBackView;
}

- (TSPayInfoDataController *)payInfoDataCon{
    if (_payInfoDataCon) {
        return _payInfoDataCon;
    }
    self.payInfoDataCon = [TSPayInfoDataController new];
    self.payInfoDataCon.context = self;
    
    return self.payInfoDataCon;
}

- (TSPayStyleDataController *)payStyleDataCon{
    if (_payStyleDataCon) {
        return _payStyleDataCon;
    }
    self.payStyleDataCon = [TSPayStyleDataController new];
    self.payStyleDataCon.context = self;
    
    return self.payStyleDataCon;
}

- (TSPayDataController *)payDataCon{
    if (_payDataCon) {
        return _payDataCon;
    }
    self.payDataCon = [TSPayDataController new];
    self.payDataCon.context = self;
    
    return self.payDataCon;
}

- (UIButton *)mockPayBtn{
    if (_mockPayBtn) {
        return _mockPayBtn;
    }
    self.mockPayBtn = [[UIButton alloc] init];
    [self.mockPayBtn setTitle:@"模拟付款" forState:UIControlStateNormal];
    self.mockPayBtn.backgroundColor = KHexColor(@"#FF4D49");
    self.mockPayBtn.layer.cornerRadius = KRateW(22.0);
    self.mockPayBtn.layer.masksToBounds = YES;
    self.mockPayBtn.clipsToBounds = YES;
    self.mockPayBtn.titleLabel.font = KRegularFont(16);
    [self.mockPayBtn addTarget:self action:@selector(mockPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mockPayBtn];
    
    return self.mockPayBtn;
}

- (void)mockPay{
    __weak typeof(self) weakSelf = self;
    self.payDataCon.orderId = self.payOrderId;
    self.payDataCon.payChannel = currentPayStyle.payChannel;
    
    //模拟支付
    [self.payDataCon mockPay:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf paySuccess];
        }
    }];
}


@end

//@interface TSPayController ()
///** top视图 */
//@property(nonatomic, weak) UIView *topView;
///** 背景模糊图片 */
//@property(nonatomic, weak) UIImageView *bgImgV;
///** 提交按钮 */
//@property(nonatomic, weak) UIButton *commitButton;
///** 倒计时图标  */
//@property(nonatomic, weak) UIImageView *timerImgV;
///** 支付金额  */
//@property(nonatomic, weak) UILabel *payAmountLabel;
///** 时间倒计时视图 */
//@property(nonatomic, weak) UIButton *showTimeButton;
///** 支付视图  */
//@property(nonatomic, weak) UIView *payView;
///** 支付宝支付视图  */
//@property(nonatomic, weak) UIView *alipayView;
///** 支付宝图标  */
//@property(nonatomic, weak) UIImageView *aliImgV;
///** 支付宝名称  */
//@property(nonatomic, weak) UILabel *aliLabel;
///** 支付宝check按钮  */
//@property(nonatomic, weak) UIButton *alipayButton;
///** 微信支付视图  */
//@property(nonatomic, weak) UIView *wechatView;
///** 微信图标  */
//@property(nonatomic, weak) UIImageView *wechatImgV;
///** 微信名称  */
//@property(nonatomic, weak) UILabel *wechatLabel;
///** 微信check按钮  */
//@property(nonatomic, weak) UIButton *wechatButton;
//
//@end
//
//@implementation TSPayController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.gk_navTitle = @"支付订单";
//    self.gk_backImage = KImageMake(@"mall_white_naviback");
//    self.gk_navTitleFont = KRegularFont(18);
//    self.gk_navTitleColor = KWhiteColor;
//    self.gk_navigationBar.gk_navBarBackgroundAlpha = 0;
//}
//
//- (void)fillCustomView {
//    [super fillCustomView];
//    ///设置约束
//    [self addConstraints];
//}
//
//- (void)addConstraints {
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(0);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.height.mas_equalTo(197 + self.view.ts_safeAreaInsets.top);
//    }];
//    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.topView.mas_left).with.offset(0);
//        make.top.equalTo(self.topView.mas_top).with.offset(0);
//        make.right.equalTo(self.topView.mas_right).with.offset(0);
//        make.bottom.equalTo(self.topView.mas_bottom).with.offset(0);
//    }];
//    [self.showTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.topView.mas_bottom).with.offset(-47);
//        make.centerX.equalTo(self.topView.mas_centerX).with.offset(0);
//        make.width.mas_equalTo(152);
//        make.height.mas_equalTo(24);
//    }];
//    [self.payAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.showTimeButton.mas_top).with.offset(-10);
//        make.centerX.equalTo(self.showTimeButton.mas_centerX).with.offset(10);
//    }];
//    [self.timerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.payAmountLabel.mas_left).with.offset(-8);
//        make.centerY.equalTo(self.payAmountLabel.mas_centerY).with.offset(0);
//        make.width.height.mas_equalTo(20);
//    }];
//    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.topView.mas_bottom).with.offset(-21);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.bottom.equalTo(self.commitButton.mas_top).with.offset(0);
//    }];
//    [self.alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.payView.mas_top).with.offset(0);
//        make.left.equalTo(self.payView.mas_left).with.offset(0);
//        make.right.equalTo(self.payView.mas_right).with.offset(0);
//        make.height.mas_equalTo(56);
//    }];
//    [self.aliImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.alipayView.mas_left).with.offset(30);
//        make.centerY.equalTo(self.alipayView.mas_centerY).with.offset(0);
//        make.width.height.mas_equalTo(24);
//    }];
//    [self.aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.aliImgV.mas_right).with.offset(10);
//        make.centerY.equalTo(self.alipayView.mas_centerY).with.offset(0);
//    }];
//    [self.alipayButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.alipayView.mas_right).with.offset(-30);
//        make.centerY.equalTo(self.alipayView.mas_centerY).with.offset(0);
//        make.width.height.mas_equalTo(24);
//    }];
//    [self.wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.alipayView.mas_bottom).with.offset(0);
//        make.left.equalTo(self.payView.mas_left).with.offset(0);
//        make.right.equalTo(self.payView.mas_right).with.offset(0);
//        make.height.mas_equalTo(56);
//    }];
//    [self.wechatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.wechatView.mas_left).with.offset(30);
//        make.centerY.equalTo(self.wechatView.mas_centerY).with.offset(0);
//        make.width.mas_equalTo(24);
//        make.height.mas_equalTo(24);
//    }];
//    [self.wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.wechatImgV.mas_right).with.offset(10);
//        make.centerY.equalTo(self.wechatView.mas_centerY).with.offset(0);
//    }];
//    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.wechatView.mas_right).with.offset(-30);
//        make.centerY.equalTo(self.wechatView.mas_centerY).with.offset(0);
//        make.width.height.mas_equalTo(24);
//    }];
//    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(25);
//        make.right.equalTo(self.view.mas_right).with.offset(-25);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-48);
//        make.height.mas_equalTo(41);
//    }];
//}
//
//
//- (UIView *)topView {
//    if (_topView == nil) {
//        UIView *topView = [[UIView alloc] init];
//        _topView = topView;
//        [self.view addSubview:_topView];
//    }
//    return _topView;
//}
//
//
//- (UIButton *)commitButton {
//    if (_commitButton == nil) {
//        UIButton *commitButton = [[UIButton alloc] init];
//        _commitButton = commitButton;
//        _commitButton.backgroundColor = KHexColor(@"#FF4D49");
//        [_commitButton setCorners:UIRectCornerAllCorners radius:20.5];
//        _commitButton.clipsToBounds = YES;
//        _commitButton.titleLabel.font = KRegularFont(16);
//        _commitButton.enabled = NO;
//        [_commitButton setTitle:@"确定付款" forState:UIControlStateNormal];
//        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_commitButton];
//    }
//    return _commitButton;
//}
//
//- (UIImageView *)bgImgV {
//    if (_bgImgV == nil) {
//        UIImageView *bgImgV = [[UIImageView alloc] init];
//        _bgImgV = bgImgV;
//        _bgImgV.image = KImageMake(@"mall_pay_bg");
//        [self.topView insertSubview:_bgImgV atIndex:0];
//    }
//    return _bgImgV;
//}
//
//- (UIButton *)showTimeButton {
//    if (_showTimeButton == nil) {
//        UIButton *showTimeButton = [[UIButton alloc] init];
//        _showTimeButton = showTimeButton;
//        _showTimeButton.enabled = NO;
//        [_showTimeButton setCorners:UIRectCornerAllCorners radius:12];
//        _showTimeButton.titleLabel.font = KRegularFont(12);
//        [_showTimeButton setTitle:@"支付剩余时间14:50:00" forState:UIControlStateNormal];
//        [_showTimeButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
//        _showTimeButton.backgroundColor = KHexAlphaColor(@"#FFFFFF", 0.2);
//        [self.topView addSubview:_showTimeButton];
//    }
//    return _showTimeButton;
//}
//
//- (UIImageView *)timerImgV {
//    if (_timerImgV == nil) {
//        UIImageView *timerImgV = [[UIImageView alloc] init];
//        _timerImgV = timerImgV;
//        _timerImgV.image = KImageMake(@"mall_pay_timer");
//        [self.topView addSubview: _timerImgV];
//    }
//    return _timerImgV;
//}
//
//- (UILabel *)payAmountLabel {
//    if (_payAmountLabel == nil) {
//        UILabel *payAmountLabel = [[UILabel alloc] init];
//        _payAmountLabel = payAmountLabel;
//        _payAmountLabel.text = @"￥3599.00";
//        _payAmountLabel.textColor = KWhiteColor;
//        _payAmountLabel.font = KFont(PingFangSCMedium, 20);
//        [self.topView addSubview: _payAmountLabel];
//    }
//    return _payAmountLabel;
//}
//
//- (UIView *)payView {
//    if (_payView == nil) {
//        UIView *payView = [[UIView alloc] init];
//        _payView = payView;
//        _payView.clipsToBounds = YES;
//        _payView.backgroundColor = KWhiteColor;
//        [_payView setCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:12];
//        [self.view insertSubview:_payView aboveSubview:self.topView];
//    }
//    return _payView;
//}
//
//- (UIView *)alipayView {
//    if (_alipayView == nil) {
//        UIView *alipayView = [[UIView alloc] init];
//        _alipayView = alipayView;
//        [self.view addSubview: _alipayView];
//    }
//    return _alipayView;
//}
//
//- (UIImageView *)aliImgV {
//    if (_aliImgV == nil) {
//        UIImageView *aliImgV = [[UIImageView alloc] init];
//        _aliImgV = aliImgV;
//        _aliImgV.image = KImageMake(@"mall_pay_alipay");
//        [self.alipayView addSubview: _aliImgV];
//    }
//    return _aliImgV;
//}
//
//- (UILabel *)aliLabel {
//    if (_aliLabel == nil) {
//        UILabel *aliLabel = [[UILabel alloc] init];
//        _aliLabel = aliLabel;
//        _aliLabel.text = @"支付宝";
//        _aliLabel.font = KRegularFont(14);
//        _aliLabel.textColor = KTextColor;
//        [self.alipayView addSubview: _aliLabel];
//    }
//    return _aliLabel;
//}
//
//- (UIButton *)alipayButton {
//    if (_alipayButton == nil) {
//        UIButton *alipayButton = [[UIButton alloc] init];
//        _alipayButton = alipayButton;
//        _alipayButton.selected = YES;
//        [_alipayButton setBackgroundImage:KImageMake(@"mall_pay_uncheck") forState:(UIControlStateNormal)];
//        [_alipayButton setBackgroundImage:KImageMake(@"mall_pay_checked") forState:(UIControlStateSelected)];
//        [_alipayButton addTarget:self action:@selector(alipay) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.alipayView addSubview: _alipayButton];
//    }
//    return _alipayButton;
//}
//
//- (UIButton *)wechatButton {
//    if (_wechatButton == nil) {
//        UIButton *wechatButton = [[UIButton alloc] init];
//        _wechatButton = wechatButton;
//        [_wechatButton setBackgroundImage:KImageMake(@"mall_pay_uncheck") forState:(UIControlStateNormal)];
//        [_wechatButton setBackgroundImage:KImageMake(@"mall_pay_checked") forState:(UIControlStateSelected)];
//        [_wechatButton addTarget:self action:@selector(wechat) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.wechatView addSubview: _wechatButton];
//    }
//    return _wechatButton;
//}
//
//- (UILabel *)wechatLabel {
//    if (_wechatLabel == nil) {
//        UILabel *wechatLabel = [[UILabel alloc] init];
//        _wechatLabel = wechatLabel;
//        _wechatLabel.text = @"微信支付";
//        _wechatLabel.font = KRegularFont(14);
//        _wechatLabel.textColor = KTextColor;
//        [self.wechatView addSubview: _wechatLabel];
//    }
//    return _wechatLabel;
//}
//
//- (UIImageView *)wechatImgV {
//    if (_wechatImgV == nil) {
//        UIImageView *wechatImgV = [[UIImageView alloc] init];
//        _wechatImgV = wechatImgV;
//        _wechatImgV.image = KImageMake(@"mall_pay_wechat");
//        [self.wechatView addSubview: _wechatImgV];
//    }
//    return _wechatImgV;
//}
//
//- (UIView *)wechatView {
//    if (_wechatView == nil) {
//        UIView *wechatView = [[UIView alloc] init];
//        _wechatView = wechatView;
//        [self.view addSubview: _wechatView];
//    }
//    return _wechatView;
//}
//
//#pragma mark - Actions
//- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
//}
///** 确定付款 */
//- (void)commitAction {
//    if (self.alipayButton.selected) {///选中的是支付宝
//        [self gotoAlipay];
//    } else if (self.wechatButton.selected) {///选中的是微信支付
//        [self gotoWechatPay];
//    }
//}
//
///** 去调用支付宝 */
//- (void)gotoAlipay {
//
//}
//
///** 去调用微信支付 */
//- (void)gotoWechatPay {
//
//}
//
//
///** 选中支付宝支付 */
//- (void)alipay {
//    if (!self.alipayButton.selected) {
//        self.alipayButton.selected = YES;
//        self.wechatButton.selected = NO;
//    }
//}
//
///** 选中微信支付 */
//- (void)wechat {
//    if (!self.wechatButton.selected) {
//        self.alipayButton.selected = NO;
//        self.wechatButton.selected = YES;
//    }
//}
//
//@end
