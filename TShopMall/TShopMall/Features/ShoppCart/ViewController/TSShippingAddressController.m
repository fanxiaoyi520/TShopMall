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

@interface TSShippingAddressController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *address;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) TSShippingAddressDataController *dataCon;
@end

@implementation TSShippingAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收货地址";
    
    self.view.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.dataCon = [TSShippingAddressDataController new];
    [self configDatas];
}

- (void)configDatas{
    address = @[
        @"广东省深圳市南山区西丽街道TCL国际e城808有多的就两行",
        @"广东省深圳市南山区西丽街道TCL国际e城808有多的就两行为了三行为了三行为了三行为了三行为了三行为了三行为了三行",
        @"广东省深圳市南山区西丽街道TCL国际e城808有多的就两行",
        @"广东省深圳市南山区西丽街道TCL国际e城"
    ];
    [self.tableView reloadData];
}

- (void)gotoAddNewAddress{
    [self gotoEditAddress:nil];
}

- (void)gotoEditAddress:(TSAddressModel *)obj{
    TSAddressEditController *con = [TSAddressEditController new];
    [self.navigationController pushViewController:con animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return address.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    TSShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSShippingAddressCell"];
    cell.addressStr = address[indexPath.row];
    cell.addressEdit = ^(TSAddressModel * _Nonnull address) {
        [weakSelf gotoEditAddress:address];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addressSelected) {
        self.addressSelected(address[indexPath.row]);
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
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)viewWillLayoutSubviews{
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRateW(24.0));
        make.right.equalTo(self.view.mas_right).offset(-KRateW(24.0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-GK_SAFEAREA_BTM - KRateW(33.0));
        make.height.mas_equalTo(KRateW(40.0));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.addBtn.mas_top).offset(-KRateW(8.0));
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
    self.tableView.backgroundColor = KHexColor(@"#ffffff");
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
@end
