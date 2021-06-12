//
//  TSUserInfoView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSUserInfoView.h"

@interface TSUserInfoView()

/// 角色
@property(nonatomic, assign) TSRoleType type;
/// 头像
@property(nonatomic, strong) UIImageView *iconImageView;
/// 登录按钮
@property(nonatomic, strong) UIButton *loginButton;
/// 合伙人头像
@property(nonatomic, strong) UIImageView *partnerImageView;
/// 员工头像
@property(nonatomic, strong) UIImageView *staffImageView;

@end

@implementation TSUserInfoView

-(instancetype)initWithRoleType:(TSRoleType)type{
    if (self = [super init]) {
        self.type = type;
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(60);
    }];
    
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.iconImageView);
        make.height.mas_equalTo(30);
    }];
    
    if (self.type == TSRoleTypeUnLogin) {
        self.loginButton.userInteractionEnabled = YES;
    }else if (self.type == TSRoleTypePlatinum){
        self.loginButton.userInteractionEnabled = NO;
        
        [self addSubview:self.partnerImageView];
        [self addSubview:self.staffImageView];
        
        [self.partnerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.bottom.equalTo(self.iconImageView);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(22);
        }];
        
        [self.staffImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.partnerImageView.mas_right).offset(5);
            make.bottom.equalTo(self.iconImageView);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(22);
        }];
    }
}

#pragma mark - Action
-(void)loginAction:(UIButton *)sender{
    if (self.type == TSRoleTypeUnLogin) {
        
    }
}

#pragma mark - Getter
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = KGrayColor;
        _iconImageView.layer.cornerRadius = 30;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = KRegularFont(16);
        [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIImageView *)partnerImageView{
    if (!_partnerImageView) {
        _partnerImageView = [[UIImageView alloc] init];
        _partnerImageView.image = KImageMake(@"mall_mine_partner");
    }
    return _partnerImageView;
}

-(UIImageView *)staffImageView{
    if (!_staffImageView) {
        _staffImageView = [[UIImageView alloc] init];
        _staffImageView.image = KImageMake(@"mall_mine_staff");
    }
    return _staffImageView;
}

@end
