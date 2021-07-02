//
//  TSAddCardViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSAddCardViewController.h"
#import "TSPresentationController.h"
#import "TSSelectorViewController.h"
#import "TSAreaSelectedController.h"
#import "TSMineDataController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "TSAddBankCardCell.h"
#import "TSDropDownView.h"
#import "TSOperationBankTipsViewController.h"
#import "TSSelectAddressViewController.h"
#import "TSAddBankCardModel.h"
#import "TSAddBankCardBackModel.h"
#import "TSBranchCardModel.h"
#import "NSString+Plugin.h"

@interface TSAddCardViewController ()<UITableViewDelegate,UITableViewDataSource,TSAddBankCardDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic ,strong) UITableView *addCardTableView;
@property (nonatomic ,strong) TSAddBankCardFooter *footerView;
@property (nonatomic ,strong) NSArray *dataList;
@property (nonatomic ,strong) NSMutableDictionary *mutableDic;
@property (nonatomic ,strong) TSAddBankCardModel *model;
@property (nonatomic ,strong) TSMineDataController *dataController;
@property (nonatomic ,strong) TSDropDownView *dropDownView;
@property (nonatomic ,assign) CGRect keyBoardRect;
@end

@implementation TSAddCardViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"添加银行卡";
    //[[IQKeyboardManager sharedManager] setEnable:NO];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];

    self.dataList = @[@"姓名",@"银行卡号",@"银行名称",@"开户银行省市",@"开户银行"];
    //dic容错设置
    self.mutableDic = [NSMutableDictionary dictionary];
    [self.mutableDic setValue:@"" forKey:@"userName"];
    [self.mutableDic setValue:@"" forKey:@"bankCardNo"];
    [self.mutableDic setValue:@"" forKey:@"accountBank"];
    [self.mutableDic setValue:@"" forKey:@"accountBankCode"];
    [self.mutableDic setValue:@"" forKey:@"bankName"];
    [self.mutableDic setValue:@"" forKey:@"bankBranchId"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressProvince"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressProvinceCode"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressCity"];
    [self.mutableDic setValue:@"" forKey:@"bankAddressCityCode"];
    self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
}

- (void)fillCustomView {
    [self.view addSubview:self.addCardTableView];
    self.addCardTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight-GK_STATUSBAR_NAVBAR_HEIGHT);
    
    TSAddBankCardHeader *view = [[TSAddBankCardHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 106)];
    self.addCardTableView.tableHeaderView = view;

    self.addCardTableView.tableFooterView = self.footerView;
    self.footerView.frame = CGRectMake(0, self.addCardTableView.bottom, kScreenWidth, 56);
    

    [self.view addSubview:self.dropDownView];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    TSAddBankCardFooter *view = [TSAddBankCardFooter new];
//    view.kDelegate = self;
    UIView *view = [UIView new];
    return view;
}

// MARK: TSAddBankCardDelegate
- (void)addBankCardInputInfoTextFieldEditingDidBeginAction:(UITextField *)textField {
    //在切换输入框时要让表回归原位，并且隐藏输入开户银行附带的选择列表视图
    self.addCardTableView.top = GK_STATUSBAR_NAVBAR_HEIGHT;
    self.dropDownView.hidden = YES;
}

- (void)addBankCardInputInfoTextFieldAction:(UITextField *)textField {
    self.addCardTableView.top = GK_STATUSBAR_NAVBAR_HEIGHT;
    self.dropDownView.hidden = YES;
    
    //输入姓名业务
    if (textField.tag == 15) {
        if (textField.text)
            [self.mutableDic setValue:textField.text forKey:@"userName"];
        self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
        
        if ([self checkAllParameter:NO]) {
            [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
        } else {
            [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
        }
        return;
    }
    
    //输入银行卡号业务
    if (textField.tag == 20) {
        NSString *str = [textField.text stringByReplacingOccurrencesOfString:@" "withString:@""];;
        [self.mutableDic setValue:str forKey:@"bankCardNo"];
        self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
        self.dataController.addBankCardModel = self.model;
        if (str.length >= 16) {
            @weakify(self);
            [self.dataController fetchCheckBankCardDataComplete:^(BOOL isSucess) {
                @strongify(self);
                if (isSucess == YES) {
                    [self.view endEditing:YES];
                    [self.mutableDic setValue:str forKey:@"bankCardNo"];
                    
                    [self.mutableDic setValue:self.dataController.addBankCardBackModel.bankName forKey:@"accountBank"];
                    [self.mutableDic setValue:self.dataController.addBankCardBackModel.accountBankCode forKey:@"accountBankCode"];
                    self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
                    [Popover popToastOnWindowWithPopPosition:PopPositionMiddle text:@"银行卡号校验成功" toastyType:ToastyTypeNormal appearBlock:nil];
                    
                    if ([self checkAllParameter:NO]) {
                        [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
                    } else {
                        [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
                    }
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];;
                    TSAddBankCardCell *kCell = [self.addCardTableView cellForRowAtIndexPath:indexPath];
                    [kCell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:UITextField.class]) {
                            UITextField *textField = (UITextField *)obj;
                            textField.text = self.dataController.addBankCardBackModel.bankName;
                        }
                        if ([obj isKindOfClass:UIImageView.class]) {
                            UIImageView *imageView = (UIImageView *)obj;
                            imageView.hidden = YES;
                        }
                    }];
                } else {
                    [Popover popToastOnWindowWithPopPosition:PopPositionMiddle text:@"银行卡号校验有误" toastyType:ToastyTypeNormal appearBlock:nil];
                }
            }];
        }
        return;
    }

    //输入开户银行业务
    [self.mutableDic setValue:textField.text forKey:@"bankName"];
    self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.dataController.addBankCardModel = self.model;
    @weakify(self);
    [self.dataController fetchInquiryBranchDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            if (self.dataController.branchCardArray.count>0) {
                self.dropDownView.hidden = NO;
                self.addCardTableView.top = GK_STATUSBAR_NAVBAR_HEIGHT - self.dropDownView.height+50;
                self.dropDownView.top = textField.superview.bottom-self.dropDownView.height;
                self.dropDownView.bottom = kScreenHeight-self.keyBoardRect.size.height;
                [self.dropDownView setModel:self.dataController.branchCardArray];
                self.dropDownView.selectBranchBlock = ^(id  _Nullable info) {
                    @strongify(self);
                    [self.view endEditing:YES];
                    TSBranchCardModel *model = (TSBranchCardModel *)info;
                    textField.text = model.bankFullName;
                    [self.mutableDic setValue:model.bankFullName forKey:@"bankName"];
                    [self.mutableDic setValue:model.linkNumber forKey:@"bankBranchId"];
                    self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
                    if ([self checkAllParameter:NO]) {
                        [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
                    } else {
                        [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
                    }
                };
            }
        }
    }];
}

