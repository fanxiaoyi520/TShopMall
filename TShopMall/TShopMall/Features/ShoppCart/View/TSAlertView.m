//
//  TSAlertView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSAlertView.h"

@interface TSAlertView()
@property (nonatomic, strong) UIView *card;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *message;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, copy) AlertAction confirmAction;
@property (nonatomic, copy) AlertAction cancelAction;
@end

@implementation TSAlertView

- (instancetype)init{
    if (self == [super init]){
        self.backgroundColor = KHexAlphaColor(@"#000000", 0.5);
        self.confirmBtn.hidden =  YES;
        self.cancelBtn.hidden = YES;
    }
    return self;
}

- (TSAlertView *(^)(NSString *,id))alertInfo{
    return ^(NSString *title, id message){
        self.title.text = title;
        if ([message isKindOfClass:[NSAttributedString class]]) {
            self.message.attributedText = message;
        } else {
            self.message.text = message;
        }
        return self;
    };
}

- (TSAlertView *(^)(NSString *, AlertAction))confirm{
    return ^(NSString *str, AlertAction action){
        [self.confirmBtn setTitle:str forState:UIControlStateNormal];
        self.confirmAction = action;
        self.confirmBtn.hidden = NO;
        return self;
    };
}

- (TSAlertView *(^)(NSString *, AlertAction))cancel{
    return ^(NSString *str, AlertAction action){
        [self.cancelBtn setTitle:str forState:UIControlStateNormal];
        self.cancelAction = action;
        self.cancelBtn.hidden = NO;
        return self;
    };
}

- (TSAlertView *(^)(void))show{
    return ^(){
        [self showAlert];
        [self configUI];
        return self;
    };
}

- (void)showAlert{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [window addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
//        [self configUI];
    }];
}

- (void)hideAlert{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)configUI{
    
    [self.card mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.center.equalTo(self);
    }];
    
    CGFloat titleHeight = self.title.text.length==0? 0:KRateW(44.0);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.card);
        make.height.mas_equalTo(titleHeight);
    }];
    UIView *lineA = [self line];
    CGFloat lineHeight = self.title.text.length==0? 0:1;
    [lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.card);
        make.top.equalTo(self.title.mas_bottom);
        make.height.mas_equalTo(lineHeight);
    }];
    
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.card.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.card.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(lineA.mas_bottom).offset(KRateW(40.0));
    }];
    
    UIView *lineB = [self line];
    [lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.card);
        make.top.equalTo(self.message.mas_bottom).offset(KRateW(40.0));
        make.height.mas_equalTo(1);
    }];
    
    CGFloat btnWidth = (kScreenWidth - KRateW(16.0) * 2) / 2.0;
    if (self.confirmBtn.hidden == YES ||
        self.cancelBtn.hidden == YES ) {
        btnWidth = btnWidth * 2.0;
    }
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.card.mas_right);
        make.bottom.equalTo(self.card.mas_bottom);
        make.top.equalTo(lineB.mas_bottom);
        make.height.mas_equalTo(KRateW(55.0));
        make.width.mas_offset(btnWidth);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.card.mas_left);
        make.top.bottom.equalTo(self.confirmBtn);
        make.width.mas_equalTo(btnWidth);
    }];
    
    if (self.confirmBtn.hidden == NO ||
        self.cancelBtn.hidden == NO ) {
        UIView *lineC = [self line];
        [lineC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.card);
            make.top.equalTo(lineB.mas_bottom);
            make.bottom.equalTo(self.card.mas_bottom);
            make.width.mas_equalTo(1);
        }];
    }
}

- (void)confirmBtnAction{
    self.confirmAction();
    [self hideAlert];
}

- (void)cancelBtnAction{
    self.cancelAction();
    [self hideAlert];
}

- (UIView *)card{
    if (_card) {
        return _card;
    }
    self.card = [UIView new];
    self.card.backgroundColor = UIColor.whiteColor;
    self.card.layer.cornerRadius = KRateW(8.0);
    [self addSubview:self.card];
    
    return self.card;
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.textColor = KHexColor(@"#2D3132");
    self.title.font = KRegularFont(18.0);
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.card addSubview:self.title];
    
    return self.title;
}

- (UILabel *)message{
    if (_message) {
        return _message;
    }
    self.message = [UILabel new];
    self.message.numberOfLines = 0;
    self.message.textColor = KHexColor(@"#2D3132");
    self.message.font = KRegularFont(16.0);
    self.message.textAlignment = NSTextAlignmentCenter;
    [self.card addSubview:self.message];
    
    return self.message;
}

- (UIButton *)confirmBtn{
    if (_confirmBtn) {
        return _confirmBtn;
    }
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = KRegularFont(18.0);
    [self.confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.card addSubview:self.confirmBtn];
    
    return self.confirmBtn;
}

- (UIButton *)cancelBtn{
    if (_cancelBtn) {
        return _cancelBtn;
    }
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = KRegularFont(18.0);
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.card addSubview:self.cancelBtn];
    
    return self.cancelBtn;
}

- (UIView *)line{
    UIView *a = [UIView new];
    a.backgroundColor = KHexColor(@"#E6E6E6");
    [self.card addSubview:a];
    return a;
}

@end
