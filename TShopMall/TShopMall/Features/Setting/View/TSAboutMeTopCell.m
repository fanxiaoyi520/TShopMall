//
//  TSAboutMeTopCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSAboutMeTopCell.h"
#import "TSAboutMeSectionModel.h"

@interface TSAboutMeTopCell ()
/** logo */
@property(nonatomic, weak) UIImageView *logoImgV;
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 版本号 */
@property(nonatomic, weak) UILabel *versionLabel;

@end

@implementation TSAboutMeTopCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(48);
        make.width.height.mas_equalTo(96);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.logoImgV.mas_bottom).with.offset(16);
    }];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(3);
    }];
}

- (UIImageView *)logoImgV {
    if (_logoImgV == nil) {
        UIImageView *logoImgV = [[UIImageView alloc] init];
        _logoImgV = logoImgV;
        _logoImgV.image = KImageMake(@"mall_login_logo");
        [self.contentView addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"TCL之家";
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = [UIFont font:PingFangSCMedium size:20];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)versionLabel {
    if (_versionLabel == nil) {
        UILabel *versionLabel = [[UILabel alloc] init];
        _versionLabel = versionLabel;
        _versionLabel.text = @"版本: 1.0.0";
        _versionLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _versionLabel.font = KRegularFont(12);
        [self.contentView addSubview:_versionLabel];
    }
    return _versionLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAboutMeSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.versionLabel.text = item.version;
}

@end
