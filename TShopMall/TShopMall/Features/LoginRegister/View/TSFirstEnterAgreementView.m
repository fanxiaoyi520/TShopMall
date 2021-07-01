//
//  TSFirstEnterAgreementView.m
//  TShopMall
//
//  Created by edy on 2021/6/28.
//

#import "TSFirstEnterAgreementView.h"

@interface TSFirstEnterAgreementView ()<UITextViewDelegate>
/** 背景视图 */
@property(nonatomic, weak) UIView *contentView;
/** 标题  */
@property(nonatomic, weak) UILabel *titleLabel;
/** 内容  */
@property(nonatomic, weak) UILabel *contentLabel;
/** 服务协议 */
@property(nonatomic, weak) UITextView *textView;
/** 取消 */
@property(nonatomic, weak) UIButton *cancelButton;
/** 确认按钮 */
@property(nonatomic, weak) UIButton *confirmButton;

/** 协议信息  */
@property(nonatomic, strong) NSArray<TSAgreementModel *> *agreementModels;

@end

@implementation TSFirstEnterAgreementView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    [self getAgreementInfo];
    self.contentView.backgroundColor = KWhiteColor;
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.contentView.frame = CGRectMake(KRateW(36), kScreenHeight, kScreenWidth - KRateW(36) * 2, 378);
    [self.contentView setCorners:UIRectCornerAllCorners radius:12];
    ///设置约束
    [self addConstraints];
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    } else {
        [view addSubview:self];
    }
    self.alpha = 0;
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = (kScreenHeight - 378) / 2.0;
        self.contentView.frame = rect;
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = rect;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.contentView.mas_top).with.offset(24);
        make.height.mas_equalTo(52);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(24);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(16);
        make.bottom.equalTo(self.cancelButton.mas_top).with.offset(-25);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        //make.right.equalTo(self.confirmButton.mas_left).with.offset(-11);
        make.width.equalTo(self.confirmButton.mas_width).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-25);
        make.height.mas_equalTo(40);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right).with.offset(11);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.width.equalTo(self.cancelButton.mas_width).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-25);
        make.height.mas_equalTo(40);
    }];
}

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"欢迎来到TCL App\n  请你阅读如下内容：";
        _titleLabel.font = KFont(PingFangSCMedium, 18);
        _titleLabel.textColor = KTextColor;
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview: _titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        _contentLabel.text = @"你的信任对我们至关重要，TCL App将持续采取互联网行业的通行技术措施和数据安全保障措施，全力保护你的个人信息安全";
        _contentLabel.font = KRegularFont(12);
        _contentLabel.textColor = KTextColor;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview: _contentLabel];
    }
    return _contentLabel;
}

- (UITextView *)textView {
    if (_textView == nil) {
        UITextView *textView = [[UITextView alloc] init];
        _textView = textView;
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.backgroundColor = UIColor.clearColor;
        _textView.textColor = UIColor.greenColor;//KTextColor;
        _textView.font = KRegularFont(12);
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName:KHexColor(@"#E64C3D")};
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *cancelButton = [[UIButton alloc] init];
        _cancelButton = cancelButton;
        _cancelButton.titleLabel.font = KRegularFont(16);
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 20;
        _cancelButton.clipsToBounds = YES;
        _cancelButton.layer.borderWidth = 1.0;
        _cancelButton.layer.borderColor = KHexColor(@"#535558").CGColor;
        [_cancelButton setTitleColor:KTextColor forState:UIControlStateNormal];
        [_cancelButton setTitle:@"暂不使用" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        UIButton *confirmButton = [[UIButton alloc] init];
        _confirmButton = confirmButton;
        _confirmButton.titleLabel.font = KRegularFont(16);
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 20;
        _confirmButton.backgroundColor = KHexColor(@"#FF4D49");
        [_confirmButton setTitle:@"同意并进入" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (void)setAgreementModels:(NSArray<TSAgreementModel *> *)agreementModels {
    _agreementModels = agreementModels;
    NSMutableString *allString = [NSMutableString stringWithString:@"请你仔细阅读已更新的"];
    for (int i = 0; i < agreementModels.count; i++) {
        TSAgreementModel *agreementModel = agreementModels[i];
        NSString *_str = [NSString stringWithFormat:@"《%@》", agreementModel.title];
        [allString appendString:_str];
    }
    [allString appendString:@"。当你点击「同意并进入」即表示你已充分阅读、理解并接受以上协议的全部内容。"];
    NSDictionary *attributes = @{
        NSFontAttributeName: KRegularFont(14)
    };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allString attributes:attributes];
    [attrString addAttribute:NSForegroundColorAttributeName value:KTextColor range:NSMakeRange(0, allString.length)];
    [attrString addAttribute:NSFontAttributeName value:KRegularFont(12) range:NSMakeRange(0, allString.length)];
    NSRange agreeRange = [allString rangeOfString:@"「同意并进入」"];
    [attrString addAttribute:NSFontAttributeName value:KFont(PingFangSCSemibold, 12) range:agreeRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:KTextColor range:agreeRange];
    for (int i = 0; i < agreementModels.count; i++) {
        TSAgreementModel *agreementModel = agreementModels[i];
        NSString *_str = [NSString stringWithFormat:@"《%@》", agreementModel.title];
        NSRange range = [allString rangeOfString:_str];
        NSString *value = [[NSString stringWithFormat:@"tranfer%d://%@", i, _str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [attrString addAttribute:NSLinkAttributeName value:value range:range];
        [attrString addAttribute:NSFontAttributeName value:KRegularFont(12) range:range];
    }
    self.textView.attributedText = attrString;
    self.textView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
}

- (void)getAgreementInfo {
    __weak typeof(self) _weakSelf = self;
    [[TSServicesManager sharedInstance].acconutService fetchAgreementWithCompleted:^(NSArray<TSAgreementModel *> * _Nonnull agreementModels) {
        _weakSelf.agreementModels = agreementModels;
    }];
}

#pragma mark - Actions
/** 暂不使用 */
- (void)cancelAction {
    //退出程序
    exit(0);
}
/** 同意并进入 */
- (void)confirmAction {
    [TSGlobalManager shareInstance].firstStartApp = NO;
    [self dismiss];
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
