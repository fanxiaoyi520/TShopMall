//
//  TSPersonalCommonCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSPersonalCommonCell.h"
#import "TSPersonalSectionModel.h"
#import "UIImageView+WebCache.h"

@interface TSPersonalCommonCell ()
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 副标题 */
@property(nonatomic, weak) UILabel *detailLabel;
/** 右标识 */
@property(nonatomic, weak) UIImageView *rightImgV;
/** 分割线 */
@property(nonatomic, weak) UIView *splitView;
/** 头像 */
@property(nonatomic, weak) UIImageView *headImgV;
/** sex */
@property(nonatomic, weak) UIImageView *sexImgV;

@end

@implementation TSPersonalCommonCell

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
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.rightImgV.mas_left).with.offset(-13);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.rightImgV.mas_left).with.offset(-13);
        make.width.height.mas_equalTo(30);
    }];
    [self.sexImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.rightImgV.mas_left).with.offset(-13);
        make.width.height.mas_equalTo(17);
    }];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.height.mas_equalTo(16);
    }];
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.33);
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
        _detailLabel.textColor = KTextColor;
        _detailLabel.font = KRegularFont(16);
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UIImageView *)rightImgV {
    if (_rightImgV == nil) {
        UIImageView *rightImgV = [[UIImageView alloc] init];
        _rightImgV = rightImgV;
        _rightImgV.image = KImageMake(@"mall_setting_arrow_light");
        [self.contentView addSubview:_rightImgV];
    }
    return _rightImgV;
}

- (UIImageView *)headImgV {
    if (_headImgV == nil) {
        UIImageView *headImgV = [[UIImageView alloc] init];
        _headImgV = headImgV;
        [self.contentView addSubview:_headImgV];
    }
    return _headImgV;
}

- (UIImageView *)sexImgV {
    if (_sexImgV == nil) {
        UIImageView *sexImgV = [[UIImageView alloc] init];
        _sexImgV = sexImgV;
        [self.contentView addSubview:_sexImgV];
    }
    return _sexImgV;
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


-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSPersonalSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.titleLabel.text = item.title;
    if (item.detail) {
        NSString *detail = [item.detail isEqualToString:@"2"] ? @"未实名认证" : item.detail;
        self.detailLabel.text = detail;
        self.detailLabel.hidden = NO;
        self.headImgV.hidden = YES;
        self.sexImgV.hidden = YES;
    }
    if (item.head) {
        NSString *headUrl = [item.head isEqualToString:@"default"] ? @"mall_setting_defautlhead" : item.head;
        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
        self.detailLabel.hidden = YES;
        self.headImgV.hidden = NO;
        self.sexImgV.hidden = YES;
    }
    if (item.sex != none) {
        self.sexImgV.image = item.sex == male ? KImageMake(@"mall_setting_male") : KImageMake(@"mall_setting_female");
        self.detailLabel.hidden = YES;
        self.headImgV.hidden = YES;
        self.sexImgV.hidden = NO;
    }
}

@end
