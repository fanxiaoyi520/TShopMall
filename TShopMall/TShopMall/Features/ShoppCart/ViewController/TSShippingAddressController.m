//
//  TSShippingAddressController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSShippingAddressController.h"
#import "TSShippingAddressCell.h"
#import "TSShippingAddressDataController.h"
#import "TSAddressEditController.h"
#import "TSEmptyAlertView.h"
#import "TSAlertView.h"

@interface TSShippingAddressController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray<TSAddressModel *> *addresses;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *editBtn;
@end

@implementation TSShippingAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的收货地址";
    
    self.view.backgroundColor = KHexColor(@"#F4F4F4");
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    [self fetchAddress];
}

- (void)setupNavigationBar{
    [super setupNavigationBar];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
}

- (void)fetchAddress{
    __weak typeof(self) weakSelf = self;
    [TSShippingAddressDataController  fetchAddress:^(NSArray<TSAddressModel *> *addresses, NSString *message) {
        [TSEmptyAlertView hideInView:self.tableView];
        if (message.length != 0) {
            TSEmptyAlertView.new.alertInfo(message, @"刷新").alertImage(@"alert_address_empty").show(self.tableView, @"center", ^{
                [weakSelf fetchAddress];
            });
            return;
        }
        if (addresses.count == 0) {
            TSEmptyAlertView.new.alertInfo(@"没有收货地址点击添加", @"").alertImage(@"alert_address_empty").show(self.tableView, @"center", ^{
                [weakSelf gotoAddNewAddress];
            });
        } else {
            [TSEmptyAlertView hideInView:self.tableView];
            self->addresses = addresses;
            [weakSelf.tableView reloadData];
        }
    } lodingView:self.view];
}

- (void)gotoAddNewAddress{
    [self gotoEditAddress:nil];
}

- (void)gotoEditAddress:(TSAddressModel *)obj{
    TSAddressEditController *con = [TSAddressEditController new];
    if (obj != nil) {
        con.vm = [[TSAddressViewModel alloc] initWithAddress:obj];
    }
    con.addressChanged = ^{
        [self fetchAddress];
    };
    [self.navigationController pushViewController:con animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return addresses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    TSShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSShippingAddressCell"];
    cell.addressModel = addresses[indexPath.row];
    cell.addressEdit = ^(TSAddressModel * _Nonnull address) {
        [weakSelf gotoEditAddress:address];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addressSelected) {
        self.addressSelected(addresses[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return KRateW(10.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UITableViewHeaderFooterView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UITableViewHeaderFooterView new];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    TSShippingAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TSAlertView.new.alertInfo(nil, @"确认删除选中商品吗？").confirm(@"确定", ^{
        [TSShippingAddressDataController deleteAddress:cell.addressModel finished:^{
            [self fetchAddress];
        } lodingView:self.view];
    }).cancel(@"取消", ^{}).show();
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)viewWillLayoutSubviews{
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(KRateW(96.0) + GK_SAFEAREA_BTM);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRateW(24.0));
        make.right.equalTo(self.view.mas_right).offset(-KRateW(24.0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-GK_SAFEAREA_BTM - KRateW(40.0));
        make.height.mas_equalTo(KRateW(40.0));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(GK_STATUSBAR_NAVBAR_HEIGHT);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}


- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 140.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TSShippingAddressCell class] forCellReuseIdentifier:@"TSShippingAddressCell"];
        
    return self.tableView;
}

- (UIButton *)addBtn{
    if (_addBtn) {
        return _addBtn;
    }
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.titleLabel.font = KRegularFont(16.0);
    [self.addBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [self.addBtn setTitle:@"+ 新建收货地址" forState:UIControlStateNormal];
    self.addBtn.backgroundColor = KHexColor(@"#FF4D49");
    self.addBtn.layer.cornerRadius = KRateW(20.0);
    self.addBtn.layer.masksToBounds = YES;
    [self.addBtn addTarget:self action:@selector(gotoAddNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    
    return self.addBtn;
}

- (UIView *)bottomView{
    if (_bottomView) {
        return _bottomView;
    }
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    return self.bottomView;
}


- (UIButton *)editBtn{
    if (_editBtn) {
        return _editBtn;
    }
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.titleLabel.font = [UIFont font:PingFangSCRegular size:KRateW(14.0)];
    [self.editBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    self.editBtn.frame = CGRectMake(0, 0, KRateW(32.0), KRateW(24.0));
    [self.editBtn addTarget:self action:@selector(gotoAddNewAddress) forControlEvents:UIControlEventTouchUpInside];
    
    return self.editBtn;
}

@end
