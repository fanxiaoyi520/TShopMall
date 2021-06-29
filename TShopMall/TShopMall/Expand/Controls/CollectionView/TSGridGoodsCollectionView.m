//
//  TSGridGoodsCollectionView.m
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import "TSGridGoodsCollectionView.h"
#import "TSGridGoodsCollectionViewCell.h"
#import "TSRecomendGoodsProtocol.h"
#import "TSOneRowsGoodsCollectionViewCell.h"

@interface TSGridGoodsCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) TSCollectionViewMeanWidthLayout *layout;
@end

@implementation TSGridGoodsCollectionView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding clickedBlock:(nonnull TSGridGoodsCollectionViewDidSelectedBlock)clickedBlock
{
    if (self = [super initWithFrame:frame]) {
        _items = items;
        _layout = [[TSCollectionViewMeanWidthLayout alloc] initWithColumnSpacing:columnSpacing rowSpacing:rowSpacing itemsHeight:height rows:rows columns:columns padding:padding];
        self.clickedBlock = clickedBlock;

        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)reloadData
{
    [_collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCollectionViewMeanWidthSectionLayout *layout = _layout.secionLayouts.firstObject;
    UICollectionViewCell *cell;
    if (layout.columns == 1) {
        TSOneRowsGoodsCollectionViewCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSOneRowsGoodsCollectionViewCell" forIndexPath:indexPath];
        id<TSRecomendGoodsProtocol> item = self.items[indexPath.row];
        contentCell.item = item;
        cell = contentCell;
    }else{
        TSGridGoodsCollectionViewCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSGridGoodsCollectionViewCell" forIndexPath:indexPath];
        id<TSRecomendGoodsProtocol> item = self.items[indexPath.row];
        contentCell.item = item;
        cell = contentCell;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<TSRecomendGoodsProtocol> item = self.items[indexPath.row];
    
    if (_clickedBlock) {
        self.clickedBlock(item,indexPath.row);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark setter & getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TSGridGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"TSGridGoodsCollectionViewCell"];
        [_collectionView registerClass:[TSOneRowsGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"TSOneRowsGoodsCollectionViewCell"];

    }
    return _collectionView;
}
@end
