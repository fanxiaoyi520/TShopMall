//
//  TSPersonalRankView.m
//  TShopMall
//
//  Created by oneyian on 2021/6/30.
//

#import "TSPersonalRankView.h"

@interface TSPersonalRankView ()

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
/** 分割线  */
@property(nonatomic, weak) UIView *splitView;
/** 销售收益四字显示  */
@property(nonatomic, weak) UILabel *salesShowLabel;
/** 销售收益数目显示  */
@property(nonatomic, weak) UILabel *salesNumLabel;


@end

@implementation TSPersonalRankView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 84)];
    if (self) {
        
        [self.personalImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(27);
            make.bottom.offset(-10);
            make.width.height.offset(50);
        }];
        
        [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgV).offset(4);
            make.left.equalTo(self.headImgV.mas_right).with.offset(15);
        }];
        
        [self.rankShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.usernameLabel);
            make.bottom.offset(-12);
        }];
        [self.rankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rankShowLabel.mas_right).offset(6);
            make.centerY.equalTo(self.rankShowLabel);
        }];
        
        [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rankNumLabel.mas_right).offset(8);
            make.centerY.equalTo(self.rankShowLabel);
            make.width.offset(1);
            make.height.offset(10);
        }];
        
        [self.salesShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.splitView.mas_right).offset(8);
            make.centerY.equalTo(self.rankShowLabel);
        }];
        [self.salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.salesShowLabel.mas_right).offset(6);
            make.centerY.equalTo(self.rankShowLabel.mas_centerY);
        }];
    
    }
    return self;
}

- (UIImageView *)personalImgV {
    if (_personalImgV == nil) {
        UIImageView *personalImgV = [[UIImageView alloc] init];
        _personalImgV = personalImgV;
        _personalImgV.image = KImageMake(@"mall_rank_personalbg");
        [self addSubview: _personalImgV];
    }
    return _personalImgV;
}

- (UIImageView *)headImgV {
    if (_headImgV == nil) {
        UIImageView *headImgV = [[UIImageView alloc] init];
        _headImgV = headImgV;
        _headImgV.image = KImageMake(@"mall_setting_defautlhead");
        [self addSubview: _headImgV];
    }
    return _headImgV;
}

- (UILabel *)usernameLabel {
    if (_usernameLabel == nil) {
        UILabel *usernameLabel = [[UILabel alloc] init];
        _usernameLabel = usernameLabel;
        _usernameLabel.text = @"JERRYJUICE";
        _usernameLabel.font = KFont(PingFangSCMedium, 16);
        _usernameLabel.textColor = KTextColor;
        [self addSubview: _usernameLabel];
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
        [self addSubview: _rankShowLabel];
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
        [self addSubview: _rankNumLabel];
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
        [self addSubview: _salesShowLabel];
    }
    return _salesShowLabel;
}

- (UILabel *)salesNumLabel {
    if (_salesNumLabel == nil) {
        UILabel *salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel = salesNumLabel;
        _salesNumLabel.text = @"￥89000";
        _salesNumLabel.font = KFont(PingFangSCMedium, 12);
        _salesNumLabel.textColor = KHexColor(@"#2D3132");
        [self addSubview: _salesNumLabel];
    }
    return _salesNumLabel;
}

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexAlphaColor(@"#95A6AA", 0.2);
        [self addSubview: _splitView];
    }
    return _splitView;
}


@end
