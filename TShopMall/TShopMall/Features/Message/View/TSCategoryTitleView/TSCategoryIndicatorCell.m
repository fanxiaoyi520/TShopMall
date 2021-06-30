//
//  TSCategoryIndicatorCell.m
//  TShopMall
//
//  Created by oneyian on 2021/6/30.
//

#import "TSCategoryIndicatorCell.h"
#import "JXCategoryTitleCellModel.h"
#import "JXCategoryFactory.h"
#import "UIView+AZGradient.h"

@interface TSCategoryIndicatorCell ()
@property (nonatomic, strong) CALayer *titleMaskLayer;
@property (nonatomic, strong) CALayer *maskTitleMaskLayer;
@property (nonatomic, strong) NSLayoutConstraint *maskTitleLabelCenterY;
@end

@implementation TSCategoryIndicatorCell

- (void)initializeViews {
    [super initializeViews];

    self.isAccessibilityElement = true;
    self.accessibilityTraits = UIAccessibilityTraitButton;
    
    _bg_white_view = [[UIView alloc] initWithFrame:CGRectMake(0, (53 - 27) / 2, 71, 27)];
    _bg_white_view.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_bg_white_view];
    
    _bg_View = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 71 - 2, 27 - 2)];
    [_bg_white_view addSubview:_bg_View];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];

    self.titleLabelCenterX = [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:0];
    self.titleLabelCenterY = [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0];

    _titleMaskLayer = [CALayer layer];
    self.titleMaskLayer.backgroundColor = [UIColor redColor].CGColor;

    _maskTitleLabel = [[UILabel alloc] init];
    self.maskTitleLabel.hidden = YES;
    self.maskTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.maskTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maskTitleLabel];

    self.maskTitleLabelCenterX = [self.maskTitleLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor];
    self.maskTitleLabelCenterY = [self.maskTitleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor];

    _maskTitleMaskLayer = [CALayer layer];
    self.maskTitleMaskLayer.backgroundColor = [UIColor redColor].CGColor;
    self.maskTitleLabel.layer.mask = self.maskTitleMaskLayer;

    [NSLayoutConstraint activateConstraints:@[self.titleLabelCenterX, self.titleLabelCenterY, self.maskTitleLabelCenterX, self.maskTitleLabelCenterY]];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)self.cellModel;
    switch (myCellModel.titleLabelAnchorPointStyle) {
        case JXCategoryTitleLabelAnchorPointStyleCenter: {
            self.titleLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
            self.maskTitleLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
            self.titleLabelCenterY.constant = 0 + myCellModel.titleLabelVerticalOffset;
            break;
        }
        case JXCategoryTitleLabelAnchorPointStyleTop: {
            self.titleLabel.layer.anchorPoint = CGPointMake(0.5, 0);
            self.maskTitleLabel.layer.anchorPoint = CGPointMake(0.5, 0);
            CGFloat percent = (myCellModel.titleLabelCurrentZoomScale - myCellModel.titleLabelNormalZoomScale)/(myCellModel.titleLabelSelectedZoomScale - myCellModel.titleLabelNormalZoomScale);
            self.titleLabelCenterY.constant = -myCellModel.titleHeight/2 - myCellModel.titleLabelVerticalOffset - myCellModel.titleLabelZoomSelectedVerticalOffset*percent;
            break;
        }
        case JXCategoryTitleLabelAnchorPointStyleBottom: {
            self.titleLabel.layer.anchorPoint = CGPointMake(0.5, 1);
            self.maskTitleLabel.layer.anchorPoint = CGPointMake(0.5, 1);
            CGFloat percent = (myCellModel.titleLabelCurrentZoomScale - myCellModel.titleLabelNormalZoomScale)/(myCellModel.titleLabelSelectedZoomScale - myCellModel.titleLabelNormalZoomScale);
            self.titleLabelCenterY.constant = myCellModel.titleHeight/2 + myCellModel.titleLabelVerticalOffset + myCellModel.titleLabelZoomSelectedVerticalOffset*percent;
            break;
        }
    }
}


- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;
    self.accessibilityLabel = myCellModel.title;
    self.titleLabel.numberOfLines = myCellModel.titleNumberOfLines;
    self.maskTitleLabel.numberOfLines = myCellModel.titleNumberOfLines;

    if (myCellModel.isTitleLabelZoomEnabled) {
        //先把font设置为缩放的最大值，再缩小到最小值，最后根据当前的titleLabelZoomScale值，进行缩放更新。这样就能避免transform从小到大时字体模糊
        UIFont *maxScaleFont = [UIFont fontWithDescriptor:myCellModel.titleFont.fontDescriptor size:myCellModel.titleFont.pointSize*myCellModel.titleLabelSelectedZoomScale];
        CGFloat baseScale = myCellModel.titleFont.lineHeight/maxScaleFont.lineHeight;
        if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleZoomAnimationBlock:myCellModel baseScale:baseScale];
            [self addSelectedAnimationBlock:block];
        } else {
            self.titleLabel.font = maxScaleFont;
            self.maskTitleLabel.font = maxScaleFont;
            CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*myCellModel.titleLabelCurrentZoomScale, baseScale*myCellModel.titleLabelCurrentZoomScale);
            self.titleLabel.transform = currentTransform;
            self.maskTitleLabel.transform = currentTransform;
        }
    } else {
        if (myCellModel.isSelected) {
            self.titleLabel.font = myCellModel.titleSelectedFont;
            self.maskTitleLabel.font = myCellModel.titleSelectedFont;
        } else {
            self.titleLabel.font = myCellModel.titleFont;
            self.maskTitleLabel.font = myCellModel.titleFont;
        }
    }

    NSString *titleString = myCellModel.title ? myCellModel.title : @"";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    if (myCellModel.isTitleLabelStrokeWidthEnabled) {
        if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleStrokeWidthAnimationBlock:myCellModel attributedString:attributedString];
            [self addSelectedAnimationBlock:block];
        } else {
            [attributedString addAttribute:NSStrokeWidthAttributeName value:@(myCellModel.titleLabelCurrentStrokeWidth) range:NSMakeRange(0, titleString.length)];
            self.titleLabel.attributedText = attributedString;
            self.maskTitleLabel.attributedText = attributedString;
        }
    } else {
        self.titleLabel.attributedText = attributedString;
        self.maskTitleLabel.attributedText = attributedString;
    }

    if (myCellModel.isTitleLabelMaskEnabled) {
        self.maskTitleLabel.hidden = NO;
        self.titleLabel.textColor = myCellModel.titleNormalColor;
        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;
        [self.contentView setNeedsLayout];
        [self.contentView layoutIfNeeded];

        CGRect topMaskframe = myCellModel.backgroundViewMaskFrame;
        //将相对于cell的backgroundViewMaskFrame转换为相对于maskTitleLabel
        //使用self.bounds.size.width而不是self.contentView.bounds.size.width。因为某些情况下，会出现self.bounds是正确的，而self.contentView.bounds还是重用前的状态。
        topMaskframe.origin.y = 0;
        CGRect bottomMaskFrame = topMaskframe;
        CGFloat maskStartX = 0;
        if (self.maskTitleLabel.bounds.size.width >= self.bounds.size.width) {
            topMaskframe.origin.x -= (self.maskTitleLabel.bounds.size.width -self.bounds.size.width)/2;
            bottomMaskFrame.size.width = self.maskTitleLabel.bounds.size.width;
            maskStartX = -(self.maskTitleLabel.bounds.size.width -self.bounds.size.width)/2;
        } else {
            bottomMaskFrame.size.width = self.bounds.size.width;
            topMaskframe.origin.x -= (self.bounds.size.width -self.maskTitleLabel.bounds.size.width)/2;
            maskStartX = 0;
        }
        bottomMaskFrame.origin.x = topMaskframe.origin.x;
        if (topMaskframe.origin.x > maskStartX) {
            bottomMaskFrame.origin.x = topMaskframe.origin.x - bottomMaskFrame.size.width;
        } else {
            bottomMaskFrame.origin.x = CGRectGetMaxX(topMaskframe);
        }

        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (topMaskframe.size.width > 0 && CGRectIntersectsRect(topMaskframe, self.maskTitleLabel.frame)) {
            self.titleLabel.layer.mask = self.titleMaskLayer;
            self.maskTitleMaskLayer.frame = topMaskframe;
            self.titleMaskLayer.frame = bottomMaskFrame;
        } else {
            self.maskTitleMaskLayer.frame = topMaskframe;
            self.titleLabel.layer.mask = nil;
        }
        [CATransaction commit];
    } else {
        self.maskTitleLabel.hidden = YES;
        self.titleLabel.layer.mask = nil;
        if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleColorAnimationBlock:myCellModel];
            [self addSelectedAnimationBlock:block];
        } else {
           self.titleLabel.textColor = myCellModel.titleCurrentColor;
        }
    }
    
    NSLog(@"oneyian：%@ - %@", @(myCellModel.index), @(myCellModel.isSelected));
