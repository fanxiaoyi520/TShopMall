//
//  SSCollectionViewLayoutAttributes.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSCollectionViewLayoutAttributes.h"
#import "SSLayoutHeader.h"
#import "SSLayoutFooter.h"
#import "SSLayoutBackground.h"

@implementation SSCollectionViewLayoutAttributes

+(instancetype)headerAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    if (!baseSection.header) {
        return nil;
    }
    SSCollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:baseSection.header.elementKind withIndexPath:baseSection.indexPath];
    headerAttributes.direction = baseSection.direction;
    if (headerAttributes.direction == SSLayoutDirectionVertical) {
        
        CGFloat width = CGRectGetWidth(baseSection.collectionView.frame) - baseSection.sectionInset.left - baseSection.sectionInset.right - baseSection.header.edgeInsets.left - baseSection.header.edgeInsets.right;
        [baseSection.header updateHeightWithCollection:baseSection.collectionView indexPath:baseSection.indexPath maxWidth:width];
        
        CGFloat headerAttributesX = baseSection.sectionInset.left + baseSection.header.edgeInsets.left;
        CGFloat headerAttributesY = baseSection.sectionOffset + baseSection.sectionInset.top + baseSection.header.edgeInsets.top;
        CGFloat headerAttributesW = baseSection.collectionView.frame.size.width - baseSection.sectionInset.left- baseSection.header.edgeInsets.left - baseSection.sectionInset.right - baseSection.header.edgeInsets.right;
        CGFloat headerAttributesH = baseSection.header.elementSize;
        
        headerAttributes.frame = CGRectMake(headerAttributesX, headerAttributesY, headerAttributesW, headerAttributesH);
        
    } else {
        CGFloat headerAttributesX = baseSection.sectionInset.left + baseSection.header.edgeInsets.left + baseSection.sectionOffset;
        CGFloat headerAttributesY = baseSection.sectionInset.top + baseSection.header.edgeInsets.top;
        CGFloat headerAttributesW = baseSection.header.elementSize;
        CGFloat headerAttributesH = baseSection.collectionView.frame.size.height - baseSection.sectionInset.top- baseSection.header.edgeInsets.top - baseSection.sectionInset.bottom - baseSection.header.edgeInsets.bottom;
        
        headerAttributes.frame = CGRectMake(headerAttributesX, headerAttributesY, headerAttributesW, headerAttributesH);
    }
    return headerAttributes;
}
-(instancetype)updateHeaderAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    self.indexPath = baseSection.indexPath;
    [self _onlyUpdateOffSetWithSection:baseSection];
    return self;
}

+(instancetype)suspensionHeaderAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}

+(instancetype)footerAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}
-(instancetype)updateFooterAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}

+(instancetype)backgroundAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}
-(instancetype)updateBackgroundAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}

#pragma mark - Private
-(void)_onlyUpdateOffSetWithSection:(SSLayoutBaseSection *)baseSection
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (!CGAffineTransformEqualToTransform(self.transform, transform)) {
        transform = self.transform;
    }
    self.transform = CGAffineTransformIdentity;
    if (self.direction == SSLayoutDirectionVertical) {
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y + baseSection.changeOffset;
        self.frame = frame;
    } else {
        CGRect frame = self.frame;
        frame.origin.x = frame.origin.x + baseSection.changeOffset;
        self.frame =  frame;
    }
    self.transform = transform;
}

@end
