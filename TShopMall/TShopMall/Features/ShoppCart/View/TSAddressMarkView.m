//
//  TSAddressMarkView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSAddressMarkView.h"
#import <Toast.h>

@interface TSAddressMarkEditView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *btn;
@end

@interface TSAddressMarkView()
@property (nonatomic, strong) UILabel *title;
//@property (nonatomic, strong) UIButton *showMoreBtn;
//@property (nonatomic, strong) TSAddressMarkEditView *editView;
//@property (nonatomic, strong) UIView *lastMarkView;
@end

@implementation TSAddressMarkView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutView];
        [self configMarks];
    }
    return self;
}

- (void)configMarks{
    NSArray *marks = @[@"家", @"公司", @"学校"];
    for (NSInteger i=0; i<marks.count; i++) {
        CGFloat edgX = KRateW(10.0);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:KHexColor(@"ffffff") forState:UIControlStateSelected];
        [btn setTitleColor:KHexColor(@"#1E1C27") forState:UIControlStateNormal];
        btn.titleLabel.font = KRegularFont(12.0);
        btn.layer.cornerRadius = KRateW(11.0);
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = KHexColor(@"#F1F1F1");
        [btn setTitle:marks[i] forState:UIControlStateNormal];
        [self addSubview:btn];
//        btn.frame = CGRectMake(KRateW(22.0) + (KRateW(46.0) + edgX) * i, KRateW(40.0), KRateW(46.0), KRateW(22.0));
        [btn addTarget:self action:@selector(markSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(KRateW(32.0) + (KRateW(46.0) + edgX) * i);
            make.centerY.mas_equalTo(self.title);
            make.height.mas_equalTo(KRateW(22.0));
            make.width.mas_equalTo(KRateW(46.0));
            make.bottom.equalTo(self.mas_bottom).offset(-KRateW(16.0));
        }];
    }
}

- (void)markSelected:(UIButton *)sender{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.tag == sender.tag){
                btn.selected = YES;
                btn.backgroundColor = KHexColor(@"#FF4D49");
            } else {
                btn.selected = NO;
                btn.backgroundColor = KHexColor(@"#F1F1F1");
            }
        }
    }
    
    if (self.markChanged) {
        self.markChanged(sender.titleLabel.text);
    }
}

- (void)setCurrentMark:(NSString *)currentMark{
    _currentMark = currentMark;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if ([btn.titleLabel.text isEqualToString:currentMark]){
                btn.selected = YES;
                btn.backgroundColor = KHexColor(@"#FF4D49");
            } else {
                btn.selected = NO;
                btn.backgroundColor = KHexColor(@"#F1F1F1");
            }
        }
    }
}

//- (NSString *)newMark{
//    if (self.editView.textField.text.length != 0 &&
//        [self.editView.btn.titleLabel.text isEqualToString:@"编辑"]) {
//        return self.editView.textField.text;
//    }
//    return @"";
//}

//- (void)configMarks{
//    self.marks = @[@"家", @"公司", @"学校"];
//    for (NSInteger i=0; i<self.marks.count; i++) {
//        [self creatMark:self.marks[i]];
//    }
//
//    [self updateEditView];
//}
//
//- (void)creatMark:(NSString *)str{
//    CGFloat markHeight = KRateW(22.0);
//    CGFloat edgX = KRateW(10.0);
//    UILabel *la = [UILabel new];
//    la.font = KRegularFont(12.0);
//    la.text = str;
//    la.layer.cornerRadius = KRateW(11.0);
//    la.layer.masksToBounds = YES;
//    la.backgroundColor = KHexColor(@"#F1F1F1");
//    la.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:la];
//
//    CGFloat strWidth = [str widthForFont:KRegularFont(12.0)];
//    CGFloat laWidth = strWidth + KRateW(24.0);
//    CGRect frame;
//    frame.size = CGSizeMake(laWidth, markHeight);
//    if (self.lastMarkView.frame.size.width <= 2) {
//        frame.origin = CGPointMake(KRateW(22.0), KRateW(40.0) + KRateW(6.0));
//    } else {
//        frame.origin = CGPointMake(self.lastMarkView.x + self.lastMarkView.width + edgX, self.lastMarkView.y);
//    }
//    if (frame.origin.x + frame.size.width > kScreenWidth - KRateW(16.0 + 12.0 + 16.0)) {
//        frame.origin = CGPointMake(KRateW(22.0), frame.origin.y + frame.size.height + KRateW(6.0));
//    }
//
//    la.frame = frame;
//    self.lastMarkView = la;
//}
//
//- (void)showMore:(UIButton *)sender{
//    sender.selected = !sender.selected;
//}
//
- (void)layoutView{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.mas_top).offset(KRateW(14.0));
        make.height.mas_offset(KRateW(20.0));
    }];

