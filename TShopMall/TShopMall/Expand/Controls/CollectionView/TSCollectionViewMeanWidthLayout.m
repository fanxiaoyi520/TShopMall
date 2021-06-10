//
//  TSCollectionViewMeanWidthLayout.m
//  
//
//  Created by sway on 2020/9/17.
//

#import "TSCollectionViewMeanWidthLayout.h"

@interface TSCollectionViewMeanWidthSectionLayout()
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
@end

@implementation TSCollectionViewMeanWidthSectionLayout
- (void)setRows:(NSInteger)rows{
    _rows = rows;
    self.scrollDirection = rows?UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
  
}
@end

@interface TSCollectionViewMeanWidthLayout()
@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, assign) CGFloat totalwidth;

@property (nonatomic, strong) NSMutableArray *attributesArrayM;
@property (nonatomic, strong) NSMutableArray *secionLayouts;
@end

@implementation TSCollectionViewMeanWidthLayout

- (instancetype)initWithColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding
{
    if (self = [super init]) {
        _secionLayouts = [NSMutableArray array];
        TSCollectionViewMeanWidthSectionLayout  *layout = [TSCollectionViewMeanWidthSectionLayout new];
        layout.columnSpacing = columnSpacing;
        layout.rowSpacing = rowSpacing;
        layout.columns = columns;
        layout.rows = rows;
        layout.padding = padding;
        layout.itemsHeight = height;
        layout.headerHeight = 0;
        layout.footerHeight = 0;
        layout.scrollDirection = rows?UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
        [_secionLayouts addObject:layout];
    }
    return self;
}

- (instancetype)initWithColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemsSize:(CGSize)size rows:(int)rows padding:(UIEdgeInsets)padding{
    if (self = [super init]) {
        _secionLayouts = [NSMutableArray array];
        TSCollectionViewMeanWidthSectionLayout  *layout = [TSCollectionViewMeanWidthSectionLayout new];
        layout.columnSpacing = columnSpacing;
        layout.rowSpacing = rowSpacing;
        layout.rows = rows;
        layout.columns = 0;
        layout.padding = padding;
        layout.itemsHeight = size.height;
        layout.itemsWidth = size.width;
        layout.headerHeight = 0;
        layout.footerHeight = 0;
        layout.scrollDirection = rows?UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
        [_secionLayouts addObject:layout];
    }
    return self;
}

-(void)prepareLayout {
    [super prepareLayout];
    
    self.totalHeight = 0;
    self.totalwidth = 0;
    
    NSMutableArray *attributesArr = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    TSCollectionViewMeanWidthSectionLayout  *layout =  _secionLayouts.firstObject;
    _secionLayouts = [NSMutableArray array];

    for (int i = 0; i < sectionCount; i++) {

        [_secionLayouts addObject:layout];
        
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexP];
        if (attr) {
            [attributesArr addObject:attr];
        }
       
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArr addObject:attrs];
        }
        UICollectionViewLayoutAttributes *attr1 = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexP];
        if (attr1) {
            [attributesArr addObject:attr1];
        }
    }
    self.attributesArrayM = [NSMutableArray arrayWithArray:attributesArr];
}


