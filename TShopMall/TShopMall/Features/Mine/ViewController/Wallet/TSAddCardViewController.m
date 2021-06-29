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

#import "TSMineDataController.h"

#import "TSAddBankCardModel.h"
#import "TSAddBankCardBackModel.h"
@interface TSAddCardViewController ()<UITableViewDelegate,UITableViewDataSource,TSAddBankCardDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic ,strong) UITableView *addCardTableView;
@property (nonatomic ,strong) TSAddBankCardFooter *footerView;
@property (nonatomic ,strong) NSArray *dataList;
@property (nonatomic ,strong) NSMutableDictionary *mutableDic;
@property (nonatomic ,strong) TSAddBankCardModel *model;
@property (nonatomic ,strong) TSMineDataController *dataController;

@end

@implementation TSAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"添加银行卡";

    self.dataList = @[@"银行卡号",@"银行名称",@"开户银行省市",@"开户银行"];
    //dic容错设置
    self.mutableDic = [NSMutableDictionary dictionary];
    [self.mutableDic setValue:@"" forKey:@"bankCardNo"];
    [self.mutableDic setValue:@"" forKey:@"accountBank"];
    [self.mutableDic setValue:@"" forKey:@"accountBankCode"];
    [self.mutableDic setValue:@"" forKey:@"bankName"];
    [self.mutableDic setValue:@"" forKey:@"bankBranchId"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressProvince"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressProvinceCode"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressCity"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressCityCode"];
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
- (void)addBankCardInputInfoTextFieldAction:(UITextField *)textField {
    if (textField.tag == 20) {
        if (textField.text) {
            NSString *str = [textField.text stringByReplacingOccurrencesOfString:@" "withString:@""];;
            [self.mutableDic setValue:str forKey:@"bankCardNo"];
        }
        self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
    } else {
        if (textField.text)
            [self.mutableDic setValue:textField.text forKey:@"bankName"];
        self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
    }
}

- (void)addBankCardfuncAction:(id _Nullable)sender {
    //****结束textView的输入****//
    [self.view endEditing:YES];
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 11) {
        TSAddBankCardCell *cell = (TSAddBankCardCell *)btn.superview;
        __block UITextField *textField = nil;
        [cell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:UITextField.class]) {
                textField = (UITextField *)obj;
            }
        }];
        TSSelectorViewController *vc = [TSSelectorViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        @weakify(self);
        vc.selectBankBlock = ^(id  _Nullable info) {
            @strongify(self);
            textField.text = (NSString *)info;
            NSString *str = (NSString *)info;
            [self.mutableDic setValue:str forKey:@"accountBank"];
            self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
        };
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        //@weakify(self);
        [TSAreaSelectedController showAreaSelected:^(TSAreaModel *provice, TSAreaModel *city, TSAreaModel *eare, TSAreaModel *street, NSString *location) {
            //@strongify(self);
    //        if (provice) {
    //            weakSelf.vm.provice = provice.provinceName;
    //            weakSelf.vm.proviceUUid = provice.currentUUid;
    //        }
    //        if (city) {
    //            weakSelf.vm.city = city.cityName;
    //            weakSelf.vm.cityUUid = city.currentUUid;
    //        }
        } OnController:self];
    }
}

- (void)addBankCardFooterSureAction:(id _Nullable)sender {
//    if (self.model.bankCardNo || [self.model.bankCardNo isEqualToString:@""]) {
//        [Popover popToastOnWindowWithText:@"银行卡号不能为空"];
//        return;
//    }
    self.dataController.addBankCardModel = self.model;
    @weakify(self);
    [self.dataController fetchCheckBankCardDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            [self.dataController fetchAddToBankCardDataComplete:^(BOOL isSucess) {
        
            }];
        }
    }];
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

- (TSMineDataController *)dataController {
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}
@end
