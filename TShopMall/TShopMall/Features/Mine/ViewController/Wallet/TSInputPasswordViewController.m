//
//  TSInputPasswordViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/2.
//

#import "TSInputPasswordViewController.h"

@interface TSInputPasswordViewController ()

@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIButton *closeBtn;
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *smallLab;
@property (nonatomic ,strong)UILabel *amountLab;
@end

@implementation TSInputPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatView];
}

- (void)creatView {
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(36, 224, kScreenWidth-72, 220);
    [self.bgView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
    
    [self.bgView addSubview:self.closeBtn];
    _closeBtn.frame = CGRectMake(self.bgView.width-24-12, 16, 24, 24);
    [_closeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];

    
}

// MARK: actions
- (void)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

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
@end
