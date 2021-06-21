//
//  TSRankHonourCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankHonourCell.h"

@interface TSRankHonourCell()
/// 背景视图
@property(nonatomic, weak) UIImageView *bgImageView;
/** 底部  */
@property(nonatomic, weak) UIImageView *rankBottomImgV;
/** 冠军的名称  */
@property(nonatomic, weak) UILabel *championLabel;
/** 冠军的标图  */
@property(nonatomic, weak) UIImageView *championImgV;
/** 冠军的头像  */
@property(nonatomic, weak) UIImageView *championIconImgV;
/** 冠军帽子  */
@property(nonatomic, weak) UIImageView *championHatImgV;
/** 亚军的名称  */
@property(nonatomic, weak) UILabel *secondLabel;
/** 亚军的标图  */
@property(nonatomic, weak) UIImageView *secondImgV;
/** 亚军的头像  */
@property(nonatomic, weak) UIImageView *secondIconImgV;
/** 亚军帽子  */
@property(nonatomic, weak) UIImageView *secondHatImgV;
/** 季军的名称  */
@property(nonatomic, weak) UILabel *thirdLabel;
/** 季军的标图  */
@property(nonatomic, weak) UIImageView *thirdImgV;
/** 季军的头像  */
@property(nonatomic, weak) UIImageView *thirdIconImgV;
/** 季军帽子  */
@property(nonatomic, weak) UIImageView *thirdHatImgV;
/** 个人信息的父视图  */
@property(nonatomic, weak) UIView *personalView;
/// 信息背景
@property(nonatomic, weak) UIImageView *personalImgV;
/** 个人头像  */
@property(nonatomic, weak) UIImageView *headImgV;
/** 个人名称  */
@property(nonatomic, weak) UILabel *usernameLabel;
/** 排名两字显示  */
@property(nonatomic, weak) UILabel *rankShowLabel;
/** 排名显示  */
@property(nonatomic, weak) UILabel *rankNumLabel;
/** 销售收益四字显示  */
@property(nonatomic, weak) UILabel *salesShowLabel;
/** 销售收益数目显示  */
@property(nonatomic, weak) UILabel *salesNumLabel;
/** 分割线  */
@property(nonatomic, weak) UIView *splitView;

@end

@implementation TSRankHonourCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(260);
    }];
    [self.rankBottomImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.bgImageView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(64);
    }];
    [self.championLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(-15);
    }];
    [self.championImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.championLabel.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.championLabel.mas_top).with.offset(-5);
        make.width.height.mas_equalTo(83);
    }];
    [self.championIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.championImgV.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.championImgV.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(83);
    }];
    [self.championHatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.championImgV.mas_top).with.offset(0);
        make.left.equalTo(self.championImgV.mas_centerX).with.offset(-10);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(62);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-KRateW(70));
        make.bottom.equalTo(self.thirdLabel.mas_top).with.offset(-5);
    }];
    [self.secondImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.secondLabel.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.secondLabel.mas_top).with.offset(-5);
        make.width.height.mas_equalTo(70);
    }];
    [self.secondIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.secondImgV.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.secondImgV.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(70);
    }];
    [self.secondHatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.secondImgV.mas_top).with.offset(0);
        make.left.equalTo(self.secondImgV.mas_centerX).with.offset(-5);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(43);
    }];
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(KRateW(55));
        make.bottom.equalTo(self.rankBottomImgV.mas_top).with.offset(5);
    }];
    [self.thirdImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.thirdLabel.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.thirdLabel.mas_top).with.offset(-5);
        make.width.height.mas_equalTo(70);
    }];
    [self.thirdIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.thirdImgV.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.thirdImgV.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(70);
    }];
    [self.thirdHatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.thirdImgV.mas_top).with.offset(0);
        make.left.equalTo(self.thirdImgV.mas_centerX).with.offset(-5);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(43);
    }];
    [self.personalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.top.equalTo(self.rankBottomImgV.mas_bottom).with.offset(0);
    }];
    [self.personalImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personalView.mas_left).with.offset(0);
        make.right.equalTo(self.personalView.mas_right).with.offset(0);
        make.bottom.equalTo(self.personalView.mas_bottom).with.offset(0);
        make.top.equalTo(self.personalView.mas_top).with.offset(0);
    }];
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personalView.mas_left).with.offset(21);
        make.centerY.equalTo(self.personalView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgV.mas_right).with.offset(10);
        make.top.equalTo(self.headImgV.mas_top).with.offset(5);
    }];
    [self.rankShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameLabel.mas_left).with.offset(0);
        make.bottom.equalTo(self.headImgV.mas_bottom).with.offset(-5);
    }];
    [self.rankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankShowLabel.mas_right).with.offset(3);
        make.centerY.equalTo(self.rankShowLabel.mas_centerY).with.offset(0);
    }];
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankNumLabel.mas_right).with.offset(8);
        make.centerY.equalTo(self.rankShowLabel.mas_centerY).with.offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(14);
    }];
    [self.salesShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.splitView.mas_right).with.offset(8);
        make.centerY.equalTo(self.rankShowLabel.mas_centerY).with.offset(0);
    }];
    [self.salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.salesShowLabel.mas_right).with.offset(3);
        make.centerY.equalTo(self.rankShowLabel.mas_centerY).with.offset(0);
    }];
    
}