//    [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
//        make.width.height.mas_equalTo(KRateW(12.0));
//        make.top.equalTo(self.title.mas_bottom).offset(KRateW(12.0));
//    }];
//
//    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(KRateW(22.0));
//        make.top.equalTo(self.title.mas_bottom).offset(KRateW(6.0));
//        make.height.mas_equalTo(KRateW(24.0));
//        make.bottom.equalTo(self.mas_bottom).offset(-KRateW(12.0)).priorityHigh();
//    }];
}
//
//- (void)updateEditView{
//    if (self.lastMarkView == nil) {
//        return;
//    }
//    CGFloat y = self.lastMarkView.y + self.lastMarkView.height + KRateW(12.0) - KRateW(34.0);
//    [self.editView layoutIfNeeded];
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.editView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.title.mas_bottom).offset(y);
//        }];
//    } completion:^(BOOL finished) {
//        [self layoutSubviews];
//    }];
//}
//
- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.font = KRegularFont(14.0);
    self.title.textColor = KHexColor(@"#2F2F2F");
    self.title.text = @"标签:";
    [self addSubview:self.title];

    return self.title;
}
//
//- (UIButton *)showMoreBtn{
//    if (_showMoreBtn) {
//        return _showMoreBtn;
//    }
//    self.showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.showMoreBtn.hidden = YES;
//    [self.showMoreBtn setBackgroundImage:KImageMake(@"inde_down") forState:UIControlStateNormal];
//    [self.showMoreBtn setBackgroundImage:KImageMake(@"inde_up") forState:UIControlStateSelected];
//    [self.showMoreBtn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.showMoreBtn];
//
//    return self.showMoreBtn;
//}
//
//- (TSAddressMarkEditView *)editView{
//    if (_editView) {
//        return _editView;
//    }
//    self.editView = [TSAddressMarkEditView new];
//    [self addSubview:self.editView];
//
//    return self.editView;
//}

@end


@implementation TSAddressMarkEditView

- (instancetype)init{
    if (self == [super init]) {
        self.layer.cornerRadius = KRateW(12.0);
        self.layer.masksToBounds = YES;
        [self layoutView];
        [self updateUIStatus:0];
    }
    return self;
}

- (void)btnAction:(UIButton *)sender{
    NSString *str = sender.titleLabel.text;
    if ([str isEqualToString:@"编辑"]) {
        [self updateUIStatus:1];
    } else if ([str isEqualToString:@"完成"]) {
        if (self.textField.text.length == 0) {
            [self.superview makeToast:@"请输入标签" duration:2.0 position:CSToastPositionBottom];
            return;
        }
        [self updateUIStatus:2];
    } else {
        [self updateUIStatus:1];
    }
}

- (void)layoutView{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
        make.width.mas_equalTo(0);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right).offset(1);
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(KRateW(48.0));
        make.right.equalTo(self.mas_right).priorityHigh();
    }];
}

- (void)updateUIStatus:(NSInteger)status{
    CGFloat textWidth = 0;
    CGFloat btnWidth = KRateW(48.0);
    CGFloat textFieldLeftViewWidth = KRateW(4.0);
    self.backgroundColor = KHexColor(@"#F1F1F1");
    if (status == 0) {
        [self.btn setBackgroundImage:KImageMake(@"address_mark_add") forState:UIControlStateNormal];
        [self.btn setTitle:@"" forState:UIControlStateNormal];
        self.textField.enabled = NO;
        textFieldLeftViewWidth = 0;
    } else if (status == 1){
        [self.btn setBackgroundImage:KImageMake(@"") forState:UIControlStateNormal];
        [self.btn setTitle:@"完成" forState:UIControlStateNormal];
        self.btn.backgroundColor = KHexColor(@"#FF4D49");
        self.textField.backgroundColor = UIColor.clearColor;
        self.textField.enabled = YES;
        textWidth = KRateW(169.0);
        btnWidth = KRateW(32.0);
    } else{
        [self.btn setBackgroundImage:KImageMake(@"") forState:UIControlStateNormal];
        [self.btn setTitle:@"编辑" forState:UIControlStateNormal];
        self.btn.backgroundColor  = UIColor.blueColor;
        self.textField.enabled = NO;
        self.textField.backgroundColor = UIColor.blueColor;
        textWidth = KRateW(80.0);
        btnWidth = KRateW(32.0);
    }
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textFieldLeftViewWidth, KRateW(22.0))];
    self.textField.leftView = leftView;
    [UIView animateWithDuration:0.3 animations:^{
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(textWidth);
        }];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(btnWidth).priorityHigh();
        }];
    } completion:^(BOOL finished) {
        [self layoutSubviews];
    }];
}

- (UIButton *)btn{
    if (_btn) {
        return _btn;
    }
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.titleLabel.font = KRegularFont(12.0);
    [self.btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    
    return self.btn;
}

- (UITextField *)textField{
    if (_textField) {
        return _textField;
    }
    self.textField = [UITextField new];
    self.textField.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KRateW(4.0), KRateW(22.0))];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.placeholder = @"请输入标签名称，最多5字";
    self.textField.font = KRegularFont(12.0);
    self.textField.textColor = KHexColor(@"#1E1C27");
    [self addSubview:self.textField];
    
    return self.textField;
}

@end
