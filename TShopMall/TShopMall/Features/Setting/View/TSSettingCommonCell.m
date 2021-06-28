//
//  TSSettingCommonCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSettingCommonCell.h"
#import "TSSettingSectionModel.h"
#import "TSAboutMeSectionModel.h"

@interface TSSettingCommonCell ()
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 副标题 */
@property(nonatomic, weak) UILabel *detailLabel;
/** 右标识 */
@property(nonatomic, weak) UIImageView *rightImgV;
/** 更新标志 */
@property(nonatomic, weak) UIView *updateFlagView;
/** 分割线 */
@property(nonatomic, weak) UIView *splitView;

@end

@implementation TSSettingCommonCell

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
        make.width.mas_lessThanOrEqualTo(180);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.rightImgV.mas_left).with.offset(-16);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.updateFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.rightImgV.mas_left).with.offset(-10);
        make.width.height.mas_equalTo(6);
    }];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"JERRYJUICE";
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = KRegularFont(16);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        UILabel *detailLabel = [[UILabel alloc] init];
        _detailLabel = detailLabel;
        _detailLabel.text = @"";
        _detailLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _detailLabel.font = KRegularFont(16);
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
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

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexColor(@"#E6E6E6");
        [self.contentView addSubview:_splitView];
    }
    return _splitView;
}

- (UIView *)updateFlagView {
    if (_updateFlagView == nil) {
        UIView *updateFlagView = [[UIView alloc] init];
        _updateFlagView = updateFlagView;
        _updateFlagView.layer.cornerRadius = 3;
        _updateFlagView.clipsToBounds = YES;
        _updateFlagView.hidden = YES;
        _updateFlagView.backgroundColor = KHexColor(@"#E64C3D");
        [self.contentView addSubview:_updateFlagView];
    }
    return _updateFlagView;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSUniversaItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    if ([item isKindOfClass:[TSSettingCommonSectionItemModel class]]) {
        TSSettingCommonSectionItemModel *_item = (TSSettingCommonSectionItemModel *)item;
        self.titleLabel.text = _item.title;
        self.detailLabel.text = _item.detail;
        self.splitView.hidden = !_item.showLine;
        self.updateFlagView.hidden = !_item.updateFlag;
    } else if ([item isKindOfClass:[TSAboutMeBottomSectionItemModel class]]) {
        TSAboutMeBottomSectionItemModel *_item = (TSAboutMeBottomSectionItemModel *)item;
        self.titleLabel.text = _item.title;
        self.detailLabel.text = _item.detail;
        self.splitView.hidden = !_item.showLine;
        self.updateFlagView.hidden = !_item.updateFlag;
    }
    
}

@end
