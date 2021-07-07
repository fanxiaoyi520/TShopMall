//
//  TSInputPasswordViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/2.
//

#import "TSInputPasswordViewController.h"
#import "NNValidationCodeView.h"
#import "UILabel+size.h"
#import "TSAlertView.h"

@interface TSInputPasswordViewController ()

@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIButton *closeBtn;
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *smallLab;
@property (nonatomic ,strong)UILabel *amountLab;
@property (nonatomic ,strong)UILabel *tipsLab;
@property (nonatomic ,strong)UIButton *forgetPassBtn;
@property (nonatomic ,copy)NSString *boxInputViewstr;
@property (nonatomic ,strong)NNValidationCodeView *codeView;
@property (nonatomic ,assign)NSInteger flags;
@property (nonatomic ,strong) TSMineDataController *dataController;
@end

@implementation TSInputPasswordViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (self.flags == 1) {
        self.bgView.frame = CGRectMake(36, 115, kScreenWidth-72, 262);
        [self.bgView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
        self.bgView.backgroundColor = KWhiteColor;
        self.tipsLab.hidden = NO;
        self.forgetPassBtn.hidden = NO;
        self.codeView.top = self.amountLab.bottom+52;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

    [self creatView];
}

- (void)creatView {
    self.flags = 0;
    [self.view layoutIfNeeded];

    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(36, 224, kScreenWidth-72, 220);
    [self.bgView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
    
    [self.bgView addSubview:self.closeBtn];
    _closeBtn.frame = CGRectMake(self.bgView.width-24-12, 16, 24, 24);
    [_closeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];

    [self.bgView addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(0, 16, self.bgView.width, 24);
    
    [self.bgView addSubview:self.smallLab];
    self.smallLab.frame = CGRectMake(0, self.titleLab.bottom+34, self.bgView.width, 22);
    
    [self.bgView addSubview:self.amountLab];
    self.amountLab.frame = CGRectMake(0, self.smallLab.bottom+10, self.bgView.width, 22);
    
    [self.bgView addSubview:self.tipsLab];
    self.tipsLab.frame = CGRectMake(0, self.amountLab.bottom+24, self.bgView.width, 20);
    
    [self.bgView addSubview:self.forgetPassBtn];
    CGFloat w = [UILabel labelWidthWithText:@"忘记密码" height:22 font:KRegularFont(14)];
    self.forgetPassBtn.frame = CGRectMake((self.bgView.width-w)/2, self.tipsLab.bottom+52, w, 22);
    [self.forgetPassBtn jaf_setEnlargeEdgeWithTop:2 right:10 bottom:10 left:10];
    
    CGFloat spacing = (self.bgView.width-58-36*6)/5;
    NNValidationCodeView *view = [[NNValidationCodeView alloc] initWithFrame:CGRectMake(29, self.amountLab.bottom+32, self.bgView.width-58, 36) andLabelCount:6 andLabelDistance:spacing];
    [self.bgView addSubview:view];
    view.changedColor = KHexColor(@"#2D3132");
    self.codeView = view;
    [self handlingInputEvents];
}

// MARK: actions
- (void)handlingInputEvents {
    @weakify(self);
    self.codeView.codeBlock = ^(NSString *codeString) {
        @strongify(self);
        BOOL isFinished = NO;
        if (codeString.length == 6) {
            isFinished = YES;
            self.boxInputViewstr = codeString;
            self.dataController.inputPassword = codeString;
            self.dataController.bankCardAccountId = self.kDataController.myIncomeModel.bankCardId;
            self.dataController.withdrawalAmount = [NSString stringWithFormat:@"%f",[self.inputAmount floatValue]*100];
            @weakify(self);
            [self.dataController fetchWithdrawalPasswordDataComplete:^(BOOL isSucess) {
                @strongify(self);
                if (isSucess) {
                    [self dismissViewControllerAnimated:NO completion:^{
                        if ([self.kDelegate respondsToSelector:@selector(setPaymentPassword:isFinished:)]) {
                            [self.kDelegate setPaymentPassword:codeString isFinished:YES];
                        }
                    }];
                } else {
                    if ([self.dataController.responseCode isEqualToString:@"KY19020"] && [self.dataController.responseMsg isEqualToString:@"密码输入错误次数过多，请10分钟之后再试"]) {
                        //输入次数过多弹窗
                        TSAlertView.new.alertInfo(nil, self.dataController.responseMsg).confirm(@"忘记密码", ^{
                            [self dismissViewControllerAnimated:NO completion:^{
                                if ([self.kDelegate respondsToSelector:@selector(forgetPassAction:)]) {
                                    [self.kDelegate forgetPassAction:nil];
                                }
                            }];
                        }).cancel(@"我知道了", ^{}).show();
                    } else {
                        if (![self.dataController.responseMsg isEqualToString:@"您的今天的提现次数已用完"]) {
                            self.flags = 1;
                            self.tipsLab.text = self.dataController.responseMsg;
                            [self.view setNeedsLayout];
                        } else {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }
                    }
                }
            }];
        }
    };
}

- (void)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)forgetPassAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        if ([self.kDelegate respondsToSelector:@selector(forgetPassAction:)]) {
            [self.kDelegate forgetPassAction:nil];
        }
    }];
}

// MARK: keyboard noti
- (void)keyboardWillShow:(NSNotification *)aNotification {//当键盘出现或改变时调用
    self.bgView.top = 115;
}
 
- (void)keyboardWillHide:(NSNotification *)aNotification {//当键退出时调用
    self.bgView.top = 220;
}

// MARK: get
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
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:KImageMake(@"general_close") forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = KHexColor(@"#2D3132");
        _titleLab.font = KRegularFont(16);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"请输入提现密码";
    }
    return _titleLab;
}

- (UILabel *)smallLab {
    if (!_smallLab) {
        _smallLab = [UILabel new];
        _smallLab.textColor = KHexColor(@"#2D3132");
        _smallLab.font = KRegularFont(14);
        _smallLab.textAlignment = NSTextAlignmentCenter;
        _smallLab.text = @"提现金额";
    }
    return _smallLab;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [UILabel new];
        _amountLab.textColor = KHexColor(@"#2D3132");
        _amountLab.font = KRegularFont(24);
        _amountLab.textAlignment = NSTextAlignmentCenter;
        _amountLab.text = [NSString stringWithFormat:@"¥%@",self.inputAmount];
    }
    return _amountLab;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [UILabel new];
        _tipsLab.textColor = KHexColor(@"#E64C3D");
        _tipsLab.font = KRegularFont(14);
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        _tipsLab.text = @"提现密码错误，请重试";
        _tipsLab.hidden = YES;
    }
    return _tipsLab;
}

- (UIButton *)forgetPassBtn {
    if (!_forgetPassBtn) {
        _forgetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPassBtn addTarget:self action:@selector(forgetPassAction:) forControlEvents:UIControlEventTouchUpInside];
        _forgetPassBtn.hidden = YES;
        _forgetPassBtn.titleLabel.font = KRegularFont(14);
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"忘记密码"];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:KHexAlphaColor(@"#2D3132", .5) range:titleRange];
        [_forgetPassBtn setAttributedTitle:title forState:UIControlStateNormal];
    }
    return _forgetPassBtn;
}

- (TSMineDataController *)dataController {
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}
@end
