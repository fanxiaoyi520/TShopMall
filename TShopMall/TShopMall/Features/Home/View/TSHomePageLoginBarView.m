//
//  TSHomePageLoginBarView.m
//  TShopMall
//
//  Created by sway on 2021/6/18.
//

#import "TSHomePageLoginBarView.h"
@interface TSHomePageLoginBarView()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *loginButton;

@end
@implementation TSHomePageLoginBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.height/2;
        self.clipsToBounds = YES;
        self.backgroundColor = KHexAlphaColor(@"000000", .6);
        [self layoutIfNeeded];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.width.equalTo(@(32));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.iconView.mas_right).offset(9);
    }];
    
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.right.equalTo(self).offset(-9);
        make.width.equalTo(@(88));

    }];
}

- (void)clickAction{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.image = [UIImage imageNamed:@"homePage_Login_icon"];
        
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = KFont(PingFangSCRegular, 14);
        _titleLabel.textColor = KWhiteColor;
        _titleLabel.text = @"登录TCL之家开启更多优惠";
    }
    return _titleLabel;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 16;
        
        [_loginButton setTitleColor:KHexColor(@"#FF4D49") forState:UIControlStateNormal];
        _loginButton.backgroundColor = KWhiteColor;
        _loginButton.titleLabel.font = KFont(PingFangSCSemibold, 15);
        [_loginButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
@end
