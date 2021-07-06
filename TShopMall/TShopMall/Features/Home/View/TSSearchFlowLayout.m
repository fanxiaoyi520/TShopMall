//
//  TSSearchFlowLayout.m
//  TShopMall
//
//  Created by 橙子 on 2021/7/5.
//

#import "TSSearchFlowLayout.h"

@implementation TSSearchFlowLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray * attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
   // 设置的最大间距，一般这个间距是固定的，就用外部能写的最小间距值
    CGFloat maximumSpacing = self.minimumInteritemSpacing;
    
    if (attributes.count > 0) {
        UICollectionViewLayoutAttributes *firstAttributes = attributes[0];
        CGRect frame = firstAttributes.frame;
        frame.origin.x = self.sectionInset.left;
        firstAttributes.frame = frame;
    }
    //第一个frame不用更改 从第二个循环到最后一个
    for (NSInteger i = 1 ; i < attributes.count ; i++ ) {
        // 当前的attribute
        UICollectionViewLayoutAttributes * currentLayoutAttributes = attributes[i];
        // 上一个attribute
        UICollectionViewLayoutAttributes * prevLayoutAttributes = attributes[i - 1];
        // 前一个cell的最右边
        CGFloat origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        // 如果当前一个cell的最右边加上我们的想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        // 不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有的cell的x值都被加到第一行最后一个元素的后面了 考虑cell与view的左右间距
        if (origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width -self.sectionInset.right ) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        } else {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = self.sectionInset.left;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}


@end