- (void)addBankCardfuncAction:(id _Nullable)sender {
    //****结束textView的输入****//
    [self.view endEditing:YES];
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 12) {
        TSAddBankCardCell *cell = (TSAddBankCardCell *)btn.superview;
        __block UITextField *textField = nil;
        __block UIImageView *imageView = nil;
        [cell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:UITextField.class]) textField = (UITextField *)obj;
            if ([obj isKindOfClass:UIImageView.class]) imageView = (UIImageView *)obj;
        }];
        TSSelectorViewController *vc = [TSSelectorViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        @weakify(self);
        vc.selectBankBlock = ^(id  _Nullable info) {
            @strongify(self);
            imageView.hidden = YES;
            TSAddBankCardBackModel *model = (TSAddBankCardBackModel *)info;
            textField.text = model.bankName;
            [self.mutableDic setValue:model.bankName forKey:@"accountBank"];
            [self.mutableDic setValue:model.bankCode forKey:@"accountBankCode"];
            self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
            
            if ([self checkAllParameter:NO]) {
                [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
            } else {
                [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
            }
        };
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        TSAddBankCardCell *cell = (TSAddBankCardCell *)btn.superview;
        __block UITextField *textField = nil;
        __block UIImageView *imageView = nil;
        [cell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:UITextField.class]) textField = (UITextField *)obj;
            if ([obj isKindOfClass:UIImageView.class]) imageView = (UIImageView *)obj;
        }];
        
        TSSelectAddressViewController *vc = [TSSelectAddressViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        @weakify(self);
        vc.selectAddressBlock = ^(id  _Nullable info) {
            @strongify(self);
            imageView.hidden = YES;
            NSMutableDictionary *dic = (NSMutableDictionary *)info;
            [self.mutableDic addEntriesFromDictionary:dic];
            self.model = [TSAddBankCardModel yy_modelWithDictionary:self.mutableDic];
            textField.text = [NSString stringWithFormat:@"%@%@",self.model.bankAddressProvince,self.model.bankAddressCity];
            if ([self checkAllParameter:NO]) {
                [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
            } else {
                [self.footerView.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
            }
        };
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)addBankCardFooterSureAction:(id _Nullable)sender {
//    TSOperationBankTipsViewController *vc = [TSOperationBankTipsViewController new];
//    vc.kNavTitle = @"添加银行卡";
//    vc.isNotice = self.isNotice;
//    [self.navigationController pushViewController:vc animated:YES];
//
    if (![self checkAllParameter:YES]) return;

    self.dataController.addBankCardModel = self.model;
    @weakify(self);
    [self.dataController fetchAddToBankCardDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            TSOperationBankTipsViewController *vc = [TSOperationBankTipsViewController new];
            vc.kNavTitle = @"添加银行卡";
            vc.isNotice = self.isNotice;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

// MARK: UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[TSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

// MARK: keyboard noti
- (void)keyboardWillShow:(NSNotification *)aNotification {//当键盘出现或改变时调用
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardRect = keyboardRect;
}
 
- (void)keyboardWillHide:(NSNotification *)aNotification {//当键退出时调用
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardRect = keyboardRect;
    self.addCardTableView.top = GK_STATUSBAR_NAVBAR_HEIGHT;
    self.dropDownView.hidden = YES;
}


//校验所有参数
- (BOOL)checkAllParameter:(BOOL)isSubmit {
    
    if (!self.model.userName || [self.model.userName isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"用户名不能为空"];
        return NO;
    }
    
    if (!self.model.bankCardNo || [self.model.bankCardNo isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"银行卡号不能为空"];
        return NO;
    }

    if (!self.model.accountBank || [self.model.accountBank isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"银行名称不能为空"];
        return NO;
    }

    if (!self.model.bankName || [self.model.bankName isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"开户银行不能为空"];
        return NO;
    }

    if (!self.model.bankAddressProvince || [self.model.bankAddressProvince isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"开户银行省市不能为空"];
        return NO;
    }

    if (!self.model.bankAddressCity || [self.model.bankAddressCity isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"开户银行省市不能为空"];
        return NO;
    }
    
    if (!self.model.bankAddressCityCode || [self.model.bankAddressCityCode isEqualToString:@""]) {
        if (isSubmit) [Popover popToastOnWindowWithText:@"该开户银行不支持"];
        return NO;
    }
    
    return YES;
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

- (TSDropDownView *)dropDownView {
    if (!_dropDownView) {
        _dropDownView = [[TSDropDownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4*33)];
        _dropDownView.hidden = YES;
    }
    return _dropDownView;
}
@end
