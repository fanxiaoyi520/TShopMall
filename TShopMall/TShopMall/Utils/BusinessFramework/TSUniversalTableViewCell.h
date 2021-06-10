//
//  TSUniversalTableViewCell.h
//  TSale
//
//  Created by 陈洁 on 2020/11/27.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUniversalTableViewCell : UITableViewCell

/// override by sub class
- (void)fillCustomContentView;

+ (void)displayImageView:(UIImageView *)view
                     url:(nullable NSString *)url;
+ (void)displayImageView:(UIImageView *)view
                     url:(nullable NSString *)url
        placeHolderImage:(nullable UIImage *)placeHolderImage;

+ (void)displayLabel:(UILabel *)view
               title:(nullable NSString *)title;

+ (void)displayButton:(UIButton *)view
              iconUrl:(nullable NSString *)iconUrl
     placeHolderImage:(nullable UIImage *)placeHolderImage
                title:(nullable NSString *)title;

@end

NS_ASSUME_NONNULL_END
