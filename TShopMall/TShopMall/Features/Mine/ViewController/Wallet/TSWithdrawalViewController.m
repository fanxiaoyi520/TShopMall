//
//  TSWithdrawalViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSWithdrawalViewController.h"
#import "UIView+Plugin.h"

@interface TSWithdrawalViewController ()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIButton *sureBtn;
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
    NSArray *conArray = @[@"¥0",@"¥199999"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lab = [UILabel new];
        lab.textColor = KHexColor(@"#2D3132");
        lab.font = KRegularFont(14);
        lab.text = array[idx];
        [self.bgView addSubview:lab];
        lab.frame = CGRectMake(16, 74+idx*(38+22), 100, 22);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = KHexAlphaColor(@"#E6E6E6",1);
        [self.bgView addSubview:lineView];
        lineView.frame = CGRectMake(25, 115+idx*(1+60), kScreenWidth-50, 1);
        
        if (idx < 2) {
            UILabel *conLab = [UILabel new];
            [self.bgView addSubview:conLab];
            conLab.textColor = KHexColor(@"#2D3132");
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
    textView.textColor = KHexAlphaColor(@"#2D3132", .5);
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
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    //sureBtn.backgroundColor = KHexColor(@"#FF4D49");
    sureBtn.backgroundColor = KHexColor(@"#DDDDDD");
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
    NSLog(@"全部金额");
}

- (void)sureAction:(UIButton *)sender {
    NSLog(@"确定");
}

- (void)textFieldAction:(UITextField *)textField {
    if (textField.text.length > 2) {
        self.sureBtn.backgroundColor = KHexColor(@"#FF4D49");
        self.sureBtn.userInteractionEnabled = YES;
    } else {
        self.sureBtn.backgroundColor = KHexColor(@"#DDDDDD");
        self.sureBtn.userInteractionEnabled = NO;
    }
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
@end
