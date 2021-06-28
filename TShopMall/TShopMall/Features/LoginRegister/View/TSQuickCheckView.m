//
//  TSQuickCheckView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSQuickCheckView.h"

@interface TSQuickCheckView ()<UITextViewDelegate>
/** check按钮 */
@property(nonatomic, weak) UIButton *checkButton;
/** 服务协议 */
@property(nonatomic, weak) UITextView *textView;

@end

@implementation TSQuickCheckView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraints];
        [self setUpInit];
    }
    return self;
}

- (void)addConstraints {
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KRateH(18));
        make.height.mas_equalTo(KRateH(18));
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(25);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkButton.mas_right).with.offset(3);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
    }];
}

- (void)setUpInit {
    NSString *agreeStr = @"已阅读并同意以下协议：";
    NSString *certificationStr = @"《中国xx认证服务器条款》";
    NSString *serviceStr = @"《服务协议》";
    NSString *privateStr = @"《隐私政策》";
    NSString *allStr = [NSString stringWithFormat:@"%@%@%@%@", agreeStr, certificationStr, serviceStr, privateStr];
    NSRange agreeRange = [allStr rangeOfString:agreeStr];
    NSRange certificationRange = [allStr rangeOfString:certificationStr];
    NSRange serviceRange = [allStr rangeOfString:serviceStr];
    NSRange privateRange = [allStr rangeOfString:privateStr];
    NSDictionary *attributes = @{
        NSFontAttributeName: KRegularFont(14)
    };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allStr attributes:attributes];
    //NSString *valueAgree = [[NSString stringWithFormat:@"agreeProtocol://%@", agreeStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valueCertification = [[NSString stringWithFormat:@"certificationProtocol://%@", certificationStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valueService = [[NSString stringWithFormat:@"serviceProtocol://%@", serviceStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valuePrivate = [[NSString stringWithFormat:@"privateProtocol://%@", privateStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //[attrString addAttribute:NSLinkAttributeName value:valueAgree range:agreeRange];
    [attrString addAttribute:NSLinkAttributeName value:valueService range:serviceRange];
    [attrString addAttribute:NSLinkAttributeName value:valuePrivate range:privateRange];
    [attrString addAttribute:NSLinkAttributeName value:valueCertification range:certificationRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:KHexColor(@"#666666") range:agreeRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:certificationRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:serviceRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:privateRange];
    self.textView.attributedText = attrString;
    self.textView.linkTextAttributes = @{NSForegroundColorAttributeName:KHexColor(@"#E64C3D")};
}

- (UIButton *)checkButton {
    if (_checkButton == nil) {
        UIButton *checkButton = [[UIButton alloc] init];
        _checkButton = checkButton;
        _checkButton.selected = YES;
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_uncheck") forState:UIControlStateNormal];
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_checked") forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UITextView *)textView {
    if (_textView == nil) {
        UITextView *textView = [[UITextView alloc] init];
        _textView = textView;
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.backgroundColor = UIColor.clearColor;
        [self addSubview:_textView];
    }
    return _textView;
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    self.checkButton.selected = checked;
}

#pragma mark - Actions
- (void)checkAction {
    self.checkButton.selected = !self.checkButton.isSelected;
    _checked = self.checkButton.selected;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"certificationProtocol"]) {
        if ([self.delegate respondsToSelector:@selector(openAuthenticationProtocol)]) {
            [self.delegate openAuthenticationProtocol];
        }
    } else if ([[URL scheme] isEqualToString:@"serviceProtocol"]) {
        if ([self.delegate respondsToSelector:@selector(openServiceProtocol)]) {
            [self.delegate openServiceProtocol];
        }
    } else if ([[URL scheme] isEqualToString:@"privateProtocol"]) {
        if ([self.delegate respondsToSelector:@selector(openPrivateProtocol)]) {
            [self.delegate openPrivateProtocol];
        }
    }
    return YES;
}

@end
