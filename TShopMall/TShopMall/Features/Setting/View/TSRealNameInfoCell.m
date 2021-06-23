//
//  TSRealNameInfoCell.m
//  TShopMall
//
//  Created by edy on 2021/6/22.
//

#import "TSRealNameInfoCell.h"
#import "TSRealnameInfoSectionModel.h"

@interface TSRealNameInfoCell ()
/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 您已实名认证  */
@property(nonatomic, weak) UILabel *authedLabel;
/** tips  */
@property(nonatomic, weak) UILabel *tipsLabel;
/** 信息的父视图  */
@property(nonatomic, weak) UIView *infoView;
/** 真实姓名四字的展示  */
@property(nonatomic, weak) UILabel *realShowLabel;
/** 真实姓名  */
@property(nonatomic, weak) UILabel *realnameLabel;
/** 身份证号四字的展示  */
@property(nonatomic, weak) UILabel *idcardShowLabel;
/** 身份证号 */
@property(nonatomic, weak) UILabel *idcardLabel;
@end

@implementation TSRealNameInfoCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(222);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.bgImgV.mas_bottom).with.offset(-8);
    }];
    [self.authedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.tipsLabel.mas_top).with.offset(-3);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.bgImgV.mas_bottom).with.offset(11);
        make.width.mas_equalTo(263);
        make.height.mas_equalTo(71);
    }];
    [self.realShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.infoView.mas_left).with.offset(14);
        make.top.equalTo(self.infoView.mas_top).with.offset(12);
    }];
    [self.realnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.realShowLabel.mas_right).with.offset(10);
        make.centerY.equalTo(self.realShowLabel.mas_centerY).with.offset(0);
    }];
    [self.idcardShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.infoView.mas_left).with.offset(14);
        make.top.equalTo(self.realShowLabel.mas_bottom).with.offset(8);
    }];
    [self.idcardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.realnameLabel.mas_left).with.offset(0);
        make.centerY.equalTo(self.idcardShowLabel.mas_centerY).with.offset(0);
    }];
}

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        _bgImgV.image = KImageMake(@"mall_setting_realnamebg");
        _bgImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_bgImgV atIndex:0];
    }
    return _bgImgV;
}

- (UILabel *)authedLabel {
    if (_authedLabel == nil) {
        UILabel *authedLabel = [[UILabel alloc] init];
        _authedLabel = authedLabel;
        _authedLabel.text = @"您已实名认证";
        _authedLabel.font = KRegularFont(18);
        _authedLabel.textColor = KTextColor;
        [self.contentView addSubview: _authedLabel];
    }
    return _authedLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"更安全 更可靠";
        _tipsLabel.font = KRegularFont(12);
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        [self.contentView addSubview: _tipsLabel];
    }
    return _tipsLabel;
}

- (UIView *)infoView {
    if (_infoView == nil) {
        UIView *infoView = [[UIView alloc] init];
        _infoView = infoView;
        _infoView.layer.borderColor = KHexColor(@"#979797").CGColor;
        _infoView.layer.borderWidth = 0.5;
        _infoView.clipsToBounds = YES;
        [_infoView setCorners:UIRectCornerAllCorners radius:16];
        [self.contentView addSubview: _infoView];
    }
    return _infoView;
}

- (UILabel *)realShowLabel {
    if (_realShowLabel == nil) {
        UILabel *realShowLabel = [[UILabel alloc] init];
        _realShowLabel = realShowLabel;
        _realShowLabel.text = @"真实姓名:";
        _realShowLabel.font = KRegularFont(14);
        _realShowLabel.textColor = KTextColor;
        [self.contentView addSubview: _realShowLabel];
    }
    return _realShowLabel;
}

- (UILabel *)idcardShowLabel {
    if (_idcardShowLabel == nil) {
        UILabel *idcardShowLabel = [[UILabel alloc] init];
        _idcardShowLabel = idcardShowLabel;
        _idcardShowLabel.text = @"身份证号:";
        _idcardShowLabel.font = KRegularFont(14);
        _idcardShowLabel.textColor = KTextColor;
        [self.contentView addSubview: _idcardShowLabel];
    }
    return _idcardShowLabel;
}

- (UILabel *)realnameLabel {
    if (_realnameLabel == nil) {
        UILabel *realnameLabel = [[UILabel alloc] init];
        _realnameLabel = realnameLabel;
        //_realnameLabel.text = @"张*某";
        _realnameLabel.font = KRegularFont(14);
        _realnameLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        [self.contentView addSubview: _realnameLabel];
    }
    return _realnameLabel;
}

- (UILabel *)idcardLabel {
    if (_idcardLabel == nil) {
        UILabel *idcardLabel = [[UILabel alloc] init];
        _idcardLabel = idcardLabel;
        //_idcardLabel.text = @"6224******777";
        _idcardLabel.font = KRegularFont(14);
        _idcardLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        [self.contentView addSubview: _idcardLabel];
    }
    return _idcardLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSRealnameInfoSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.realnameLabel.text = item.realname;
    self.idcardLabel.text = item.idcard;
}

@end
