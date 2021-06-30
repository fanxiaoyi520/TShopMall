//
//  TSSettingUserCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/12.
//

#import "TSSettingUserCell.h"

@interface TSSettingUserCell ()
/** 头像 */
@property(nonatomic, weak) UIImageView *headImgV;
/** 用户名 */
@property(nonatomic, weak) UILabel *userLabel;
/** 性别图标 */
@property(nonatomic, weak) UIImageView *sexImgV;
/** 手机号 */
@property(nonatomic, weak) UILabel *phoneNumberLabel;
/** 右标识 */
@property(nonatomic, weak) UIImageView *rightImgV;
@end

@implementation TSSettingUserCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.width.height.mas_equalTo(60);
    }];
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgV.mas_top).with.offset(5);
        make.left.equalTo(self.headImgV.mas_right).with.offset(10);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.sexImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userLabel.mas_centerY).with.offset(0);
        make.left.equalTo(self.userLabel.mas_right).with.offset(5);
        make.width.height.mas_equalTo(17);
    }];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.userLabel.mas_left).with.offset(0);
    }];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
}

- (UIImageView *)headImgV {
    if (_headImgV == nil) {
        UIImageView *headImgV = [[UIImageView alloc] init];
        _headImgV = headImgV;
        _headImgV.layer.cornerRadius = 30;
        _headImgV.clipsToBounds = YES;
        _headImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self.contentView addSubview:_headImgV];
    }
    return _headImgV;
}

- (UILabel *)userLabel {
    if (_userLabel == nil) {
        UILabel *userLabel = [[UILabel alloc] init];
        _userLabel = userLabel;
        _userLabel.textColor = KTextColor;
        _userLabel.font = KRegularFont(16);
        [self.contentView addSubview:_userLabel];
    }
    return _userLabel;
}

- (UILabel *)phoneNumberLabel {
    if (_phoneNumberLabel == nil) {
        UILabel *phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel = phoneNumberLabel;
        _phoneNumberLabel.text = @"185****8903";
        _phoneNumberLabel.textColor = KTextColor;
        _phoneNumberLabel.font = KRegularFont(16);
        [self.contentView addSubview:_phoneNumberLabel];
    }
    return _phoneNumberLabel;
}

- (UIImageView *)sexImgV {
    if (_sexImgV == nil) {
        UIImageView *sexImgV = [[UIImageView alloc] init];
        _sexImgV = sexImgV;
        _sexImgV.image = KImageMake(@"mall_setting_male");
        [self.contentView addSubview:_sexImgV];
    }
    return _sexImgV;
}

- (UIImageView *)rightImgV {
    if (_rightImgV == nil) {
        UIImageView *rightImgV = [[UIImageView alloc] init];
        _rightImgV = rightImgV;
        _rightImgV.image = KImageMake(@"mall_setting_arrow");
        [self.contentView addSubview:_rightImgV];
    }
    return _rightImgV;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSUser *user = [TSServicesManager sharedInstance].userInfoService.user;
    self.phoneNumberLabel.text = user.phone;
    NSString *avatar = user.avatar;
    if (avatar) {
        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
    }
    self.sexImgV.image = user.sex == male ? KImageMake(@"mall_setting_male") : KImageMake(@"mall_setting_female");
    self.userLabel.text = user.nickname.length == 0 ? user.phone : user.nickname;
}

@end
