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
#import "TSAlertView.h"

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

- (BOOL)navigationShouldPopOnClick{
    TSAlertView.new.alertInfo(@"确认放弃付款吗?", @"超过订单支付时效后，订单将被取消").confirm(@"继续支付", ^{
        
    }).cancel(@"确认离开", ^{
        [self.navigationController popViewControllerAnimated:YES];
    }).show();
    return NO;
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
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arr removeObject:self];
    self.navigationController.viewControllers = arr;
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
        TSPayStyleModel *model = self.payStyleDataCon.payStyles[i];
        TSPayChannelItem *item = [TSPayChannelItem new];
        item.model = model;
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
