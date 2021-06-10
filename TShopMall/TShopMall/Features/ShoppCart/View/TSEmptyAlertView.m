//
//  TSEmptyAlertView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/10.
//

#import "TSEmptyAlertView.h"

@interface TSEmptyAlertView()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIButton *alertBtn;

@property (nonatomic, copy) void(^click)(void);
@end

@implementation TSEmptyAlertView

+ (void)hideInView:(UIView *)inView{
    for (UIView *view in inView.subviews) {
        if ([view isKindOfClass:[TSEmptyAlertView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

- (TSEmptyAlertView *(^)(UIColor *))alertBackColor{
    return ^(UIColor *bgColor){
        self.backgroundColor = bgColor;
        return self;
    };
}

- (TSEmptyAlertView *(^)(NSString *))alertImage{
    return ^(NSString *alertImg){
        self.icon.image = KImageMake(alertImg);
        return self;
    };
}

- (TSEmptyAlertView *(^)(NSString *, NSString *))alertInfo{
    return ^(NSString *tips, NSString *btnStr){
        self.tips.text = tips;
        [self.alertBtn setTitle:btnStr forState:UIControlStateNormal];
        if (btnStr.length == 0) {
            self.alertBtn.hidden = YES;
        }
        return self;
    };
}

- (TSEmptyAlertView *(^)(UIView *, void (^)(void)))show{
    return ^(UIView *inView, void(^click)(void)){
        self.click = click;
        [self showInView:inView];
        return self;
    };
}

- (void)showInView:(UIView *)inView{
    [inView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(inView);
    }];
}

- (void)alertBtnAction{
    if (self.click) {
        self.click();
    }
}

- (void)layoutSubviews{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(KRateW(114.0));
        make.width.mas_equalTo(KRateW(199.0));
        make.height.mas_equalTo(KRateW(168.0));
        make.centerX.equalTo(self);
    }];
    
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(KRateW(16.0));
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
    }];
    
    [self.alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tips.mas_bottom).offset(KRateW(16.0));
        make.height.mas_equalTo(KRateW(38.0));
        make.width.mas_equalTo(KRateW(104.0));
    }];
}

- (UIImageView *)icon{
    if (_icon) {
        return _icon;
    }
    self.icon = [UIImageView new];
    self.icon.image = KImageMake(@"alert_empty");
    [self addSubview:self.icon];
    
    return self.icon;
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    self.tips.numberOfLines = 0;
    self.tips.textAlignment = NSTextAlignmentCenter;
    self.tips.font = KRegularFont(14.0);
    self.tips.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.tips];
    
    return self.tips;
}

- (UIButton *)alertBtn{
    if (_alertBtn) {
        return _alertBtn;
    }
    self.alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertBtn setBackgroundImage:KImageMake(@"cart_settle_bg") forState:UIControlStateNormal];
    self.alertBtn.titleLabel.font = KRegularFont(16.0);
    [self.alertBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.alertBtn addTarget:self action:@selector(alertBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.alertBtn];
    
    return self.alertBtn;
}

@end
