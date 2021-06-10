//
//  TSCollectionViewLineWrapLayout.m
//
//
//  Created by sway on 2020/10/16.
//
#import "TSCollectionViewLineWrapLayout.h"
@interface TSCollectionViewLineWrapLayout()
// item的高度
@property (nonatomic, assign) CGFloat itemsHeight;
// 临时保存item的总宽度
@property (nonatomic, assign) CGFloat columnWidth;
// 记录一共有多少行
@property (nonatomic, assign) NSInteger columnNumber;

// 保存每个item的X值
@property (nonatomic, assign) CGFloat xForItemOrigin;
// 保存每个item的Y值
@property (nonatomic, assign) CGFloat yForItemOrigin;

@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, assign) CGFloat totalwidth;
@property (nonatomic, strong) NSMutableArray *attributesArrayM;
@property (nonatomic) UICollectionViewScrollDirection direction;
@end

@implementation TSCollectionViewLineWrapLayout
- (instancetype)initWithColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemsHeight:(CGFloat)height padding:(UIEdgeInsets)padding isVertical:(BOOL)isVertical
{
    if (self = [super init]) {
        self.itemsHeight = height;
        self.minimumLineSpacing = rowSpacing;
        self.minimumInteritemSpacing = columnSpacing;
        self.sectionInset = padding;
        _direction = isVertical?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.columnWidth = self.sectionInset.left;
    self.columnNumber = 0;
    self.xForItemOrigin = self.sectionInset.left;
    self.yForItemOrigin = self.sectionInset.top;
    
    NSMutableArray *attributesArr = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];

    for (int i = 0; i < sectionCount; i++) {

        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArr addObject:attrs];
        }
    }
    
    self.attributesArrayM = [NSMutableArray arrayWithArray:attributesArr];
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArrayM;
}

- (CGSize)collectionViewContentSize
{

    return CGSizeMake(self.totalwidth, self.totalHeight);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 获取item的高
    CGFloat itemWidth = currentItemAttributes.size.width;
    NSInteger item = indexPath.row;
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:indexPath.section];

    if (_direction == UICollectionViewScrollDirectionVertical) {
        //之前item的宽总和 + 当前item的宽 + 间距 < 屏幕总款
        if (self.columnWidth + itemWidth + self.minimumInteritemSpacing < self.collectionView.frame.size.width) {
            // 设置x
            self.xForItemOrigin = self.columnWidth;
            self.columnWidth += itemWidth + self.minimumInteritemSpacing;
        } else {
            self.xForItemOrigin = self.sectionInset.left;
            // 如果宽度超过屏幕从新计算宽度
            self.columnWidth = self.sectionInset.left + itemWidth + self.minimumInteritemSpacing;
            self.columnNumber++;
        }
    }
    else{
        self.xForItemOrigin = self.columnWidth;
        self.columnWidth += itemWidth + self.minimumInteritemSpacing;
//        NSLog(@"itemWidth:%f  %ld",itemWidth, item);
    }
    
    // 计算是第几行 乘以高度
    self.yForItemOrigin = self.sectionInset.top + (self.itemsHeight + self.minimumLineSpacing) * self.columnNumber;
    // 设置frame
    currentItemAttributes.frame = CGRectMake(self.xForItemOrigin, self.yForItemOrigin, itemWidth, self.itemsHeight);
    if (item == itemTotalCount - 1) {
        self.totalHeight = self.yForItemOrigin + self.itemsHeight + self.sectionInset.bottom;
        self.totalwidth = self.xForItemOrigin + itemWidth + self.sectionInset.right;
    }
    
    return currentItemAttributes;
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
