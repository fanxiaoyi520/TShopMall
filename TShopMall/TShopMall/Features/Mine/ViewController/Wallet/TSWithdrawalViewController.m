//
//  TSWithdrawalViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSWithdrawalViewController.h"
#import "UIView+Plugin.h"

@interface TSWithdrawalViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UITextField *inputTextField;
@property (nonatomic ,strong) TSMineDataController *dataController;
@property (nonatomic, assign) BOOL isHaveDian;
@property (nonatomic, assign) BOOL isFirstZero;
@end

@implementation TSWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
}

// MARK: ********【界面】********弹框中需要展示的内容
-(void)createView{
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(0, kScreenHeight-422, kScreenWidth, 422);
    [self.bgView jaf_customFilletRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    [self.bgView addSubview:self.closeBtn];
    self.closeBtn.frame = CGRectMake(self.bgView.width - 20 - 18, 18, 20, 20);
    
    UILabel *titleLab = [UILabel new];
    [self.bgView addSubview:titleLab];
    titleLab.textColor = KHexColor(@"#2D3132");
    titleLab.font = KRegularFont(16);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.frame = CGRectMake(0, 16, kScreenWidth, 24);
    titleLab.text = @"输入提现金额";
    
    NSArray *array = @[@"提现金额",@"扣税金额",@"税后金额"];
    NSArray *conArray = @[@"¥0",@"¥0"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lab = [UILabel new];
        lab.textColor = KHexColor(@"#2D3132");
        lab.font = KRegularFont(14);
        lab.text = array[idx];
        [self.bgView addSubview:lab];
        lab.frame = CGRectMake(16, 74+idx*(38+22), 100, 22);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = KlineColor;
        [self.bgView addSubview:lineView];
        lineView.frame = CGRectMake(25, 115+idx*(1+60), kScreenWidth-50, 1);
        
        if (idx < 2) {
            UILabel *conLab = [UILabel new];
            [self.bgView addSubview:conLab];
            conLab.textColor = KHexColor(@"#2D3132");
            conLab.tag = 50+idx;
            conLab.font = KRegularFont(14);
            conLab.frame = CGRectMake(99, 134+idx *(22+38), 150, 22);
            conLab.text = conArray[idx];
        }
    }];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(99, 73, 190, 25)];
    [self.bgView addSubview:textField];
    textField.backgroundColor = KHexColor(@"#D8D8D8");
    [textField jaf_customFilletRectCorner:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(4, 4)];
    [textField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
    self.inputTextField = textField;
    
    UIButton *allAmountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:allAmountBtn];
    allAmountBtn.backgroundColor = KHexColor(@"#FF4D49");
    [allAmountBtn addTarget:self action:@selector(allAmountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [allAmountBtn setTitle:@"全部金额" forState:UIControlStateNormal];
    allAmountBtn.titleLabel.font = KRegularFont(14);
    [allAmountBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    allAmountBtn.frame =CGRectMake(textField.right, textField.top, 70, 25);
    [allAmountBtn jaf_customFilletRectCorner:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
    
    UITextView *textView = [UITextView new];
    textView.font = KRegularFont(10);
    [self.bgView addSubview:textView];
    textView.userInteractionEnabled = NO;
    textView.text = @"提现申请成功后，将在1～5个工作日后到账\n提现金额每天超出¥800之后，按照2%来扣除个人所得税";
    textView.frame = CGRectMake(16, 248, 300, 48);
    [textView setContentOffset:CGPointMake(0, 0)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:KRegularFont(10),
                                 NSForegroundColorAttributeName:KHexAlphaColor(@"#2D3132", .5),
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
    //mine_red_bg
    [sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    sureBtn.titleLabel.font = KRegularFont(16);
    [sureBtn setTitle:@"提现申请" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(24, textView.bottom+16, kScreenWidth-48, 40);
    [sureBtn jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    sureBtn.userInteractionEnabled = NO;
    self.sureBtn = sureBtn;
}

// MARK: actions
- (void)closeAction:(id _Nullable)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)allAmountBtnAction:(UIButton *)sender {
    
    [self.dataController fetchCheckMyBalanceDataComplete:^(BOOL isSucess) {
        if (isSucess) {
            self.inputTextField.text = [NSString stringWithFormat:@"¥%.2f",(floorf([self.dataController.amount floatValue]))/100];
            UILabel *taxDeductionAmountLab = [self.bgView viewWithTag:50];//扣税金额
            UILabel *afterTaxAmountLab = [self.bgView viewWithTag:51];//税后金额
            CGFloat inputAmount = [[self.inputTextField.text stringByReplacingOccurrencesOfString:@"¥" withString:@"0"] floatValue];//输入金额
            CGFloat taxDeductionAmount = [self calculationRules:inputAmount];//扣税金额
            CGFloat afterTaxAmount = inputAmount - taxDeductionAmount;//税后金额
            taxDeductionAmountLab.text = [NSString stringWithFormat:@"¥%.2f",taxDeductionAmount];
            afterTaxAmountLab.text = [NSString stringWithFormat:@"¥%.2f",afterTaxAmount];

            
            if (self.inputTextField.text.length > 0) {
                [self.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
                self.sureBtn.userInteractionEnabled = YES;
            } else {
                [self.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
                self.sureBtn.userInteractionEnabled = NO;
            }
        }
    }];
}

- (void)sureAction:(UIButton *)sender {
//    [self dismissViewControllerAnimated:YES completion:^{
//        if ([self.kDelegate respondsToSelector:@selector(withdrawalApplication:)]) {
//            [self.kDelegate withdrawalApplication:sender];
//        }
//    }];
    self.dataController.bankCardAccountId = self.kDataController.myIncomeModel.bankCardId;
    CGFloat inputAmount = [[self.inputTextField.text stringByReplacingOccurrencesOfString:@"¥" withString:@""] floatValue];//输入金额---转成分
    if (inputAmount*100 >= 100) {
        self.dataController.withdrawalAmount = [NSString stringWithFormat:@"%f",inputAmount*100];
        @weakify(self);
        [self.dataController fetchWithdrawalApplicationDataComplete:^(BOOL isSucess) {
            @strongify(self);
            if (isSucess) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } else {
        [Popover popToastOnWindowWithText:@"提现金额必须大于1元"];
    }
}

- (void)textFieldAction:(UITextField *)textField {
    if (textField.text.length > 0) {
        UILabel *taxDeductionAmountLab = [self.bgView viewWithTag:50];//扣税金额
        UILabel *afterTaxAmountLab = [self.bgView viewWithTag:51];//税后金额
        CGFloat inputAmount = [[textField.text stringByReplacingOccurrencesOfString:@"¥" withString:@"0"] floatValue];//输入金额
        CGFloat taxDeductionAmount = [self calculationRules:inputAmount];//扣税金额
        CGFloat afterTaxAmount = inputAmount - taxDeductionAmount;//税后金额
        
        taxDeductionAmountLab.text = [NSString stringWithFormat:@"¥%.2f",taxDeductionAmount];
        afterTaxAmountLab.text = [NSString stringWithFormat:@"¥%.2f",afterTaxAmount];
        [self.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
        self.sureBtn.userInteractionEnabled = YES;
        if (![textField.text containsString:@"¥"])
            self.inputTextField.text = [NSString stringWithFormat:@"¥%@",textField.text];
        self.inputTextField.text = textField.text;
    } else {
        [self.sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
        self.sureBtn.userInteractionEnabled = NO;
    }
}

// 计算规则------返回扣税金额
- (CGFloat)calculationRules:(CGFloat)inputAmount {
    CGFloat withdrawalRate = [self.kDataController.myIncomeModel.withdrawalRate floatValue];//税率
    CGFloat accumulatedAmount = [self.kDataController.myIncomeModel.accumulatedAmount floatValue];//累计提现金额
    CGFloat taxDeductionAmount = 0;//扣税金额
    if (accumulatedAmount > 800*100) {
        taxDeductionAmount = inputAmount * withdrawalRate;
    } else if (accumulatedAmount+inputAmount>800*100){
        taxDeductionAmount = (inputAmount + accumulatedAmount - 800*100)*withdrawalRate;
    }
    return taxDeductionAmount;
}

// MARK: UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.inputTextField) {
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian = NO;
        }
        if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
            _isFirstZero = NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.') {//数据格式正确
                if([textField.text length]==0){
                    if(single == '.'){//首字母不能为小数点
                        return NO;
                    }
                    if (single == '0') {
                        _isFirstZero = YES;
                        return YES;
                    }
                }
                
                if (single=='.'){
                    if(!_isHaveDian)//text中还没有小数点
                    {
                        _isHaveDian=YES;
                        return YES;
                    }else{
                        return NO;
                    }
                }else if(single=='0'){
                    if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {//首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if([textField.text isEqualToString:@"0.0"]){
                            return NO;
                        }
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if (_isFirstZero&&!_isHaveDian){
                        //首位有0没.不能再输入0
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if (_isHaveDian){//存在小数点，保留两位小数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt= (int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){//首位有0没点
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                return NO;
            }
        }else{
            return YES;
        }
    }
    return YES;
}

// MAKR: get
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:KImageMake(@"mall_detail_close") forState:UIControlStateNormal];
        [_closeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (TSMineDataController *)dataController {
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}

@end
