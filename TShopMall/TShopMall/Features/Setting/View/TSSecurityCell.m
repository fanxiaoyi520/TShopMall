//
//  TSSecurityCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSecurityCell.h"
#import "TSSettingSectionModel.h"

@interface TSSecurityCell ()
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 副标题 */
@property(nonatomic, weak) UILabel *detailLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitView;
/** 开关按钮 */
@property(nonatomic, weak) UISwitch *wechatSwitch;

@end

@implementation TSSecurityCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.33);
    }];
    [self.wechatSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wechatSwitch.mas_left).with.offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.width.mas_lessThanOrEqualTo(100);
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = KRegularFont(16);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexColor(@"#E6E6E6");
        [self.contentView addSubview:_splitView];
    }
    return _splitView;
}

- (UISwitch *)wechatSwitch {
    if (_wechatSwitch == nil) {
        UISwitch *wechatSwitch = [[UISwitch alloc] init];
        _wechatSwitch = wechatSwitch;
        _wechatSwitch.onTintColor = KHexColor(@"#FF4D49");
        [self.contentView addSubview:_wechatSwitch];
    }
    return _wechatSwitch;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        UILabel *detailLabel = [[UILabel alloc] init];
        _detailLabel = detailLabel;
        _detailLabel.text = @"";
        _detailLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _detailLabel.font = KRegularFont(12);
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSSettingCommonSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.titleLabel.text = item.title;
    self.detailLabel.text = item.detail;
    self.wechatSwitch.on = item.on;
}
@end
