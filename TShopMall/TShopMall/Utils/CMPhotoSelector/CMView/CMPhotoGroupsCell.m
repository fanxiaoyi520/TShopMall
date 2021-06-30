//
//  CMPhotoGroupsCell.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoGroupsCell.h"
#import "CMPhotoGroup.h"

@interface CMPhotoGroupsCell ()
/** 相册的icon */
@property (nonatomic, weak) UIImageView *iconImgV;
/** 相册的名称 */
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation CMPhotoGroupsCell

- (void)setPhotoGroup:(CMPhotoGroup *)photoGroup {
    _photoGroup = photoGroup;
    self.iconImgV.image = photoGroup.groupIcon;
    self.nameLabel.text = [photoGroup.groupName stringByAppendingFormat:@"(%lu)", (unsigned long)photoGroup.photoALAssets.count];
}

- (UIImageView *)iconImgV {
    if (_iconImgV == nil) {
        UIImageView *iconImgV = [[UIImageView alloc] init];
        _iconImgV = iconImgV;
        [self.contentView addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    ///设置约束
    [self setConstraints];
}
/**
 * 设置约束
 */
- (void)setConstraints {
    /////////////设置相册图标的约束///////////
    self.iconImgV.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *iconImgVLeft = [NSLayoutConstraint constraintWithItem:self.iconImgV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    NSLayoutConstraint *iconImgVTop = [NSLayoutConstraint constraintWithItem:self.iconImgV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:1];
    NSLayoutConstraint *iconImgVBottom = [NSLayoutConstraint constraintWithItem:self.iconImgV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1];
    NSLayoutConstraint *iconImgVWidth = [NSLayoutConstraint constraintWithItem:self.iconImgV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:50];
    [self.contentView addConstraints:@[iconImgVLeft, iconImgVTop, iconImgVBottom, iconImgVWidth]];
    /////////////设置相册名称的约束///////////
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *nameLabelLeft = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconImgV attribute:NSLayoutAttributeRight multiplier:1.0 constant:20];
    NSLayoutConstraint *nameLabelCenterY = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[nameLabelLeft, nameLabelCenterY]];
}
@end
