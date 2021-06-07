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
    SSCollectionViewLayoutAttributes *header = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:baseSection.indexPath];
    header.direction = baseSection.direction;
    if (header.direction == SSLayoutDirectionVertical) {
        
        CGFloat collectionWidth = CGRectGetWidth(baseSection.collectionView.frame);
        CGFloat width = baseSection.sectionInset.left - baseSection.sectionInset.right - baseSection.header.edgeInsets.left - baseSection.header.edgeInsets.right;
        [baseSection.header updateHeightWithCollection:baseSection.collectionView
                                             indexPath:baseSection.indexPath
                                              maxWidth:width];
        
        CGFloat headerX = baseSection.sectionInset.left + baseSection.header.edgeInsets.left;
        CGFloat headerY = baseSection.sectionOffset + baseSection.sectionInset.top + baseSection.header.edgeInsets.top;
        CGFloat headerW = collectionWidth - baseSection.sectionInset.left - baseSection.sectionInset.right - baseSection.header.edgeInsets.left - baseSection.header.edgeInsets.right;
        CGFloat headerH = baseSection.header.elementSize;
        
        header.frame = CGRectMake(headerX, headerY, headerW, headerH);
        
    } else {
        
        CGFloat headerX = baseSection.sectionOffset + baseSection.sectionInset.left + baseSection.header.edgeInsets.left;
        CGFloat headerY = baseSection.sectionInset.top + baseSection.header.edgeInsets.top;
        CGFloat headerW = baseSection.header.elementSize;
        CGFloat headerH = baseSection.collectionView.frame.size.height - baseSection.sectionInset.top - baseSection.header.edgeInsets.top - baseSection.sectionInset.bottom - baseSection.header.edgeInsets.bottom;
        
        header.frame = CGRectMake(headerX,headerY,headerW,headerH);
    }
    header.zIndex = baseSection.header.zIndex;
    return header;
}

-(instancetype)updateHeaderAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    self.indexPath = baseSection.indexPath;
    [self _onlyUpdateOffsetWith:baseSection];
    return self;
}

+(instancetype)suspensionHeaderAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}


+ (instancetype)footerAttributesWithSection:(SSLayoutBaseSection *)section
{
    return nil;
}

- (instancetype)updateFooterAttributesWithSection:(SSLayoutBaseSection *)section{
    self.indexPath = section.indexPath;
    [self _onlyUpdateOffsetWith:section];
    return self;
}

+(instancetype)backgroundAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    return nil;
}

-(instancetype)updateBackgroundAttributesWithSection:(SSLayoutBaseSection *)baseSection
{
    self.indexPath = baseSection.indexPath;
    [self _onlyUpdateOffsetWith:baseSection];
    return self;
}

-(void)_onlyUpdateOffsetWith:(SSLayoutBaseSection *)section
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (!CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity)) {
        transform = self.transform;
    }
    self.transform = CGAffineTransformIdentity;
    if (self.direction == SSLayoutDirectionVertical) {
        CGRect frame = self.frame;
        frame.origin.y += section.changeOffset;
        self.frame = frame;
    } else {
        CGRect frame = self.frame;
        frame.origin.x += section.changeOffset;
        self.frame = frame;
    }
    self.transform = transform;
}

@end
