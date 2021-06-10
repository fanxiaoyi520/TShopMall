//
//  TSUniversalFlowLayout.m
//  TSale
//
//  Created by 陈洁 on 2020/12/8.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSUniversalFlowLayout.h"
#import "TSUniversalDecorationView.h"

@interface TSUniversalFlowLayout()

/// Attributes
@property (nonatomic, strong) NSMutableArray *attrsArray;
///content高度
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat documentViewY;
@property (nonatomic, assign) CGFloat documentViewH;

@end

@implementation TSUniversalFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    
    self.documentViewY = 0;
    self.documentViewH = 0;
    self.contentHeight = 0;
    [self.attrsArray removeAllObjects];

    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        
        NSIndexPath *section = [NSIndexPath indexPathWithIndex:sectionIndex];
        
        BOOL hasDecorate = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:hasDecorateReusableView:)]) {
            hasDecorate = [self.delegate collectionView:self.collectionView layout:self hasDecorateReusableView:section];
        }
        
        NSString *docorateIden = @"";
        if (self.delegate && [self.delegate respondsToSelector:@selector(docorateViewIdentifier:)]) {
            docorateIden = [self.delegate docorateViewIdentifier:section];
        }
        
        if (docorateIden.length <= 0) {
            docorateIden = @"TSUniversalDecorationView";
        }
        
        if (hasDecorate) {
            NSString *reused = [NSString stringWithFormat:@"%@-%ld",docorateIden,(long)sectionIndex];
            [self registerClass:[NSClassFromString(docorateIden) class]
        forDecorationViewOfKind:reused];
        }
        
        CGFloat spacingWithLastSection = 0;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:spacingWithLastSectionForSectionAtIndex:)]) {
            spacingWithLastSection = [self.delegate collectionView:self.collectionView
                                                            layout:self
                           spacingWithLastSectionForSectionAtIndex:sectionIndex];
        }
        
        self.contentHeight = self.contentHeight + spacingWithLastSection;

        //区头
        [self createSectionHeader:section];
        
        //cell
        [self createCells:section];
        
        //区尾
        [self createSectionFooter:section];
        
        //装饰视图
        [self createDecorateView:section];
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionViewContentHeight:)]) {
        [self.delegate collectionViewContentHeight:self.contentHeight];
    }
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.contentHeight);
}

-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIEdgeInsets sectionEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        sectionEdgeInset = [self.delegate collectionView:self.collectionView
                                                  layout:self
                                  insetForSectionAtIndex:indexPath.section];
    }

    NSInteger itemCountOfSection = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:columnNumberAtSection:)]) {
        itemCountOfSection = [self.delegate collectionView:self.collectionView layout:self columnNumberAtSection:indexPath.section];
    }
    
    CGFloat lineSpacing = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:lineSpacingForSectionAtIndex:)]) {
        lineSpacing = [self.delegate collectionView:self.collectionView layout:self lineSpacingForSectionAtIndex:indexPath.section];
    }
    
    CGFloat interitemSpacing = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:interitemSpacingForSectionAtIndex:)]) {
        interitemSpacing = [self.delegate collectionView:self.collectionView layout:self interitemSpacingForSectionAtIndex:indexPath.section];
    }
    
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    if (itemCountOfSection == 0) {
        itemCountOfSection = 1;
    }
    CGFloat cellWidth = (collectionViewWidth - sectionEdgeInset.left - sectionEdgeInset.right - (itemCountOfSection - 1) * interitemSpacing) / itemCountOfSection;
    
    CGFloat cellHeight = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:heightForRowAtIndexPath:itemWidth:)]) {
        cellHeight = [self.delegate collectionView:self.collectionView layout:self heightForRowAtIndexPath:indexPath itemWidth:cellWidth];
    }
    
    NSInteger rowIndex = indexPath.row;
    NSInteger rowsInSections = [self.collectionView numberOfItemsInSection:indexPath.section];
    
    CGFloat cellX = sectionEdgeInset.left + (cellWidth + interitemSpacing) * (rowIndex % itemCountOfSection);
    CGFloat cellY = 0;
    
    if (itemCountOfSection == 1) {
        cellY = self.contentHeight + lineSpacing;
    } else {
        cellY = self.contentHeight + (cellHeight + lineSpacing) * (rowIndex / itemCountOfSection);
    }
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    
    if (rowIndex == 0) {
        self.documentViewY = cellY;
    }
    
    if (itemCountOfSection == 1) {
        self.contentHeight = CGRectGetMaxY(attributes.frame);
        if (rowIndex == (rowsInSections - 1)) {
            self.documentViewH = self.contentHeight - self.documentViewY;
        }
    }else{
        if (rowIndex == (rowsInSections - 1)) {
            self.contentHeight = CGRectGetMaxY(attributes.frame);
            self.documentViewH = self.contentHeight - self.documentViewY;
        }
    }
    return attributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    UIEdgeInsets sectionEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        sectionEdgeInset = [self.delegate collectionView:self.collectionView
                                                  layout:self
                                  insetForSectionAtIndex:indexPath.section];
    }
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        CGSize headerSize = CGSizeMake(0, 0);
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            headerSize = [self.delegate collectionView:self.collectionView
                                                layout:self
                       referenceSizeForHeaderInSection:indexPath.section];
        }
        self.contentHeight = self.contentHeight + sectionEdgeInset.top;
        CGFloat width = CGRectGetWidth(self.collectionView.frame) - 2 * sectionEdgeInset.left;
        attributes.frame = CGRectMake(sectionEdgeInset.left, self.contentHeight, width, headerSize.height);
        
        self.contentHeight = self.contentHeight + headerSize.height;
        
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter] ){
        CGSize footerSize = CGSizeMake(0, 0);
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            footerSize = [self.delegate collectionView:self.collectionView
                                                layout:self
                       referenceSizeForFooterInSection:indexPath.section];
        }
        CGFloat width = CGRectGetWidth(self.collectionView.frame) - 2 * sectionEdgeInset.left;
        attributes.frame = CGRectMake(sectionEdgeInset.left, self.contentHeight, width, footerSize.height);
        
        self.contentHeight = self.contentHeight + footerSize.height;
        self.contentHeight = self.contentHeight + sectionEdgeInset.bottom;
    }
    return attributes;
}

