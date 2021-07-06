//
//  TSSecurityCenterTitleCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSecurityCenterTitleCell.h"
#import "TSSettingSectionModel.h"

@interface TSSecurityCenterTitleCell ()
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 分割线 */
@property(nonatomic, weak) UIView *splitView;

@end

@implementation TSSecurityCenterTitleCell

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
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _titleLabel.font = KRegularFont(12);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexColor(@"#F4F4F4");
        [self.contentView addSubview:_splitView];
    }
    return _splitView;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSSettingCommonSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.titleLabel.text = item.title;
}
@end
