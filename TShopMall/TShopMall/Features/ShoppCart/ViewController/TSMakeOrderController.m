//
//  TSMakeOrderController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderController.h"
#import "TSMakeOrderView.h"
#import "TSMakeOrderCommitView.h"
#import "TSMakeOrderDataController.h"
#import "TSShippingAddressController.h"

@interface TSMakeOrderController ()
@property (nonatomic, strong) TSMakeOrderView *makeOrderView;
@property (nonatomic, strong) TSMakeOrderCommitView *commitView;
@property (nonatomic, strong) TSMakeOrderDataController *dataCon;
@end

@implementation TSMakeOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"确认下单";
    if (@available(iOS 11.0, *)) {
        self.makeOrderView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.dataCon = [TSMakeOrderDataController new];
    [self refreshData];
}

- (void)refreshData{
    __weak typeof(self) weakSelf = self;
    [self.dataCon initData:^{
            [weakSelf updateUI];
        }];
}

- (void)updateUI{
    self.makeOrderView.sections = self.dataCon.sections;
}

- (void)gotoSelectedAddress{
    TSShippingAddressController *con = [TSShippingAddressController new];
    [self.navigationController pushViewController:con animated:YES];
}

- (void)viewWillLayoutSubviews{
    
    [self.commitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(KRateW(56.0) + self.view.bottomSafeAreaHeight);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.makeOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(GK_SAFEAREA_TOP + GK_NAVBAR_HEIGHT);
        make.bottom.equalTo(self.commitView.mas_top);
    }];
}

- (TSMakeOrderView *)makeOrderView{
    if (_makeOrderView) {
        return _makeOrderView;
    }
    self.makeOrderView = [TSMakeOrderView new];
    self.makeOrderView.controller = self;
    [self.view addSubview:self.makeOrderView];
    
    return self.makeOrderView;
}

- (TSMakeOrderCommitView *)commitView{
    if (_commitView) {
        return _commitView;
    }
    self.commitView = [TSMakeOrderCommitView new];
    [self.view addSubview:self.commitView];
    
    return self.commitView;
}

@end
