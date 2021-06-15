//
//  TSSearchBaseCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchBaseCell.h"

@implementation TSSearchBaseCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = KWhiteColor;
        
        [self layoutView];
    }
    return self;
}

- (void)layoutView{};


- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [self setNeedsLayout];
    [self layoutIfNeeded];

    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size = size;
    layoutAttributes.frame= cellFrame;

    return layoutAttributes;
}

@end
