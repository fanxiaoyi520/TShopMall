//
//  TSMineWalletViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/23.
//

#import "TSMineWalletViewController.h"

#import "TSWalletHeaderView.h"

@interface TSMineWalletViewController ()<TSWalletHeaderViewDelegate,TSWalletCellViewDelegate>

@property (nonatomic ,strong) UIScrollView *profitScrollView;
@property (nonatomic ,strong) TSWalletHeaderView *walletHeaderView;
@property (nonatomic ,strong) TSWalletCellView *walletCellView;
@property (nonatomic ,strong) UIButton *problemBtn;
@property (nonatomic ,strong) UIButton *withdrawalBtn;
@property (nonatomic ,strong) UILabel *tipsLab;
@end

@implementation TSMineWalletViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"我的收益";
    
    [self.walletHeaderView setModel:@""];
}

-(void)fillCustomView{
    
    [self.view addSubview:self.profitScrollView];
    self.profitScrollView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight - GK_STATUSBAR_NAVBAR_HEIGHT);
    self.profitScrollView.contentSize = self.profitScrollView.size;
    
    [self.profitScrollView addSubview:self.walletHeaderView];
    self.walletHeaderView.frame = CGRectMake(0, -13, kScreenWidth, KRateH(237));
    
    [self.profitScrollView addSubview:self.walletCellView];
    self.walletCellView.frame = CGRectMake(0, _walletHeaderView.bottom-KRateH(32), kScreenWidth, KRateH(64));
    
    [self.profitScrollView addSubview:self.problemBtn];
    self.problemBtn.frame = CGRectMake(kScreenWidth - 70 - 16, self.walletCellView.bottom, 70, 24);
    
    [self.profitScrollView addSubview:self.withdrawalBtn];
    self.withdrawalBtn.frame = CGRectMake(24, self.walletCellView.bottom + 36, kScreenWidth - 48, KRateH(40));
    [self.withdrawalBtn jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    
    [self.profitScrollView addSubview:self.tipsLab];
    self.tipsLab.frame = CGRectMake(0, self.withdrawalBtn.bottom + 12, kScreenWidth, KRateH(24));
    
}

// MARK: actions
- (void)problemAction:(UIButton *)sender {
    NSLog(@"问题");
}

- (void)withdrawalAction:(UIButton *)sender {
    NSLog(@"提现");
}

// MARK: TSWalletHeaderViewDelegate
- (void)walletHeaderWithdrawalRecordAction:(id)sender {}


// MARK: TSWalletCellViewDelegate
- (void)walletCellViewIsBindingAction:(id)sender {
    NSLog(@"去绑定");
}

// MARK: get
- (UIScrollView *)profitScrollView {
    if (!_profitScrollView) {
        _profitScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _profitScrollView.showsVerticalScrollIndicator = NO;
        _profitScrollView.showsHorizontalScrollIndicator = NO;
        _profitScrollView.bounces = YES;
    }
    return _profitScrollView;
}

- (TSWalletHeaderView *)walletHeaderView {
    if (!_walletHeaderView) {
        _walletHeaderView = [TSWalletHeaderView new];
        _walletHeaderView.image = KImageMake(@"mall_mine_wallet_bg");
        _walletHeaderView.userInteractionEnabled = YES;
        _walletHeaderView.kDelegate = self;
    }
    return _walletHeaderView;
}

- (TSWalletCellView *)walletCellView {
    if (!_walletCellView) {
        _walletCellView = [TSWalletCellView new];
        _walletCellView.userInteractionEnabled = YES;
        _walletCellView.kDelegate = self;
    }
    return _walletCellView;
}

- (UIButton *)problemBtn {
    if (!_problemBtn) {
        _problemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_problemBtn addTarget:self action:@selector(problemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_problemBtn setTitle:@"提现遇到问题？" forState:UIControlStateNormal];
        _problemBtn.titleLabel.font = KRegularFont(10);
        [_problemBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    }
    return _problemBtn;
}

- (UIButton *)withdrawalBtn {
    if (!_withdrawalBtn) {
        _withdrawalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawalBtn addTarget:self action:@selector(withdrawalAction:) forControlEvents:UIControlEventTouchUpInside];
        [_withdrawalBtn setTitle:@"去提现" forState:UIControlStateNormal];
        _withdrawalBtn.titleLabel.font = KRegularFont(16);
        [_withdrawalBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _withdrawalBtn.backgroundColor = KHexColor(@"#FF4D49");
    }
    return _withdrawalBtn;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [UILabel new];
        _tipsLab.font = KRegularFont(10);
        _tipsLab.textColor = KHexColor(@"#2D3132");
        _tipsLab.text = @"*最低提现门槛1元";
        _tipsLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLab;
}
@end
