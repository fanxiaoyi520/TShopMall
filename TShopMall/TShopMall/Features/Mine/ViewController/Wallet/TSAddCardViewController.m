//
//  TSAddCardViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSAddCardViewController.h"
#import "TSAddBankCardCell.h"
#import "TSPresentationController.h"
#import "TSSelectorViewController.h"
#import "TSAreaSelectedController.h"

@interface TSAddCardViewController ()<UITableViewDelegate,UITableViewDataSource,TSAddBankCardDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic ,strong) UITableView *addCardTableView;
@property (nonatomic ,strong) TSAddBankCardFooter *footerView;
@property (nonatomic ,strong) NSArray *dataList;
@end

@implementation TSAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"添加银行卡";
    
    self.dataList = @[@"银行卡号",@"银行名称",@"开户银行省市",@"开户银行"];
}

- (void)fillCustomView {
    [self.view addSubview:self.addCardTableView];
    self.addCardTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight-GK_STATUSBAR_NAVBAR_HEIGHT);

    self.addCardTableView.tableFooterView = self.footerView;
    self.footerView.frame = CGRectMake(0, self.addCardTableView.bottom, kScreenWidth, 56);
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    if ([cell isKindOfClass:TSAddBankCardCell.class]) {
        TSAddBankCardCell *addCell = (TSAddBankCardCell *)cell;
        [addCell setModel:self.dataList[indexPath.row] indexPath:indexPath];
        addCell.kDelegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 106;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TSAddBankCardHeader *view = [TSAddBankCardHeader new];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    TSAddBankCardFooter *view = [TSAddBankCardFooter new];
//    view.kDelegate = self;
    UIView *view = [UIView new];
    return view;
}

// MARK: TSAddBankCardDelegate
- (void)addBankCardInputInfoTextFieldAction:(UITextField *)textField {NSLog(@"输入");}

- (void)addBankCardfuncAction:(id _Nullable)sender {
    //****结束textView的输入****//
    [self.view endEditing:YES];
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 11) {
        TSSelectorViewController *vc = [TSSelectorViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        __weak typeof(self) weakSelf = self;
        [TSAreaSelectedController showAreaSelected:^(TSAreaModel *provice, TSAreaModel *city, TSAreaModel *eare, TSAreaModel *street, NSString *location) {
    //        if (provice) {
    //            weakSelf.vm.provice = provice.provinceName;
    //            weakSelf.vm.proviceUUid = provice.currentUUid;
    //        }
    //        if (city) {
    //            weakSelf.vm.city = city.cityName;
    //            weakSelf.vm.cityUUid = city.currentUUid;
    //        }
    //        if (eare) {
    //            weakSelf.vm.area = eare.regionName;
    //            weakSelf.vm.areaUUid = eare.currentUUid;
    //        }
    //        if (street) {
    //            weakSelf.vm.street = street.streetName;
    //            weakSelf.vm.streetUUid = street.currentUUid;
    //        }
    //        if (provice == nil) {
    //            weakSelf.vm.address = location;
    //        } else {
    //            NSString *address = [NSString stringWithFormat:@"%@%@%@%@", provice.provinceName, city.cityName, eare.regionName, street.streetName];
    //            weakSelf.vm.address = address;
    //        }
    //        [weakSelf.editView updateAddress:weakSelf.vm.address];
        } OnController:self];
    }
}

- (void)addBankCardFooterSureAction:(id _Nullable)sender {
    NSLog(@"提交");
}

// MARK: UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[TSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

// MARK: get
- (UITableView *)addCardTableView {
    if (!_addCardTableView) {
        _addCardTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addCardTableView.delegate = self;
        _addCardTableView.dataSource = self;
        _addCardTableView.showsVerticalScrollIndicator = NO;
        _addCardTableView.showsHorizontalScrollIndicator = NO;
        _addCardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_addCardTableView registerClass:TSAddBankCardCell.class forCellReuseIdentifier:@"cellid"];
        _addCardTableView.bounces = NO;
    }
    return _addCardTableView;
}

- (TSAddBankCardFooter *)footerView {
    if (!_footerView) {
        _footerView = [TSAddBankCardFooter new];
        _footerView.kDelegate = self;
    }
    return _footerView;
}
@end
