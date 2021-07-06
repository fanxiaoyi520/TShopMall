//
//  TSPayPasswordInputView.m
//  TShopMall
//
//  Created by edy on 2021/7/3.
//

#import "TSPayPasswordInputView.h"

#define MaxDotCount 6

@interface TSPayPasswordInputView ()<UITextFieldDelegate>
/** 密码输入框 */
@property (nonatomic, weak) UITextField *passwordTextField;
/** 保存显示密码点的按钮  */
@property(nonatomic, strong) NSMutableArray<TSPasswordShowButton *> *dotsArray;

@end

@implementation TSPayPasswordInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    self.backgroundColor = KWhiteColor;
    [self passwordTextField];
    ///设置子视图
    [self addSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat buttonWidth = 36;
    CGFloat buttonHeight = 36;
    CGFloat space = (width - 36 * MaxDotCount) / (MaxDotCount - 1);///间隔的宽度
    CGFloat buttonY = (height - buttonHeight) / 2.0;
    for (int i = 0; i < MaxDotCount; i++) {
        CGFloat buttonX = i * (buttonWidth + space);
        TSPasswordShowButton *showPwdButton = self.dotsArray[i];
        showPwdButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
}


///设置子视图
- (void)addSubviews {
    for (int i = 0; i < MaxDotCount; i++) {
        TSPasswordShowButton *showPwdButton = [self createPwdShowButton];
        [self.dotsArray addObject:showPwdButton];
    }
}

- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        UITextField *passwordTextField = [[UITextField alloc] init];
        _passwordTextField = passwordTextField;
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.hidden = YES;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.delegate = self;
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview: _passwordTextField];
    }
    return _passwordTextField;
}
/** 生成显示点的按钮 */
- (TSPasswordShowButton *)createPwdShowButton {
    TSPasswordShowButton *showPwdButton = [[TSPasswordShowButton alloc] init];
    showPwdButton.titleLabel.font = KFont(PingFangSCSemibold, 50);
    [showPwdButton setTitleColor:KTextColor forState:(UIControlStateNormal)];
    [showPwdButton setBackgroundColor:KHexColor(@"#F4F4F4")];
    [showPwdButton setCorners:UIRectCornerAllCorners radius:4];
    [self addSubview:showPwdButton];
    [showPwdButton addTarget:self action:@selector(showKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    return showPwdButton;
}

- (NSMutableArray<TSPasswordShowButton *> *)dotsArray {
    if (_dotsArray == nil) {
        NSMutableArray *dotsArray = [NSMutableArray array];
        _dotsArray = dotsArray;
    }
    return _dotsArray;
}

- (NSString *)getInputPassword {
    return self.passwordTextField.text;
}

- (void)showKeyboard {
    ///调起键盘
    [self.passwordTextField becomeFirstResponder];
}
/** 清理密码输入框 */
- (void)clear {
    self.passwordTextField.text = nil;
    for (int i = 0; i < self.dotsArray.count; i++) {///
        TSPasswordShowButton *pwdButton = self.dotsArray[i];
        [pwdButton setTitle:@"" forState:(UIControlStateNormal)];
    }
}
/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField {
    NSInteger count = textField.text.length;
    for (int i = 0; i < self.dotsArray.count; i++) {///
        TSPasswordShowButton *pwdButton = self.dotsArray[i];
        if (i < count) {
            [pwdButton setTitle:@"·" forState:(UIControlStateNormal)];
        } else {
            [pwdButton setTitle:@"" forState:(UIControlStateNormal)];
        }
    }
    if (count == MaxDotCount) {///输入完毕
        if ([self.delegate respondsToSelector:@selector(inputDoneActionWithPwd:)]) {
            [self.delegate inputDoneActionWithPwd:textField.text];
        }
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    } else if(textField.text.length >= MaxDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入=====");
        return NO;
    } else {
        return YES;
    }
    return YES;
}

@end

@implementation TSPasswordShowButton

- (void)setHighlighted:(BOOL)highlighted {}

@end
