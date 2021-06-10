//
//  TSUniversalCollectionViewCell.h
//  TSale
//
//  Created by 陈洁 on 2020/12/8.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UniversalCollectionViewCellDataDelegate <NSObject>

@optional
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath;
-(void)universalCollectionViewCellClick:(NSIndexPath *)indexPath;
-(void)universalCollectionViewCellClick:(NSIndexPath *)indexPath
                                 params:(NSDictionary *)params;

@end

@interface TSUniversalCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<UniversalCollectionViewCellDataDelegate> delegate;

@property (nonatomic) NSIndexPath *indexPath;

/**< override by sub class*/
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