#pragma mark - Getter
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        UIImageView *bgImageView = [[UIImageView alloc] init];
        _bgImageView = bgImageView;
        _bgImageView.image = KImageMake(@"mall_rank_honor");
        [self.contentView insertSubview:_bgImageView atIndex:0];
    }
    return _bgImageView;
}

- (UIImageView *)rankBottomImgV {
    if (_rankBottomImgV == nil) {
        UIImageView *rankBottomImgV = [[UIImageView alloc] init];
        _rankBottomImgV = rankBottomImgV;
        _rankBottomImgV.image = KImageMake(@"mall_rank_bottom");
        [self.contentView addSubview: _rankBottomImgV];
    }
    return _rankBottomImgV;
}

- (UILabel *)championLabel {
    if (_championLabel == nil) {
        UILabel *championLabel = [[UILabel alloc] init];
        _championLabel = championLabel;
        _championLabel.font = KRegularFont(14);
        _championLabel.textColor = KWhiteColor;
        _championLabel.text = @"JERRY";
        [self.contentView addSubview: _championLabel];
    }
    return _championLabel;
}

- (UIImageView *)championImgV {
    if (_championImgV == nil) {
        UIImageView *championImgV = [[UIImageView alloc] init];
        _championImgV = championImgV;
        _championImgV.image = KImageMake(@"mall_rank_champion");
        [self.contentView addSubview: _championImgV];
    }
    return _championImgV;
}

- (UIImageView *)championHatImgV {
    if (_championHatImgV == nil) {
        UIImageView *championHatImgV = [[UIImageView alloc] init];
        _championHatImgV = championHatImgV;
        _championHatImgV.image = KImageMake(@"mall_rank_championhat");
        [self.contentView addSubview: _championHatImgV];
    }
    return _championHatImgV;
}

- (UIImageView *)championIconImgV {
    if (_championIconImgV == nil) {
        UIImageView *championIconImgV = [[UIImageView alloc] init];
        _championIconImgV = championIconImgV;
        _championIconImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self.contentView addSubview: _championIconImgV];
    }
    return _championIconImgV;
}

- (UILabel *)secondLabel {
    if (_secondLabel == nil) {
        UILabel *secondLabel = [[UILabel alloc] init];
        _secondLabel = secondLabel;
        _secondLabel.font = KRegularFont(14);
        _secondLabel.textColor = KWhiteColor;
        _secondLabel.text = @"亚军";
        [self.contentView addSubview: _secondLabel];
    }
    return _secondLabel;
}

- (UIImageView *)secondImgV {
    if (_secondImgV == nil) {
        UIImageView *secondImgV = [[UIImageView alloc] init];
        _secondImgV = secondImgV;
        _secondImgV.image = KImageMake(@"mall_rank_second");
        [self.contentView addSubview: _secondImgV];
    }
    return _secondImgV;
}

- (UIImageView *)secondHatImgV {
    if (_secondHatImgV == nil) {
        UIImageView *secondHatImgV = [[UIImageView alloc] init];
        _secondHatImgV = secondHatImgV;
        _secondHatImgV.image = KImageMake(@"mall_rank_secondhat");
        [self.contentView addSubview: _secondHatImgV];
    }
    return _secondHatImgV;
}

- (UIImageView *)secondIconImgV {
    if (_secondIconImgV == nil) {
        UIImageView *secondIconImgV = [[UIImageView alloc] init];
        _secondIconImgV = secondIconImgV;
        _secondIconImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self.contentView addSubview: _secondIconImgV];
    }
    return _secondIconImgV;
}

