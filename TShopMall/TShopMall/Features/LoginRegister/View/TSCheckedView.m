//
//  TSCheckedView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSCheckedView.h"
#import "TSAgreementModel.h"

@interface TSCheckedView ()<UITextViewDelegate>

/** 阅读并同意按钮 */
@property(nonatomic, weak) UIButton *protocolButton;
/** check按钮 */
@property(nonatomic, weak) UIButton *checkButton;
/** 服务协议 */
@property(nonatomic, weak) UIButton *seviceButton;
/** 隐私协议 */
@property(nonatomic, weak) UIButton *privateButton;
/** 注册协议 */
@property(nonatomic, weak) UIButton *registerProtocolButton;
/** 服务协议 */
@property(nonatomic, weak) UITextView *textView;

@end

@implementation TSCheckedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints {
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.protocolButton.mas_centerY).with.offset(0);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        make.right.equalTo(self.protocolButton.mas_left).with.offset(-6);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.centerX.equalTo(self).offset(0);
        make.width.equalTo(@(kScreenWidth - 48)).priorityLow();
        make.top.equalTo(self.protocolButton.mas_bottom).with.offset(0);
    }];
}

- (UIButton *)checkButton {
    if (_checkButton == nil) {
        UIButton *checkButton = [[UIButton alloc] init];
        _checkButton = checkButton;
        _checkButton.selected = YES;
        _checked = YES;
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_uncheck") forState:UIControlStateNormal];
        [_checkButton setBackgroundImage:KImageMake(@"mall_login_checked") forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(checkingAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UIButton *)protocolButton {
    if (_protocolButton == nil) {
        UIButton *protocolButton = [[UIButton alloc] init];
        _protocolButton = protocolButton;
        _protocolButton.titleLabel.font = KRegularFont(14);
        [_protocolButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
        [_protocolButton setTitle:@"登录表示您已阅读并同意" forState:UIControlStateNormal];
        [self addSubview:_protocolButton];
    }
    return _protocolButton;
}

- (UITextView *)textView {
    if (_textView == nil) {
        UITextView *textView = [[UITextView alloc] init];
        _textView = textView;
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.backgroundColor = UIColor.clearColor;
        _textView.textColor = KTextColor;
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName:KHexColor(@"#E64C3D")};
        [self addSubview:_textView];
    }
    return _textView;
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    self.checkButton.selected = checked;
    if ([self.delegate respondsToSelector:@selector(checkedAction:)]) {
        [self.delegate checkedAction:checked];
    }
}

- (void)setAgreementModels:(NSArray<TSAgreementModel *> *)agreementModels {
    _agreementModels = agreementModels;
    NSMutableString *allString = [NSMutableString string];
    for (int i = 0; i < agreementModels.count; i++) {
        TSAgreementModel *agreementModel = agreementModels[i];
        NSString *_str = nil;
        if (i == agreementModels.count - 1) {
            _str = [NSString stringWithFormat:@"%@", agreementModel.title];
        } else {
            _str = [NSString stringWithFormat:@"%@、", agreementModel.title];
        }
        [allString appendString:_str];
    }
    NSDictionary *attributes = @{
        NSFontAttributeName: KRegularFont(14)
    };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allString attributes:attributes];
    for (int i = 0; i < agreementModels.count; i++) {
        TSAgreementModel *agreementModel = agreementModels[i];
        NSString *_str = nil;
        NSRange range;
        if (i == agreementModels.count - 1) {
            _str = [NSString stringWithFormat:@"%@", agreementModel.title];
        } else {
            _str = [NSString stringWithFormat:@"%@、", agreementModel.title];
        }
        range = [allString rangeOfString:_str];
        NSString *value = [[NSString stringWithFormat:@"tranfer%d://%@", i, _str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [attrString addAttribute:NSLinkAttributeName value:value range:range];
    }
    self.textView.attributedText = attrString;
    CGFloat width = [allString widthForFont:KRegularFont(14)];
    CGFloat left = (self.frame.size.width - 50 - width) / 2.0;
//    self.textView.contentInset = UIEdgeInsetsMake(-10, left, 0, 0);
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width + 20));
    }];
    
}

#pragma mark - Public Method


#pragma mark - Actions

- (void)checkingAction {
    self.checkButton.selected = !self.checkButton.isSelected;
    _checked = self.checkButton.isSelected;
    if ([self.delegate respondsToSelector:@selector(checkedAction:)]) {
        [self.delegate checkedAction:self.isChecked];
    }
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
