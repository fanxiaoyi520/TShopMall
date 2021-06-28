//
//  TSScoreViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#import "TSScoreViewController.h"
#import "TSScoreView.h"
@interface TSScoreViewController ()<TSScoreViewDelegate>

@property (nonatomic ,strong) TSScoreView *scoreView;
@property (nonatomic ,strong) UIButton *sureBtn;
@end

@implementation TSScoreViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"去评分";
}

- (void)fillCustomView {
    
    [self.view addSubview:self.scoreView];
    self.scoreView.frame = CGRectMake(16, 48+GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth-32, 259);
    [self.scoreView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(24, 24)];
    
    [self.view addSubview:self.sureBtn];
    self.sureBtn.frame = CGRectMake(24, self.view.bottom-40-48, kScreenWidth-48, 40);
    [_sureBtn jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
}

// MARK: action
- (void)sureAction:(UIButton *)sender {
    NSLog(@"提交");
}

// MARK: TSScoreViewDelegate
- (void)scoreViewScoreAction:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"星星");
}

- (void)scoreViewTextViewDidChange:(UITextView *)textView {
    NSLog(@"%@",textView.text);
}

// MARK: get
- (TSScoreView *)scoreView {
    if (!_scoreView) {
        _scoreView = [TSScoreView new];
        _scoreView.backgroundColor = KWhiteColor;
        _scoreView.kDelegate = self;
    }
    return _scoreView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm1") forState:UIControlStateNormal];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = KRegularFont(16);
        [_sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
@end
