//
//  TSOperationBankTipsViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSOperationBankTipsViewController.h"

@interface TSOperationBankTipsViewController ()

@property (nonatomic ,strong) UIImageView *tipsImageView;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UILabel *tipsDetailLab;
@end

@implementation TSOperationBankTipsViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = self.kNavTitle;
}
      
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.kNavTitle isEqualToString:@"添加银行卡"])
        [[TSGlobalNotifyServer sharedServer] postAddBankCard:nil];
}

- (void)backItemClick:(id)sender {
    if ([self.kNavTitle isEqualToString:@"添加银行卡"]) {
        NSArray *pushVCAry = [self.navigationController viewControllers];
        UIViewController *vc = [pushVCAry objectAtIndex:pushVCAry.count-2];
        [self.navigationController popToViewController:vc animated:YES];
    } else {
        
    }
}

- (void)fillCustomView {
    [self.view addSubview:self.tipsImageView];
    [self.view addSubview:self.tipsLab];
    [self.view addSubview:self.tipsDetailLab];
    
    self.tipsImageView.frame = CGRectMake((kScreenWidth - 259)/2, GK_STATUSBAR_NAVBAR_HEIGHT + 53, 259, 220);
    self.tipsLab.frame = CGRectMake(0, self.tipsImageView.bottom, kScreenWidth, 28);
    self.tipsDetailLab.frame = CGRectMake(0, self.tipsLab.bottom+8, kScreenWidth, 18);
    
    if ([self.kNavTitle isEqualToString:@"添加银行卡"]) {
        self.tipsDetailLab.text = @"服务人员将在24小时内进行审查";
        self.tipsLab.text = @"提交成功";
    } else {
        self.tipsDetailLab.hidden = YES;
        self.tipsLab.text = @"解绑成功";
    }
}

// MARK: get
- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        _tipsImageView = [UIImageView new];
        _tipsImageView.image = KImageMake(@"mine_tips_bg");
    }
    return _tipsImageView;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [UILabel new];
        _tipsLab.textColor = KHexColor(@"#2D3132");
        _tipsLab.font = KRegularFont(18);
        _tipsLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLab;
}

- (UILabel *)tipsDetailLab {
    if (!_tipsDetailLab) {
        _tipsDetailLab = [UILabel new];
        _tipsDetailLab.textColor = KHexAlphaColor(@"#2D3132",.5);
        _tipsDetailLab.font = KRegularFont(12);
        _tipsDetailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsDetailLab;
}
@end
