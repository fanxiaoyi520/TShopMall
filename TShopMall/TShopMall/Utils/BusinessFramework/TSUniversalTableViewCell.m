//
//  TSUniversalTableViewCell.m
//  TSale
//
//  Created by 陈洁 on 2020/11/27.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSUniversalTableViewCell.h"
#import "UIImage+TSColor.h"

@implementation TSUniversalTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self fillCustomContentView];
    }
    return self;
}

- (void)fillCustomContentView {
    // do nothing
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark Static func

+ (void)displayImageView:(UIImageView *)view url:(NSString *)url {
    UIImage *image = [UIImage ts_imageWithColor:KWhiteColor];
    [self displayImageView:view url:url placeHolderImage:image];
}

+ (void)displayImageView:(UIImageView *)view url:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage {
    if (!view) {
        return;
    }
    if ((url && url.length > 0) || placeHolderImage) {
        [view setHidden:NO];
        if ([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"]) {
            NSURL *urlObj = [NSURL URLWithString:url];
            [view sd_setImageWithURL:urlObj placeholderImage:placeHolderImage];
        } else {
            UIImage *image = [UIImage imageNamed:url];
            [view setImage:(image ?: placeHolderImage)];
        }
    } else {
        [view setHidden:YES];
        [view setImage:nil];
    }
}

+ (void)displayLabel:(UILabel *)view title:(NSString *)title {
    if (!view) {
        return;
    }
    BOOL hasContent = (title.length > 0);
    [view setHidden:!hasContent];
    [view setText:title];
}

+ (void)displayButton:(UIButton *)view iconUrl:(NSString *)iconUrl placeHolderImage:(UIImage *)placeHolderImage title:(NSString *)title {
    if (!view) {
        return;
    }
    if ((iconUrl && iconUrl.length > 0) || placeHolderImage) {
        if ([iconUrl hasPrefix:@"https://"] || [iconUrl hasPrefix:@"http://"]) {
            NSURL *urlObj = [NSURL URLWithString:iconUrl];
            [view sd_setImageWithURL:urlObj forState:UIControlStateNormal placeholderImage:placeHolderImage];
        } else {
            UIImage *image = [UIImage imageNamed:iconUrl];
            [view setImage:(image ?: placeHolderImage) forState:UIControlStateNormal];
        }
    }
    [view setTitle:title forState:UIControlStateNormal];
}


@end
