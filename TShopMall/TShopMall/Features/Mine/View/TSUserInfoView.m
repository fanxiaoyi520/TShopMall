//
//  TSUserInfoView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSUserInfoView.h"

@interface TSUserInfoView()

/// 角色
//@property(nonatomic, assign) TSRoleType type;
/// 头像
@property(nonatomic, strong) UIImageView *iconImageView;
/// 登录按钮
@property(nonatomic, strong) UIButton *loginButton;
/// 合伙人头像
@property(nonatomic, strong) UIImageView *partnerImageView;
/// 员工头像
@property(nonatomic, strong) UIImageView *staffImageView;
/// 邀请码
@property(nonatomic, strong) UIImageView *invitationCodeBack;
/// 邀请码背景
@property(nonatomic, strong) UILabel *invitationCodeLab;
/// 查看邀请码
@property(nonatomic, strong) UIButton *seeCodeBtn;
/// 复制邀请码
@property(nonatomic, strong) UIButton *kCopyCodeBtn;
@end

@implementation TSUserInfoView

//-(instancetype)initWithRoleType:(TSRoleType)type{
//    if (self = [super init]) {
//        self.type = type;
//        [self fillCustomView];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self fillCustomView];
    }
    return self;
}
-(void)fillCustomView{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.invitationCodeBack];
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
    [self addSubview:self.seeCodeBtn];
    [self.seeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.loginButton.mas_centerY);
    }];
    
    
    [self addSubview:self.invitationCodeLab];
    [self.invitationCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.seeCodeBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.loginButton.mas_centerY);
//        make.top.equalTo(self.iconImageView).offset(7);
        make.height.mas_equalTo(17);
    }];
    
   
    [self.invitationCodeBack mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.seeCodeBtn.mas_right);
     make.top.equalTo(self.invitationCodeLab.mas_top).offset(-2);
        make.left.equalTo(self.invitationCodeLab.mas_left).offset(-2);
        make.bottom.equalTo(self.invitationCodeLab.mas_bottom).offset(2);
    }];
    
    [self addSubview:self.kCopyCodeBtn];
    [self.kCopyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-24);
        make.top.equalTo(self.iconImageView).offset(30);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(45);
    }];
}

#pragma mark - data
- (void)setModel:(TSMineMerchantUserInformationModel *)model {
    if (!model) return;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.customerImgUrl] placeholderImage:nil];
    if ([TSGlobalManager shareInstance].currentUserInfo) {
    if (model.customerName) {
        [self.loginButton setTitle:model.customerName forState:UIControlStateNormal];
    } else {
        [self.loginButton setTitle:@"" forState:UIControlStateNormal];
    }
    } else {
    [self.loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    }
    
    if ([model.staff isEqualToString:@"staff"]) {
        self.staffImageView.image = KImageMake(@"mall_mine_staff");
    } else {
        self.staffImageView.hidden = YES;
    }
    
    if ([model.privilege isEqualToString:@"privilege"]) {
        self.partnerImageView.hidden = YES;
    } else {
        self.partnerImageView.image = KImageMake(@"mall_mine_partner");
    }
    
    if (model.invitationCode == nil) {
        self.seeCodeBtn.hidden = YES;
        self.kCopyCodeBtn.hidden = YES;
        self.invitationCodeLab.hidden = YES;
        self.invitationCodeBack.hidden = YES;
    } else {
        self.invitationCodeBack.hidden = NO;
        self.seeCodeBtn.hidden = NO;
        self.kCopyCodeBtn.hidden = NO;
        self.invitationCodeLab.hidden = NO;
        self.invitationCodeLab.text = [NSString stringWithFormat:@"邀请码 %@",model.invitationCode];
    }
}

#pragma mark - Action
-(void)loginAction:(UIButton *)sender{
    if (![TSGlobalManager shareInstance].currentUserInfo) {
        if ([self.kDelegate respondsToSelector:@selector(userInfoLoginAction:)]) {
            [self.kDelegate userInfoLoginAction:sender];
        }
    }
}

-(void)seeCodeAction:(UIButton *)sender {
    if (sender.selected) {
        self.invitationCodeLab.hidden = YES;
        sender.selected = NO;
    } else {
        self.invitationCodeLab.hidden = NO;
        sender.selected = YES;
    }
    if ([self.kDelegate respondsToSelector:@selector(userInfoSeeCodeAction:)]) {
        [self.kDelegate userInfoSeeCodeAction:sender];
    }
}

- (void)kCopyCodeAction:(UIButton *)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = self.invitationCodeLab.text;
    [pab setString:string];
    if ([self.kDelegate respondsToSelector:@selector(userInfoKCopyCodeAction:)]) {
        [self.kDelegate userInfoKCopyCodeAction:pab];
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
//        [_loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
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

-(UIImageView *)invitationCodeBack{
    if (!_invitationCodeBack) {
        _invitationCodeBack = [[UIImageView alloc] init];
        _invitationCodeBack.image = KImageMake(@"mall_mine_juxing");
        _invitationCodeBack.hidden = true;
    }
    return _invitationCodeBack;
}


-(UILabel *)invitationCodeLab {
    if (!_invitationCodeLab) {
        _invitationCodeLab = [[UILabel alloc] init];
        _invitationCodeLab.text = @"邀请码 RWRTNA";
        _invitationCodeLab.textAlignment = NSTextAlignmentLeft;
        _invitationCodeLab.textColor = KWhiteColor;
        _invitationCodeLab.font = KRegularFont(12);
        self.invitationCodeLab.hidden = YES;
    }
    return _invitationCodeLab;
}

-(UIButton *)seeCodeBtn {
    if (!_seeCodeBtn) {
        _seeCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeCodeBtn setImage:KImageMake(@"mall_mine_eye_white") forState:UIControlStateSelected];
        [_seeCodeBtn setImage:KImageMake(@"mall_mine_eye_white_invisible") forState:UIControlStateNormal];
        [_seeCodeBtn addTarget:self action:@selector(seeCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_seeCodeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        _seeCodeBtn.tintColor = [UIColor whiteColor];
        self.seeCodeBtn.hidden = YES;
        _seeCodeBtn.selected = YES;
    }
    return _seeCodeBtn;
}

-(UIButton *)kCopyCodeBtn {
    if (!_kCopyCodeBtn) {
        _kCopyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kCopyCodeBtn setTitle:@"复制" forState:UIControlStateNormal];
        _kCopyCodeBtn.titleLabel.font = KRegularFont(12);
        [_kCopyCodeBtn addTarget:self action:@selector(kCopyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        _kCopyCodeBtn.layer.cornerRadius = 9.0;
        _kCopyCodeBtn.layer.borderColor = KWhiteColor.CGColor;
        _kCopyCodeBtn.layer.borderWidth = 0.5f;
        [_kCopyCodeBtn jaf_setEnlargeEdgeWithTop:2 right:10 bottom:2 left:10];
        self.kCopyCodeBtn.hidden = YES;
    }
    return _kCopyCodeBtn;
}

@end
