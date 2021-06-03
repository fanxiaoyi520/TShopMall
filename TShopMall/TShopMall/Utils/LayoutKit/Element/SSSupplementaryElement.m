//
//  SSSupplementaryElement.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSSupplementaryElement.h"

@implementation SSSupplementaryElement

-(id)copyWithZone:(NSZone *)zone
{
    SSSupplementaryElement *element = [super copyWithZone:zone];
    element.elementSize = self.elementSize;
    element.zIndex = self.zIndex;
    element.autoHeight = self.autoHeight;
    element.configureElementDataAutoHeight = self.configureElementDataAutoHeight;
    return element;
}

+(instancetype)elementWithElementSize:(CGFloat)elementSize
                            viewClass:(Class)viewClass
{
    return [self elementWithElementSize:elementSize
                              viewClass:viewClass
                        reuseIdentifier:NSStringFromClass(viewClass)];
}

+(instancetype)elementWithElementSize:(CGFloat)elementSize
                            viewClass:(Class)viewClass
                      reuseIdentifier:(NSString *)reuseIdentifier
{
    SSSupplementaryElement *supplementaryElement = [super elementWithClass:viewClass reuseIdentifier:reuseIdentifier];
    supplementaryElement.elementSize = elementSize;
    supplementaryElement.zIndex = SSLayoutZIndexFrontOfItem;
    return supplementaryElement;
}

-(void)registerElementWithCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:self.viewClass forSupplementaryViewOfKind:self.elementKind withReuseIdentifier:self.reuseIdentifier];
}

-(UICollectionReusableView *)dequeueReusableViewWithCollection:(UICollectionView *)collectionView
                                                     indexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableSupplementaryViewOfKind:self.elementKind withReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
}

-(void)updateHeightWithCollection:(UICollectionView *)collectionView
                        indexPath:(NSIndexPath *)indexPath
                         maxWidth:(CGFloat)maxWidth{
    if (self.autoHeight) {
        UICollectionReusableView *reusableView = [[self.viewClass alloc] init];
        if (self.configureElementDataAutoHeight) {
            self.configureElementDataAutoHeight(reusableView);
        }
        CGSize size = [reusableView systemLayoutSizeFittingSize:CGSizeMake(maxWidth, MAXFLOAT)];
        self.elementSize = size.height;
    }
}

@end
