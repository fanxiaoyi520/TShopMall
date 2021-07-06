//
//  TSRankCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankCell.h"
#import "TSRankSectionModel.h"
#import "TSTools.h"

@interface TSRankCell ()
/// 信息背景
@property(nonatomic, weak) UIImageView *rankImgV;
/** 排名数目显示  */
@property(nonatomic, weak) UILabel *rankNumLabel;
/** 个人头像  */
@property(nonatomic, weak) UIImageView *headImgV;
/** 个人名称  */
@property(nonatomic, weak) UILabel *usernameLabel;
/** 销售收益数目显示  */
@property(nonatomic, weak) UILabel *salesNumLabel;
/** 分割线  */
@property(nonatomic, weak) UIView *splitView;

@end

@implementation TSRankCell

- (void)setupUI {
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.rankImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(32);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(32);
    }];
    [self.rankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rankImgV.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).with.offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
    
    self.headImgV.layer.masksToBounds = YES;
    self.headImgV.layer.cornerRadius = 33/2;
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.usernameLabel.mas_left).with.offset(-5);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(33);
    }];
    [self.salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-21);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIImageView *)rankImgV {
    if (_rankImgV == nil) {
        UIImageView *rankImgV = [[UIImageView alloc] init];
        _rankImgV = rankImgV;
        _rankImgV.image = KImageMake(@"mall_rank_no1");
        [self.contentView addSubview: _rankImgV];
    }
    return _rankImgV;
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
        _usernameLabel.text = @"-";
        _usernameLabel.font = KRegularFont(12);
        _usernameLabel.textColor = KTextColor;
        [self.contentView addSubview: _usernameLabel];
    }
    return _usernameLabel;
}

- (UILabel *)rankNumLabel {
    if (_rankNumLabel == nil) {
        UILabel *rankNumLabel = [[UILabel alloc] init];
        _rankNumLabel = rankNumLabel;
        _rankNumLabel.text = @"";
        _rankNumLabel.font = KRegularFont(12);
        _rankNumLabel.textColor = KTextColor;
        [self.contentView addSubview: _rankNumLabel];
    }
    return _rankNumLabel;
}

- (UILabel *)salesNumLabel {
    if (_salesNumLabel == nil) {
        UILabel *salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel = salesNumLabel;
        _salesNumLabel.text = @"-";
        _salesNumLabel.font = KRegularFont(12);
        _salesNumLabel.textColor = KTextColor;
        [self.contentView addSubview: _salesNumLabel];
    }
    return _salesNumLabel;
}

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexColor(@"#EEEEEE");
        [self.contentView addSubview: _splitView];
    }
    return _splitView;
}

- (void)setData:(id)data {
    [super setData:data];
    
    TSRankSectionItemModel *item = (TSRankSectionItemModel *)data;
    NSInteger rank = item.userModel.rank.integerValue;
    if (rank == 1) {
        self.rankImgV.hidden = NO;
        self.rankNumLabel.hidden = YES;
        self.rankImgV.image = KImageMake(@"mall_rank_no1");
    } else if (rank == 2) {
        self.rankImgV.hidden = NO;
        self.rankNumLabel.hidden = YES;
        self.rankImgV.image = KImageMake(@"mall_rank_no2");
    } else if (rank == 3) {
        self.rankImgV.hidden = NO;
        self.rankNumLabel.hidden = YES;
        self.rankImgV.image = KImageMake(@"mall_rank_no3");
    } else {
        self.rankImgV.hidden = YES;
        self.rankNumLabel.hidden = NO;
        self.rankNumLabel.text = item.userModel.rank;
    }
    
    [_headImgV sd_setImageWithURL:[NSURL URLWithString:item.userModel.imageUrl] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
    _usernameLabel.text = [TSTools getCipherPhone:item.userModel.mobile];
    _salesNumLabel.text = [NSString stringWithFormat:@"¥%@", item.userModel.money];
    
    //最底部切圆角
    NSInteger radii = item.isLast ? 10 : 0;
    self.contentView.clipsToBounds = YES;
    [self.contentView setCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:radii];
    
}

@end
