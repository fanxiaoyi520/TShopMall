//
//  TSQuickCheckView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSQuickCheckView.h"
#import "TSAgreementModel.h"

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
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        //make.top.equalTo(self.mas_top).with.offset(10);
        //make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.height.mas_equalTo(60);
    }];
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
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName:KHexColor(@"#E64C3D")};
        [self addSubview:_textView];
    }
    return _textView;
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    self.checkButton.selected = checked;
}

- (void)setAgreementModels:(NSArray<TSAgreementModel *> *)agreementModels {
    _agreementModels = agreementModels;
    NSMutableString *allString = [NSMutableString stringWithString:@"已阅读并同意以下协议："];
    for (int i = 0; i < agreementModels.count; i++) {
        TSAgreementModel *agreementModel = agreementModels[i];
        NSString *_str = [NSString stringWithFormat:@"《%@》", agreementModel.title];
        [allString appendString:_str];
    }
    NSDictionary *attributes = @{
        NSFontAttributeName: KRegularFont(14)
    };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allString attributes:attributes];
    NSRange agreeRange = [allString rangeOfString:@"已阅读并同意以下协议："];
    [attrString addAttribute:NSForegroundColorAttributeName value:KHexColor(@"#666666") range:agreeRange];
    for (int i = 0; i < agreementModels.count; i++) {
        TSAgreementModel *agreementModel = agreementModels[i];
        NSString *_str = [NSString stringWithFormat:@"《%@》", agreementModel.title];
        NSRange range = [allString rangeOfString:_str];
        NSString *value = [[NSString stringWithFormat:@"tranfer%d://%@", i, _str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [attrString addAttribute:NSLinkAttributeName value:value range:range];
    }
    self.textView.attributedText = attrString;
    //CGFloat width = [allString widthForFont:KRegularFont(14)];
    //CGFloat left = (self.frame.size.width - 50 - width) / 2.0;
    ///self.textView.contentInset = UIEdgeInsetsMake(-10, left, 0, 0);
}


#pragma mark - Actions
- (void)checkAction {
    self.checkButton.selected = !self.checkButton.isSelected;
    _checked = self.checkButton.selected;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *scheme = [URL scheme];
    if ([scheme containsString:@"tranfer"]) {
        NSString *indexString = [scheme substringFromIndex:scheme.length - 1];
        int index = [indexString intValue];
        if ([self.delegate respondsToSelector:@selector(goToH5WithAgreementModel:)]) {
            [self.delegate goToH5WithAgreementModel:self.agreementModels[index]];
        }
    }
    return YES;
}

@end
