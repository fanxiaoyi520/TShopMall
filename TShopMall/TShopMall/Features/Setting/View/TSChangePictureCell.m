//
//  TSChangePictureTopCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSChangePictureCell.h"
#import "TSChangePictureSectionModel.h"

@interface TSChangePictureCell ()
/** icon */
@property(nonatomic, weak) UIImageView *iconImgV;
/** 选中后背景视图 */
@property(nonatomic, weak) UIView *bgView;
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
@end

@implementation TSChangePictureCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(88);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.bgView.mas_bottom).with.offset(16);
    }];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        _bgView.backgroundColor = KHexColor(@"#EEF0FC");
        _bgView.layer.cornerRadius = 5;
        _bgView.clipsToBounds = YES;
        _bgView.hidden = YES;
        [self.contentView insertSubview:_bgView atIndex:0];
    }
    return _bgView;
}

- (UIImageView *)iconImgV {
    if (_iconImgV == nil) {
        UIImageView *iconImgV = [[UIImageView alloc] init];
        _iconImgV = iconImgV;
        [self.contentView addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSChangePictureSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.iconImgV.image = KImageMake(item.icon);
    self.titleLabel.text = item.title;
    self.bgView.hidden = !item.isSelected;
}

@end
