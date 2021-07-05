//
//  TSRankHonourCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankHonourCell.h"
#import "TSRankSectionModel.h"

@interface TSRankHonourCell()
/// 背景视图
@property(nonatomic, weak) UIImageView *bgImageView;

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

/** 季军的标图  */
@property(nonatomic, weak) UIImageView *thirdImgV;
/** 季军的头像  */
@property(nonatomic, weak) UIImageView *thirdIconImgV;
/** 季军帽子  */
@property(nonatomic, weak) UIImageView *thirdHatImgV;
/** 季军的名称  */
@property(nonatomic, weak) UILabel *thirdLabel;

@end

@implementation TSRankHonourCell

- (void)setupUI {
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(280));
    }];
    
    //冠军
    [self.championImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRateW(145));
        make.bottom.offset(-KRateW(146));
        make.width.height.offset(KRateW(70));
    }];
    
    self.championIconImgV.layer.masksToBounds = YES;
    self.championIconImgV.layer.cornerRadius = KRateW(64/2);
    [self.championIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.championImgV);
        make.width.height.offset(KRateW(64));
    }];
    
    [self.championHatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.championImgV.mas_top).offset(-KRateW(3));
        make.left.equalTo(self.championImgV.mas_centerX).offset(KRateW(3));
        make.width.offset(KRateW(44));
        make.height.offset(KRateW(42));
    }];
    
    [self.championLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.thirdLabel);
        make.centerX.equalTo(self.championImgV);
        make.top.equalTo(self.championImgV.mas_bottom).offset(KRateW(3));
    }];
    
    //亚军
    [self.secondImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-KRateW(47));
        make.bottom.offset(-KRateW(123));
        make.width.height.offset(KRateW(60));
    }];
    
    self.secondIconImgV.layer.masksToBounds = YES;
    self.secondIconImgV.layer.cornerRadius = KRateW(54/2);
    [self.secondIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.secondImgV);
        make.width.height.offset(KRateW(54));
    }];
    
    [self.secondHatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.secondImgV.mas_top).offset(-KRateW(5));
        make.left.equalTo(self.secondImgV.mas_centerX).offset(KRateW(2));
        make.width.offset(KRateW(38));
        make.height.offset(KRateW(36));
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.thirdLabel);
        make.centerX.equalTo(self.secondImgV);
        make.top.equalTo(self.secondImgV.mas_bottom).offset(KRateW(3));
    }];
    
    
    //季军
    [self.thirdImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRateW(33));
        make.bottom.offset(-KRateW(91));
        make.width.height.offset(KRateW(60));
    }];
    
    self.thirdIconImgV.layer.masksToBounds = YES;
    self.thirdIconImgV.layer.cornerRadius = KRateW(54/2);
    [self.thirdIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.thirdImgV);
        make.width.height.offset(KRateW(54));
    }];
    
    [self.thirdHatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.thirdImgV.mas_top).offset(-KRateW(5));
        make.left.equalTo(self.thirdImgV.mas_centerX).offset(KRateW(2));
        make.width.offset(KRateW(38));
        make.height.offset(KRateW(36));
    }];
    
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(88);
        make.centerX.equalTo(self.thirdImgV);
        make.top.equalTo(self.thirdImgV.mas_bottom).offset(KRateW(3));
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

- (UILabel *)championLabel {
    if (_championLabel == nil) {
        UILabel *championLabel = [[UILabel alloc] init];
        _championLabel = championLabel;
        _championLabel.font = KRegularFont(14);
        _championLabel.textColor = KWhiteColor;
        _championLabel.textAlignment = NSTextAlignmentCenter;
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
        _championIconImgV.backgroundColor = KWhiteColor;
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
        _secondLabel.textAlignment = NSTextAlignmentCenter;
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
        _secondIconImgV.backgroundColor = KWhiteColor;
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
        _thirdLabel.textAlignment = NSTextAlignmentCenter;
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
        _thirdIconImgV.backgroundColor = KWhiteColor;
        _thirdIconImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self.contentView addSubview: _thirdIconImgV];
    }
    return _thirdIconImgV;
}

- (void)setData:(id)data {
    [super setData:data];
    
    self.championIconImgV.image = KImageMake(@"mall_setting_defautlhead");
    self.championLabel.text = @"等待上榜";
    self.secondIconImgV.image = KImageMake(@"mall_setting_defautlhead");
    self.secondLabel.text = @"等待上榜";
    self.thirdIconImgV.image = KImageMake(@"mall_setting_defautlhead");
    self.thirdLabel.text = @"等待上榜";
    
    TSRankSectionItemModel *item = (TSRankSectionItemModel *)data;
    
    //冠军
    if (item.rankList.count > 0) {
        TSRankUserModel *userModel = item.rankList[0];
        [self.championIconImgV sd_setImageWithURL:[NSURL URLWithString:userModel.imageUrl] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
        self.championLabel.text = userModel.mobile;
        
        //亚军
        if (item.rankList.count > 1) {
            TSRankUserModel *userModel = item.rankList[1];
            [self.secondIconImgV sd_setImageWithURL:[NSURL URLWithString:userModel.imageUrl] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
            self.secondLabel.text = userModel.mobile;
            
            //季军
            if (item.rankList.count > 2) {
                TSRankUserModel *userModel = item.rankList[2];
                [self.thirdIconImgV sd_setImageWithURL:[NSURL URLWithString:userModel.imageUrl] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
                self.thirdLabel.text = userModel.mobile;
            }
        }
    }
}


@end
