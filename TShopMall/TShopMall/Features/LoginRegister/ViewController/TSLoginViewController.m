//
//  TSLoginViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSLoginViewController.h"
#import "TSQuickLoginTopView.h"
#import "TSLoginTopView.h"
#import "TSCheckedView.h"
#import "TSQuickCheckView.h"
#import "TSLoginBottomView.h"
#import "TSTools.h"
#import <Toast.h>
#import "TSRegiterViewController.h"
#import "NSTimer+TSBlcokTimer.h"
#import "TSLoginRegisterDataController.h"


@interface TSLoginViewController ()<TSQuickLoginTopViewDelegate, TSLoginTopViewDelegate, TSLoginBottomViewDelegate, TSCheckedViewDelegate, TSQuickCheckViewDelegate>
/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 关闭 */
@property(nonatomic, weak) UIButton *closeButton;
/** 页面top部分视图 */
@property(nonatomic, weak) TSLoginTopView *topView;
/** 一键登录的视图 */
@property(nonatomic, weak) TSQuickLoginTopView *quickView;
/** check视图 */
@property(nonatomic, weak) TSCheckedView *checkedView;
/** 快捷登录check视图 */
@property(nonatomic, weak) TSQuickCheckView *quickCheckView;
/** 底部视图 */
@property(nonatomic, weak) TSLoginBottomView *bottomView;
/** 验证码倒计时 */
@property(nonatomic, assign) NSInteger count;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) TSLoginRegisterDataController *dataController;

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dealloc {
    [self.timer invalidate];
}

- (void)fillCustomView {
    ///添加约束
    [self addConstraints];
}

- (void)setupBasic {
    self.count = 60;
    self.view.backgroundColor = UIColor.whiteColor;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)addConstraints {
    
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).offset(GK_STATUSBAR_HEIGHT + 4);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.closeButton.mas_bottom).with.offset(KRateH(66));
        make.bottom.equalTo(self.bottomView.mas_top).with.offset(0);
    }];
    [self.quickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.closeButton.mas_bottom).with.offset(KRateH(81));
        make.bottom.equalTo(self.bottomView.mas_top).with.offset(0);
    }];
    [self.checkedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-56);
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.quickCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-56);
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.checkedView.mas_top).with.offset(-30);
        make.left.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(KRateW(35));
    }];
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

#pragma mark - TSQuickLoginTopViewDelegate
/** 一键登录 */
- (void)quickLogin {
    if (!self.quickCheckView.isChecked) {
        [self.view makeToast:@"请阅读并同意以下协议" duration:3.0 position:CSToastPositionCenter];
        return;
    }
}

/** 其它登录方式 */
- (void)otherLogin {
    self.quickView.hidden = YES;
    self.quickCheckView.hidden = YES;
    self.checkedView.hidden = NO;
    self.topView.hidden = NO;
}

#pragma mark - TSLoginTopViewDelegate
/** 发送验证码 */
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
    
    [self.view endEditing:YES];
    
    NSString *mobile = [self.topView getPhoneNumber];
    
    __weak typeof(self) weakSelf = self;
    [self.dataController fetchLoginSMSCodeMobile:mobile complete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            
            strongSelf.timer = [NSTimer ts_scheduledTimerWithTimeInterval:1 block:^{
                 [weakSelf goToRun];
            } repeats:YES];
            
            [Popover popToastOnWindowWithText:@"获取验证码成功"];
            
        }else{
            [strongSelf.view makeToast:self.dataController.smsModel.failCause duration:2.0 position:CSToastPositionBottom];
        }
    }];
    
}

- (void)goToRegister {
    if (self.navigationController) {
        TSRegiterViewController *registerVC = [[TSRegiterViewController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)login {
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
    
    NSString *inputCode = [self.topView getCode];
    NSString *rightCode = self.dataController.smsModel.text;
    
    if (![inputCode isEqualToString:rightCode]) {//验证码输入错误
        [Popover popToastOnWindowWithText:@"验证码输入有误"];
    }
    
    [self.dataController fetchQuickLoginUsername:[self.topView getPhoneNumber]
                                       validCode:[self.topView getCode]
                                        complete:^(BOOL isSucess) {
            
    }];
}

- (void)closePage {
    NSLog(@"----");
}

#pragma mark - TSLoginBottomViewDelegate
- (void)goToWechat {
    
}

- (void)goToApple {
    
}

#pragma mark - TSCheckedViewDelegate
- (void)goToServiceProtocol {
    
}

- (void)goToPrivatePolicy {
    
}

- (void)goToRegisterProtocol {
    
}

- (void)checkedAction:(BOOL)isChecked{
    
}

#pragma mark - TSQuickCheckViewDelegate
/** 认证信息 */
- (void)openAuthenticationProtocol {
    
}
/** 服务协议 */
- (void)openServiceProtocol {
    
}
/** 隐私政策 */
- (void)openPrivateProtocol {
    
}

#pragma mark - Lazy Method
- (UIView *)topView {
    if (_topView == nil) {
        TSLoginTopView *topView = [[TSLoginTopView alloc] init];
        _topView = topView;
        _topView.delegate = self;
        _topView.hidden = YES;
        [self.view addSubview:topView];
    }
    return _topView;
}

- (UIView *)quickView {
    if (_quickView == nil) {
        TSQuickLoginTopView *quickView = [[TSQuickLoginTopView alloc] init];
        _quickView = quickView;
        _quickView.quickDelegate = self;
        [self.view addSubview:_quickView];
    }
    return _quickView;
}

- (TSCheckedView *)checkedView {
    if (_checkedView == nil) {
        TSCheckedView *checkedView = [[TSCheckedView alloc] init];
        _checkedView = checkedView;
        _checkedView.hidden = YES;
        _checkedView.delegate = self;
        [self.view addSubview:_checkedView];
    }
    return _checkedView;
}

- (TSQuickCheckView *)quickCheckView {
    if (_quickCheckView == nil) {
        TSQuickCheckView *quickCheckView = [[TSQuickCheckView alloc] init];
        _quickCheckView = quickCheckView;
        _quickCheckView.delegate = self;
        [self.view addSubview:_quickCheckView];
    }
    return _quickCheckView;
}

- (TSLoginBottomView *)bottomView {
    if (_bottomView == nil) {
        TSLoginBottomView *bottomView = [[TSLoginBottomView alloc] init];
        _bottomView = bottomView;
        _bottomView.delegate = self;
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

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

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_login_bg");
        [self.view addSubview:_bgImgV];
    }
    return _bgImgV;
}

-(TSLoginRegisterDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSLoginRegisterDataController alloc] init];
    }
    return _dataController;
}

@end
