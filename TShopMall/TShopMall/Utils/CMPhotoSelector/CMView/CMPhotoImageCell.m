//
//  CMPhotoImageCell.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/19.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoImageCell.h"
#import "CMPhotoALAssets.h"

@interface CMPhotoImageCell ()

/** 显示图片的视图 */
@property (nonatomic, weak) UIImageView *imageView;
/** 显示该图片是否选中的视图 */
@property (nonatomic, weak) UIImageView *icon;

@end

@implementation CMPhotoImageCell

- (void)setPhotoALAssets:(CMPhotoALAssets *)photoALAssets {
    _photoALAssets = photoALAssets;
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:photoALAssets.photoAsset targetSize:CGSizeMake(self.bounds.size.width * 2, self.bounds.size.height * 2) contentMode:PHImageContentModeAspectFill options:imageOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        self.imageView.image = result;
    }];
    self.icon.hidden = !photoALAssets.isSelected;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)icon {
    if (_icon == nil) {
        UIImageView *icon = [[UIImageView alloc] init];
        _icon = icon;
        _icon.image = KImageMake(@"mall_detail_selected");
        [self.contentView addSubview:_icon];
    }
    return _icon;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    ///设置约束
    [self setConstraints];
}

- (void)setConstraints {
    /////////////设置显示图片的约束///////////
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *imageViewLeft = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *imageViewTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:1];
    NSLayoutConstraint *imageViewBottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *imageViewRight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[imageViewLeft, imageViewTop, imageViewBottom, imageViewRight]];
    /////////////设置显示图片是否选中视图的约束///////////
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *iconRight = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5];
    NSLayoutConstraint *iconBottom = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5];
    NSLayoutConstraint *iconWidth = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:18];
    NSLayoutConstraint *iconHeight = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:18];
    [self.contentView addConstraints:@[iconWidth, iconRight, iconBottom, iconHeight]];
}

@end