//    self.backgroundColor = KWhiteColor;
    
    //渐变颜色
    UIColor *top_nor_color = KHexColor(@"#FF7673");
    UIColor *bottom_nor_color = KHexColor(@"#FA4744");
    
    UIColor *top_select_color = KHexColor(@"#FF504E");
    UIColor *bottom_select_color = KHexColor(@"#FF3733");
    
    if (myCellModel.isSelected) {
        _bg_View.frame = CGRectMake(1, 1, 71 - 2, 27 - 2);
        
        _bg_white_view.backgroundColor = [KWhiteColor colorWithAlphaComponent:0.5];
        [_bg_View az_setGradientBackgroundWithColors:@[top_select_color, bottom_select_color] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    }else {
        _bg_View.frame = CGRectMake(0, 0, 71, 27);
        
        _bg_white_view.backgroundColor = KClearColor;
        [_bg_View az_setGradientBackgroundWithColors:@[top_nor_color, bottom_nor_color] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    }
    
    //圆角
    NSInteger radii = 4;
    if (myCellModel.index == 0) {
        [_bg_white_view jaf_customFilletRectCorner:(UIRectCornerTopLeft|UIRectCornerBottomLeft) cornerRadii:CGSizeMake(radii, radii)];
        [_bg_View jaf_customFilletRectCorner:(UIRectCornerTopLeft|UIRectCornerBottomLeft) cornerRadii:CGSizeMake(radii, radii)];
    }else {
        [_bg_white_view jaf_customFilletRectCorner:(UIRectCornerTopRight|UIRectCornerBottomRight) cornerRadii:CGSizeMake(radii, radii)];
        [_bg_View jaf_customFilletRectCorner:(UIRectCornerTopRight|UIRectCornerBottomRight) cornerRadii:CGSizeMake(radii, radii)];
    }
    
    [self startSelectedAnimationIfNeeded:myCellModel];
}

#pragma mark - Public

- (JXCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(JXCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            //将要选中，scale从小到大插值渐变
            cellModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:cellModel.titleLabelNormalZoomScale to:cellModel.titleLabelSelectedZoomScale percent:percent];
        } else {
            //将要取消选中，scale从大到小插值渐变
            cellModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:cellModel.titleLabelSelectedZoomScale to:cellModel.titleLabelNormalZoomScale percent:percent];
        }
        CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*cellModel.titleLabelCurrentZoomScale, baseScale*cellModel.titleLabelCurrentZoomScale);
        weakSelf.titleLabel.transform = currentTransform;
        weakSelf.maskTitleLabel.transform = currentTransform;
    };
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(JXCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            //将要选中，StrokeWidth从小到大插值渐变
            cellModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:cellModel.titleLabelNormalStrokeWidth to:cellModel.titleLabelSelectedStrokeWidth percent:percent];
        } else {
            //将要取消选中，StrokeWidth从大到小插值渐变
            cellModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:cellModel.titleLabelSelectedStrokeWidth to:cellModel.titleLabelNormalStrokeWidth percent:percent];
        }
        [attributedString addAttribute:NSStrokeWidthAttributeName value:@(cellModel.titleLabelCurrentStrokeWidth) range:NSMakeRange(0, attributedString.string.length)];
        weakSelf.titleLabel.attributedText = attributedString;
        weakSelf.maskTitleLabel.attributedText = attributedString;
    };
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(JXCategoryTitleCellModel *)cellModel {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            //将要选中，textColor从titleNormalColor到titleSelectedColor插值渐变
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleNormalColor to:cellModel.titleSelectedColor percent:percent];
        } else {
            //将要取消选中，textColor从titleSelectedColor到titleNormalColor插值渐变
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleSelectedColor to:cellModel.titleNormalColor percent:percent];
        }
        weakSelf.titleLabel.textColor = cellModel.titleCurrentColor;
    };
}

@end
