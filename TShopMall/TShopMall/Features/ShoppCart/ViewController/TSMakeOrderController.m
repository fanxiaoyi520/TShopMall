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
#import "TSMakeOrderCommitOrderDataController.h"
#import "TSPayController.h"
#import "TSHybridViewController.h"

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
    self.dataCon.paramsISFromCart = self.isFromCart;
    self.dataCon.context = self;
    [self refreshData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invoiceChanged:) name:@"InvoiceChanged" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshData{
    
    __weak typeof(self) weakSelf = self;
    [self.dataCon checkBalance:^(BOOL finished) {
        weakSelf.commitView.hidden  = !finished;
        [weakSelf updateUI];
    }];
}

- (void)updateUI{
    self.makeOrderView.sections = self.dataCon.sections;
    self.commitView.price.text = [NSString stringWithFormat:@"¥ %d", self.dataCon.balanceModel.orderTotalMoney.intValue];
}

//选择地址
- (void)gotoSelectedAddress{
    __weak typeof(self) weakSelf = self;
    TSShippingAddressController *con = [TSShippingAddressController new];
    con.addressSelected = ^(TSAddressModel * _Nonnull address) {
        [weakSelf.dataCon updateAddressSection:address];
//        [weakSelf refreshData];
        weakSelf.makeOrderView.sections = weakSelf.dataCon.sections;
    };
    [self.navigationController pushViewController:con animated:YES];
}

//选择配送方式
- (void)operationForChangeDelivery{
}

//选择发票
- (void)operationForChangeBill{
    NSString *path = [NSString stringWithFormat:@"%@%@?isFromOrder=1&uuid=",kMallH5ApiPrefix,kMallH5InvoiceUrl];
    TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
    hybrid.isInvoice = YES;
    [self.navigationController pushViewController:hybrid animated:YES];
}

- (void)operationForMessageEditEnd:(NSString *)message{
    [self.dataCon updateMessage:message];
    self.makeOrderView.sections = self.dataCon.sections;
}

- (void)invoiceChanged:(NSNotification *)noti{
    NSDictionary *invoice = noti.userInfo[@"invoice"];
    TSInvoiceModel *model = [TSInvoiceModel creatWithInvoice:invoice];
    [self.dataCon updateInvoiceSectionWithInvoice:model];
    self.makeOrderView.sections = self.dataCon.sections;
}

- (void)commit{
    TSMakeOrderRow *row = (TSMakeOrderRow *)[self.makeOrderView.sections[0].rows lastObject];
    if (row.obj == nil) {//地址为空
        [Popover popToastOnView:self.view text:@"请先选择收获地址"];
        return;
    }
    TSAddressModel *address = row.obj;
    TSMakeOrderRow *operationRow = (TSMakeOrderRow *)[self.makeOrderView.sections[2].rows lastObject];
    TSMakeOrderInvoiceViewModel *vm = operationRow.obj;
   
    [TSMakeOrderCommitOrderDataController commitOrderWithAddress:address balanceInfo:self.dataCon.balanceModel invoice:vm.invoice message:vm.message isFromCart:self.isFromCart finished:^(BOOL finished, NSString *payOrderId, NSString *isGroup) {
        if (finished == YES) {
            TSPayController *con = [TSPayController new];
            con.payOrderId = payOrderId;
            con.isGroup = isGroup;
            [self.navigationController pushViewController:con animated:YES];
            
            NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [arr removeObject:self];
            self.navigationController.viewControllers = arr;
        }
    } OnController:self];
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
    [self.commitView.commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitView];
    
    return self.commitView;
}

@end
