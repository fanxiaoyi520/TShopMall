//
//  TSRegiterViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSRegiterViewController.h"
#import "TSRegisterTopView.h"
#import "TSCheckedView.h"
#import <Toast.h>
#import "TSTools.h"

@interface TSRegiterViewController ()<TSRegisterTopViewDelegate, TSCheckedViewDelegate>
/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 关闭 */
@property(nonatomic, weak) UIButton *closeButton;
/** 页面top部分视图 */
@property(nonatomic, weak) TSRegisterTopView *topView;
/** check视图 */
@property(nonatomic, weak) TSCheckedView *checkedView;
/** 验证码倒计时 */
@property(nonatomic, assign) NSInteger count;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TSRegiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)fillCustomView {
    ///添加约束
    [self addConstraints];
}

- (void)setupBasic {
    self.count = 60;
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)addConstraints {
    CGRect rectNav = self.navigationController.navigationBar.frame;
    int top = rectNav.size.height - 10;
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view).with.offset(0);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.top.equalTo(self.view.mas_top).with.offset(top);
        make.width.mas_equalTo(15.56 * 2);
        make.height.mas_equalTo(15.14 * 2);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.closeButton.mas_bottom).with.offset(KRateH(66));
        make.bottom.equalTo(self.checkedView.mas_top).with.offset(0);
    }];
    [self.checkedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-56);
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - Lazy Method

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        UIButton *closeButton = [[UIButton alloc] init];
        _closeButton = closeButton;
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton setBackgroundImage:KImageMake(@"mall_login_close") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_closeButton];
    }
    return _closeButton;
}

- (UIView *)topView {
    if (_topView == nil) {
        TSRegisterTopView *topView = [[TSRegisterTopView alloc] init];
        _topView = topView;
        _topView.delegate = self;
        [self.view addSubview:topView];
    }
    return _topView;
}

- (TSCheckedView *)checkedView {
    if (_checkedView == nil) {
        TSCheckedView *checkedView = [[TSCheckedView alloc] init];
        _checkedView = checkedView;
        _checkedView.delegate = self;
        [self.view addSubview:_checkedView];
    }
    return _checkedView;
}

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_login_bg");
        [self.view addSubview:_bgImgV];
    }
    return _bgImgV;
}

#pragma mark - TSRegisterTopViewDelegate
- (void)registerAction {
    NSString *phoneNumber = [self.topView getPhoneNumber];
    if (phoneNumber.length == 0) {
        [self.view makeToast:@"请输入手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (![TSTools isPhoneNumber: phoneNumber]) {
        [self.view makeToast:@"请输入正确的手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.topView getCode].length == 0) {
        [self.view makeToast:@"请输入验证码" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (!self.checkedView.isChecked) {
        [self.view makeToast:@"请阅读并同意以下协议" duration:3.0 position:CSToastPositionCenter];
        return;
    }
}

- (void)sendCode {
    NSString *phoneNumber = [self.topView getPhoneNumber];
    if (phoneNumber.length == 0) {
        [self.view makeToast:@"请输入手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (![TSTools isPhoneNumber: phoneNumber]) {
        [self.view makeToast:@"请输入正确的手机号" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(goToRun) userInfo:nil repeats:YES];
}

- (void)inputDoneAction {
    if (self.checkedView.isChecked) {
        [self.topView setRegisterBtnEnable:YES];
    }
}

#pragma mark - Actions
- (void)goToRun {
    if (self.count <= 1) {
        self.count = 60;
        [self.timer invalidate];
        [self.topView setCodeButtonTitleAndColor:@"重新验证码" isResend:YES];
    } else {
        self.count--;
        [self.topView setCodeButtonTitleAndColor:[NSString stringWithFormat:@"重发 %ld", (long)self.count] isResend:NO];
    }
}

- (void)closePage {
    if (self.navigationController && self.navigationController.childViewControllers.count >= 2) {
            [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TSCheckedViewDelegate
- (void)goToServiceProtocol {
    
}

- (void)goToPrivatePolicy {
    
}

- (void)goToRegisterProtocol {
    
}

- (void)checkedAction:(BOOL)isChecked {
    [self.topView setRegisterBtnEnable:isChecked];
}

@end