#pragma mark - Private
-(void)createSectionHeader:(NSIndexPath *)section{
    BOOL hasHeader = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:hasHeaderReusableView:)]) {
        hasHeader = [self.delegate collectionView:self.collectionView layout:self hasHeaderReusableView:section];
    }
    
    if (hasHeader) {
        UICollectionViewLayoutAttributes *headerAttributs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:section];
        [self.attrsArray addObject:headerAttributs];
    }
}

-(void)createCells:(NSIndexPath *)section{
    NSInteger itemCountOfSection = [self.collectionView numberOfItemsInSection:section.section];
    for (NSInteger itemIndex = 0; itemIndex < itemCountOfSection; itemIndex++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:section.section];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attributes];
    }
}

-(void)createSectionFooter:(NSIndexPath *)section{
    BOOL hasFooter = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:hasFooterReusableView:)]) {
        hasFooter = [self.delegate collectionView:self.collectionView layout:self hasFooterReusableView:section];
    }
    
    if (hasFooter) {
        UICollectionViewLayoutAttributes *headerAttributs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:section];
        [self.attrsArray addObject:headerAttributs];
    }
}

-(void)createDecorateView:(NSIndexPath *)section{
    BOOL hasDecorate = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:hasDecorateReusableView:)]) {
        hasDecorate = [self.delegate collectionView:self.collectionView layout:self hasDecorateReusableView:section];
    }

    if (hasDecorate) {
        
        BOOL hasHeader = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:hasHeaderReusableView:)]) {
            hasHeader = [self.delegate collectionView:self.collectionView layout:self hasHeaderReusableView:section];
        }
        
        BOOL hasFooter = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:hasFooterReusableView:)]) {
            hasFooter = [self.delegate collectionView:self.collectionView layout:self hasFooterReusableView:section];
        }
        
        UIEdgeInsets docuEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:insetForDecorateReusableViewAtSection:)]) {
            docuEdgeInset = [self.delegate collectionView:self.collectionView
                                                      layout:self
                    insetForDecorateReusableViewAtSection:section.section];
        }
        
        CGFloat decorationViewY = self.documentViewY;
        CGFloat decorationViewX = docuEdgeInset.left;
        CGFloat decorationViewH = self.documentViewH;
        CGFloat decorationViewW = CGRectGetWidth(self.collectionView.frame) - 2 * decorationViewX;

        NSString *docorateIden = @"";
        if (self.delegate && [self.delegate respondsToSelector:@selector(docorateViewIdentifier:)]) {
            docorateIden = [self.delegate docorateViewIdentifier:section];
        }
        
        if (docorateIden.length <= 0) {
            docorateIden = @"TSUniversalDecorationView";
        }
        
        NSString *reused = [NSString stringWithFormat:@"%@-%ld",docorateIden,(long)section.section];
        UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:reused withIndexPath:section];
        attris.frame = CGRectMake(decorationViewX, decorationViewY, decorationViewW,decorationViewH);
        attris.zIndex = -1;
        [self.attrsArray addObject:attris];
    }
}

#pragma mark - Getter
-(NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


@end
