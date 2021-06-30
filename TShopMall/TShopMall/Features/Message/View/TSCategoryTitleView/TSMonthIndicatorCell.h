//
//  TSCategoryIndicatorCell.h
//  TShopMall
//
//  Created by oneyian on 2021/6/30.
//

#import "JXCategoryIndicatorCell.h"
#import "JXCategoryViewDefines.h"

@class JXCategoryTitleCellModel;

@interface TSMonthIndicatorCell : JXCategoryIndicatorCell

@property (nonatomic, strong) UIView * bg_white_view;
@property (nonatomic, strong) UIView * bg_View;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *maskTitleLabel;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterY;
@property (nonatomic, strong) NSLayoutConstraint *maskTitleLabelCenterX;

- (JXCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(JXCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale;

- (JXCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(JXCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString;

- (JXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(JXCategoryTitleCellModel *)cellModel;

@end