- (UILabel *)thirdLabel {
    if (_thirdLabel == nil) {
        UILabel *thirdLabel = [[UILabel alloc] init];
        _thirdLabel = thirdLabel;
        _thirdLabel.font = KRegularFont(14);
        _thirdLabel.textColor = KWhiteColor;
        _thirdLabel.text = @"季军";
        [self.contentView addSubview: _thirdLabel];
    }
    return _thirdLabel;
}

- (UIImageView *)thirdImgV {
    if (_thirdImgV == nil) {
        UIImageView *thirdImgV = [[UIImageView alloc] init];
        _thirdImgV = thirdImgV;
        _thirdImgV.image = KImageMake(@"mall_rank_third");
        [self.contentView addSubview: _thirdImgV];
    }
    return _thirdImgV;
}

- (UIImageView *)thirdHatImgV {
    if (_thirdHatImgV == nil) {
        UIImageView *thirdHatImgV = [[UIImageView alloc] init];
        _thirdHatImgV = thirdHatImgV;
        _thirdHatImgV.image = KImageMake(@"mall_rank_thirdhat");
        [self.contentView addSubview: _thirdHatImgV];
    }
    return _thirdHatImgV;
}

- (UIImageView *)thirdIconImgV {
    if (_thirdIconImgV == nil) {
        UIImageView *thirdIconImgV = [[UIImageView alloc] init];
        _thirdIconImgV = thirdIconImgV;
        _thirdIconImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self.contentView addSubview: _thirdIconImgV];
    }
    return _thirdIconImgV;
}

- (UIView *)personalView {
    if (_personalView == nil) {
        UIView *personalView = [[UIView alloc] init];
        _personalView = personalView;
        [self.contentView addSubview: _personalView];
    }
    return _personalView;
}

- (UIImageView *)personalImgV {
    if (_personalImgV == nil) {
        UIImageView *personalImgV = [[UIImageView alloc] init];
        _personalImgV = personalImgV;
        _personalImgV.image = KImageMake(@"mall_rank_personalbg");
        [self.contentView addSubview: _personalImgV];
    }
    return _personalImgV;
}

- (UIImageView *)headImgV {
    if (_headImgV == nil) {
        UIImageView *headImgV = [[UIImageView alloc] init];
        _headImgV = headImgV;
        _headImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self.contentView addSubview: _headImgV];
    }
    return _headImgV;
}

- (UILabel *)usernameLabel {
    if (_usernameLabel == nil) {
        UILabel *usernameLabel = [[UILabel alloc] init];
        _usernameLabel = usernameLabel;
        _usernameLabel.text = @"JERRYJUICE";
        _usernameLabel.font = KRegularFont(16);
        _usernameLabel.textColor = KTextColor;
        [self.contentView addSubview: _usernameLabel];
    }
    return _usernameLabel;
}

- (UILabel *)rankShowLabel {
    if (_rankShowLabel == nil) {
        UILabel *rankShowLabel = [[UILabel alloc] init];
        _rankShowLabel = rankShowLabel;
        _rankShowLabel.text = @"排名";
        _rankShowLabel.font = KRegularFont(12);
        _rankShowLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        [self.contentView addSubview: _rankShowLabel];
    }
    return _rankShowLabel;
}

- (UILabel *)rankNumLabel {
    if (_rankNumLabel == nil) {
        UILabel *rankNumLabel = [[UILabel alloc] init];
        _rankNumLabel = rankNumLabel;
        _rankNumLabel.text = @"6";
        _rankNumLabel.font = KRegularFont(12);
        _rankNumLabel.textColor = KHexColor(@"#2D3132");
        [self.contentView addSubview: _rankNumLabel];
    }
    return _rankNumLabel;
}

- (UILabel *)salesShowLabel {
    if (_salesShowLabel == nil) {
        UILabel *salesShowLabel = [[UILabel alloc] init];
        _salesShowLabel = salesShowLabel;
        _salesShowLabel.text = @"销售收益";
        _salesShowLabel.font = KRegularFont(12);
        _salesShowLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        [self.contentView addSubview: _salesShowLabel];
    }
    return _salesShowLabel;
}

- (UILabel *)salesNumLabel {
    if (_salesNumLabel == nil) {
        UILabel *salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel = salesNumLabel;
        _salesNumLabel.text = @"￥89000";
        _salesNumLabel.font = KRegularFont(12);
        _salesNumLabel.textColor = KHexColor(@"#2D3132");
        [self.contentView addSubview: _salesNumLabel];
    }
    return _salesNumLabel;
}

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexAlphaColor(@"#2D3132", 0.4);
        [self.contentView addSubview: _splitView];
    }
    return _splitView;
}

@end