- (CGSize)collectionViewContentSize
{

    return CGSizeMake(self.totalwidth, self.totalHeight);
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat height = 0;
    TSCollectionViewMeanWidthSectionLayout  *layout = _secionLayouts[indexPath.section];

    if (_updateSectionLayout) {
        _updateSectionLayout(layout,indexPath);
    }
    
    if (elementKind == UICollectionElementKindSectionHeader) {
      height = layout.headerHeight;
    } else {
        height = layout.footerHeight;
    }
    
    layoutAttrs.frame = CGRectMake(0, self.totalHeight, self.collectionView.frame.size.width, height);
    self.totalHeight += height;
    return layoutAttrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCollectionViewMeanWidthSectionLayout  *layout = _secionLayouts[indexPath.section];
    if (_updateSectionLayout) {
        _updateSectionLayout(layout,indexPath);
    }
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger item = indexPath.row;
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:indexPath.section];

    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat itemWidth = 0.0;
        NSInteger columns = 0;
        if (layout.columns) {
            // 有设置列数
            columns = layout.columns;
            itemWidth = ((self.collectionView.frame.size.width - layout.padding.left - layout.padding.right) - ((columns-1) * layout.columnSpacing)) / columns;

        }else{
            if (layout.itemsWidth > 0) {
                itemWidth = layout.itemsWidth;
                // 通过itemsWidth得出列数
                columns = (self.collectionView.frame.size.width - layout.padding.left - layout.padding.right + layout.columnSpacing) / (itemWidth + layout.columnSpacing);
            }else{
                NSAssert(layout.columns != 0, @"columns不能为0！");
            }
        }
        
        // 当前item所在的页
        NSInteger x = item % columns;
        NSInteger y = item / columns;
    
        // 计算出item的坐标
        CGFloat itemX = layout.padding.left + (itemWidth + layout.columnSpacing) * x;
        CGFloat itemY = layout.padding.top + (layout.itemsHeight + layout.rowSpacing) * y  + self.totalHeight;
        
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, layout.itemsHeight);
        
        if (item == itemTotalCount - 1) {
            self.totalHeight = itemY + layout.itemsHeight + layout.padding.bottom;
        }
        return  attributes;
    }
    else{
        CGFloat itemWidth = 0.0;
        NSInteger columns = 0;
        if (layout.columns) {
            // 有设置列数
            columns = layout.columns;
            itemWidth = ((self.collectionView.frame.size.width - layout.padding.left - layout.padding.right) - ((columns-1) * layout.columnSpacing)) / columns;

        }else{
            if (layout.itemsWidth > 0) {
                itemWidth = layout.itemsWidth;
                // 通过itemsWidth得出列数
                columns = (self.collectionView.frame.size.width - layout.padding.left - layout.padding.right + layout.columnSpacing) / (itemWidth + layout.columnSpacing);
            }else{
                NSAssert(layout.columns != 0, @"columns不能为0！");
            }
        }
        
//        // 计算出item的宽度
//        CGFloat itemWidth = (self.collectionView.frame.size.width - layout.padding.left - layout.columns * layout.columnSpacing) / layout.columns;

        // 理论上每页展示的item数目
        NSInteger itemCount = layout.rows * columns;
        // 余数（用于确定最后一页展示的item个数）
        NSInteger remainder = itemTotalCount % itemCount;
        // 除数（用于判断页数）
        NSInteger pageNumber = itemTotalCount / itemCount;
        // 总个数小于self.rows * self.columns
        if (itemTotalCount <= itemCount) {
            pageNumber = 1;
        }else {
            if (remainder == 0) {
                pageNumber = pageNumber;
            }else {
                // 余数不为0,除数加1
                pageNumber = pageNumber + 1;
            }
        }
    
        CGFloat width = 0;
        // 考虑特殊情况(当item的总个数不是self.rows * self.columns的整数倍,并且余数小于每行展示的个数的时候)
        if (pageNumber > 1 && remainder != 0 && remainder < columns) {
            width = layout.padding.left + (pageNumber - 1) * columns * (itemWidth + layout.columnSpacing) + remainder * itemWidth + (remainder - 1)*layout.columnSpacing + layout.padding.right;
        }else {
            width = layout.padding.left + pageNumber * columns * (itemWidth + layout.columnSpacing) - layout.columnSpacing + layout.padding.right;
        }
        
        //判断section的需要宽度，取最大宽度
        if (self.totalwidth < width) {
            self.totalwidth = width;
        }
       
        // 当前item所在的页
        pageNumber = item / (layout.rows * columns);
        NSInteger x = item % columns + pageNumber * columns;
        NSInteger y = item / columns - pageNumber * layout.rows;
    
        // 计算出item的坐标
        CGFloat itemX = layout.padding.left + (itemWidth + layout.columnSpacing) * x;
        CGFloat itemY = layout.padding.top + (layout.itemsHeight + layout.rowSpacing) * y + self.totalHeight;
    
        // 每个item的frame
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, layout.itemsHeight);
        if (item == itemTotalCount - 1) {
            self.totalHeight += layout.itemsHeight * layout.rows + layout.padding.top + layout.padding.bottom + (layout.rows-1)*layout.rowSpacing;
        }
       
        return attributes;
    }
}
/** 返回collectionView视图中所有视图的属性数组 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArrayM;
}

#pragma mark - Lazy
- (NSMutableArray *)attributesArrayM
{

    if (!_attributesArrayM) {
        _attributesArrayM = [NSMutableArray array];
    }
    return _attributesArrayM;
}
    
@end
