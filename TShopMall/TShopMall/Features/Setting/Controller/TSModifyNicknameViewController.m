//
//  TSModifyNicknameViewController.m
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "TSModifyNicknameViewController.h"
#import "TSSettingDataController.h"
#import "TSClearButton.h"
#import "TSTools.h"
#import "TSUserInfoService.h"
#import <Toast.h>

@interface TSModifyNicknameViewController ()
/** 输入框视图  */
@property(nonatomic, weak) UIView *inputView;
/** 昵称输入框  */
@property(nonatomic, weak) UITextField *nickTextField;
/** 清除按钮  */
@property(nonatomic, weak) TSClearButton *clearButton;
/** 提示视图  */
@property(nonatomic, weak) UIView *tipsView;
/** 提示的文字  */
@property(nonatomic, weak) UILabel *tipsLabel;
/** 确定按钮  */
@property(nonatomic, weak) UIButton *confirmButton;
/** data  */
@property(nonatomic, strong) TSSettingDataController *dataController;

@end

@implementation TSModifyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化操作
    [self setUpInit];
}

- (void)setUpInit {
    self.gk_navTitle = @"修改昵称";
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(confirmAction)];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    ///添加约束
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(GK_STATUSBAR_NAVBAR_HEIGHT);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.nickTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top).with.offset(0);
        make.left.equalTo(self.inputView.mas_left).with.offset(16);
        make.right.equalTo(self.clearButton.mas_left).with.offset(0);
        make.bottom.equalTo(self.inputView.mas_bottom).with.offset(0);
    }];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top).with.offset(0);
        make.right.equalTo(self.inputView.mas_right).with.offset(0);
        make.bottom.equalTo(self.inputView.mas_bottom).with.offset(0);
        make.width.mas_equalTo(50);
    }];
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(25);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tipsView.mas_centerY).with.offset(0);
        make.left.equalTo(self.tipsView.mas_left).with.offset(16);
        make.right.equalTo(self.tipsView.mas_right).with.offset(0);
    }];
}

#pragma mark - Lazy Method

- (UIView *)inputView {
    if (_inputView == nil) {
        UIView *inputView = [[UIView alloc] init];
        _inputView = inputView;
        _inputView.backgroundColor = KWhiteColor;
        [self.view addSubview: _inputView];
    }
    return _inputView;
}

- (UITextField *)nickTextField {
    if (_nickTextField == nil) {
        UITextField *nickTextField = [[UITextField alloc] init];
        _nickTextField = nickTextField;
        _nickTextField.textColor = KHexColor(@"#2D3132");
        _nickTextField.backgroundColor = KWhiteColor;
        _nickTextField.font = KRegularFont(16);
        _nickTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:@{NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.2)}];
        //[_nickTextField addTarget:self
         //                  action:@selector(textFieldDidChangeValue:)
          //       forControlEvents:UIControlEventEditingChanged];
        [self.inputView addSubview:_nickTextField];
    }
    return _nickTextField;
}

- (TSClearButton *)clearButton {
    if (_clearButton == nil) {
        TSClearButton *clearButton = [[TSClearButton alloc] init];
        _clearButton = clearButton;
        [_clearButton setImage:KImageMake(@"mall_setting_clear") forState:(UIControlStateNormal)];
        [_clearButton addTarget:self action:@selector(clearText) forControlEvents:(UIControlEventTouchUpInside)];
        [self.inputView addSubview: _clearButton];
    }
    return _clearButton;
}

- (UIView *)tipsView {
    if (_tipsView == nil) {
        UIView *tipsView = [[UIView alloc] init];
        _tipsView = tipsView;
        _tipsView.backgroundColor = KHexColor(@"#FFF5F5");
        [self.view addSubview: _tipsView];
    }
    return _tipsView;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"*4-20个字符，可由中英文、数字、“-”、“·”组成";
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _tipsLabel.font = KRegularFont(12);
        [self.tipsView addSubview: _tipsLabel];
    }
    return _tipsLabel;
}

- (TSSettingDataController *)dataController {
    if (_dataController == nil) {
        _dataController = [[TSSettingDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - textFieldDidChangeValue
- (void)textFieldDidChangeValue:(UITextField *)textField {
    
}

#pragma mark - Actions

- (void)panAction: (UIPanGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

/** 清除文本 */
- (void)clearText {
    self.nickTextField.text = @"";
}
/** 提交按钮 */
- (void)confirmAction {
    [self.view endEditing:YES];
    if (self.nickTextField.text.length == 0) {
        [self.view makeToast:@"请输入昵称" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if (![TSTools isCorrectNickname:self.nickTextField.text]) {
        [self.view makeToast:@"请输入合法的昵称" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    if ([TSUserInfoManager userInfo].accountId.length == 0) {///返回登录
        return;
    }
    [Popover popProgressOnWindowWithText:@"提交中..."];
    [[TSServicesManager sharedInstance].userInfoService modifyUserInfoWithKey:@"nickname" value:self.nickTextField.text success:^ {
        ///发通知修改成功
        //[TSUserInfoManager userInfo].user.nickname = self.nickTextField.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:TSUserInfoModifiedNotificationName object:nil];
        [Popover popToastOnWindowWithText:@"昵称修改成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:errorMsg];
    }];
}

@end
