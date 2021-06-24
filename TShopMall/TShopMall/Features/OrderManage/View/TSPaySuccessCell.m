//
//  TSPaySuccessCell.m
//  TShopMall
//
//  Created by edy on 2021/6/24.
//

#import "TSPaySuccessCell.h"

@interface TSPaySuccessCell ()
/** top视图 */
@property(nonatomic, weak) UIView *topView;
/** 背景模糊图片 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 支付视图  */
@property(nonatomic, weak) UIView *payView;
/** 支付成功图标  */
@property(nonatomic, weak) UIImageView *successImgV;
/** 支付成功  */
@property(nonatomic, weak) UILabel *successLabel;
/** 跳转视图  */
@property(nonatomic, weak) UIView *transferView;
/** 返回首页按钮  */
@property(nonatomic, weak) UIButton *backHomeButton;
/** 查看订单按钮  */
@property(nonatomic, weak) UIButton *gotoOrderButton;
/** 热销推荐  */
@property(nonatomic, weak) UILabel *hotLabel;

@end


@implementation TSPaySuccessCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    [self addConstraints];
}


- (void)addConstraints {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(133 + GK_STATUSBAR_NAVBAR_HEIGHT);
    }];
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).with.offset(0);
        make.top.equalTo(self.topView.mas_top).with.offset(0);
        make.right.equalTo(self.topView.mas_right).with.offset(0);
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(0);
    }];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_centerY).with.offset(10);
        make.centerX.equalTo(self.topView.mas_centerX).with.offset(12);
    }];
    [self.successImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.successLabel.mas_centerY).with.offset(0);
        make.right.equalTo(self.successLabel.mas_left).with.offset(-8);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    [self.transferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(-21);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(72);
    }];
    [self.backHomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.transferView.mas_centerX).with.offset(-12);
        make.centerY.equalTo(self.transferView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(32);
    }];
    [self.gotoOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.transferView.mas_centerX).with.offset(12);
        make.centerY.equalTo(self.transferView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(32);
    }];
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transferView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
    }];
}

- (UIView *)topView {
    if (_topView == nil) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_pay_bg");
        [self.topView insertSubview:_bgImgV atIndex:0];
    }
    return _bgImgV;
}

- (UIImageView *)successImgV {
    if (_successImgV == nil) {
        UIImageView *successImgV = [[UIImageView alloc] init];
        _successImgV = successImgV;
        _successImgV.image = KImageMake(@"mall_pay_success");
        [self.topView addSubview: _successImgV];
    }
    return _successImgV;
}

- (UILabel *)successLabel {
    if (_successLabel == nil) {
        UILabel *successLabel = [[UILabel alloc] init];
        _successLabel = successLabel;
        _successLabel.text = @"支付成功";
        _successLabel.textColor = KWhiteColor;
        _successLabel.font = KFont(PingFangSCMedium, 20);
        [self.topView addSubview: _successLabel];
    }
    return _successLabel;
}

- (UILabel *)hotLabel {
    if (_hotLabel == nil) {
        UILabel *hotLabel = [[UILabel alloc] init];
        _hotLabel = hotLabel;
        _hotLabel.font = KRegularFont(16);
        _hotLabel.textColor = KTextColor;
        _hotLabel.text = @"热销推荐";
        [self.contentView addSubview: _hotLabel];
    }
    return _hotLabel;
}

- (UIView *)transferView {
    if (_transferView == nil) {
        UIView *transferView = [[UIView alloc] init];
        _transferView = transferView;
        _transferView.backgroundColor = KWhiteColor;
        [_transferView setCorners:UIRectCornerAllCorners radius:12];
        [self.contentView insertSubview:_transferView aboveSubview:self.topView];
    }
    return _transferView;
}

- (UIButton *)backHomeButton {
    if (_backHomeButton == nil) {
        UIButton *backHomeButton = [[UIButton alloc] init];
        _backHomeButton = backHomeButton;
        _backHomeButton.titleLabel.font = KRegularFont(14);
        _backHomeButton.clipsToBounds = YES;
        [_backHomeButton setTitle:@"返回商城首页" forState:UIControlStateNormal];
        [_backHomeButton setTitleColor:KHexColor(@"#E64C3D") forState:(UIControlStateNormal)];
        _backHomeButton.layer.borderColor = KHexColor(@"#E64C3D").CGColor;
        _backHomeButton.layer.borderWidth = 1;
        [_backHomeButton setCorners:UIRectCornerAllCorners radius:16];
        [self.transferView addSubview: _backHomeButton];
    }
    return _backHomeButton;
}

- (UIButton *)gotoOrderButton {
    if (_gotoOrderButton == nil) {
        UIButton *gotoOrderButton = [[UIButton alloc] init];
        _gotoOrderButton = gotoOrderButton;
        _gotoOrderButton.titleLabel.font = KRegularFont(14);
        _gotoOrderButton.clipsToBounds = YES;
        [_gotoOrderButton setTitle:@"查看订单" forState:UIControlStateNormal];
        [_gotoOrderButton setTitleColor:KHexColor(@"#E64C3D") forState:(UIControlStateNormal)];
        _gotoOrderButton.layer.borderColor = KHexColor(@"#E64C3D").CGColor;
        _gotoOrderButton.layer.borderWidth = 1;
        [_gotoOrderButton setCorners:UIRectCornerAllCorners radius:16];
        [self.transferView addSubview: _gotoOrderButton];
    }
    return _gotoOrderButton;
}

@end
