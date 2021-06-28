//
//  TSMineWalletCenterViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSMineWalletCenterViewController.h"
#import "TSWalletCenterView.h"

#import "TSMineWalletViewController.h"
#import "TSBankCardViewController.h"

@interface TSMineWalletCenterViewController ()<TSWalletCenterViewDelegate>

@property (nonatomic ,strong) UIScrollView *mainScrollView;
@property (nonatomic ,strong) TSWalletCenterView *walletCenterView;
@end

@implementation TSMineWalletCenterViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"我的钱包";
}

-(void)fillCustomView{
    
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight - GK_STATUSBAR_NAVBAR_HEIGHT);
    self.mainScrollView.contentSize = self.mainScrollView.size;
    
    [self.mainScrollView addSubview:self.walletCenterView];
    self.walletCenterView.frame = CGRectMake(0, -13, kScreenWidth, 237);
}

// MARK: TSWalletCenterViewDelegate
- (void)walletCenterMineIncomeAction:(id _Nullable)sender {
    TSMineWalletViewController *vc = [TSMineWalletViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)walletBindingCardAction:(id _Nullable)sender {
    TSBankCardViewController *vc = [TSBankCardViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: get
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.bounces = YES;
    }
    return _mainScrollView;
}

- (TSWalletCenterView *)walletCenterView {
    if (!_walletCenterView) {
        _walletCenterView = [TSWalletCenterView new];
        _walletCenterView.image = KImageMake(@"mall_mine_wallet_bg");
        _walletCenterView.userInteractionEnabled = YES;
        _walletCenterView.kDelegate = self;
    }
    return _walletCenterView;
}
@end
