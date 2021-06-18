//
//  TSHomePageContainerCollectionView.m
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import "TSHomePageContainerCollectionView.h"
#import "TSCollectionViewMeanWidthLayout.h"
#import "TSHomePageContainerCollectionViewCell.h"
#import "TSProductBaseModel.h"

@interface TSHomePageContainerCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) TSCollectionViewMeanWidthLayout *layout;

@end
@implementation TSHomePageContainerCollectionView
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding clickedBlock:(TSHomePageContainerCollectionViewDidSelectedBlock)clickedBlock
{
    if (self = [super initWithFrame:frame]) {
        _items = items;
        _layout = [[TSCollectionViewMeanWidthLayout alloc] initWithColumnSpacing:columnSpacing rowSpacing:rowSpacing itemsHeight:height rows:rows columns:columns padding:padding];
        self.clickedBlock = clickedBlock;
//        self.delegate = self;
//        self.dataSource = self;
//        self.showsVerticalScrollIndicator = NO;
//        self.showsHorizontalScrollIndicator = NO;
//        [self registerClass:[TSHomePageContainerCollectionViewCell class] forCellWithReuseIdentifier:@"TSHomePageContainerCollectionViewCell"];

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
    [_collectionView layoutIfNeeded];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_collectionView.contentSize.height));
    }];
    NSLog(@"collectionView.contentSize.height1:%f",_collectionView.contentSize.height);
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
    
    TSHomePageContainerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSHomePageContainerCollectionViewCell" forIndexPath:indexPath];

    TSProductBaseModel *item = self.items[indexPath.row];
    cell.item = item;
//        if (item.isSelected) {
//            [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//        }
        return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSProductBaseModel *item = self.items[indexPath.row];
//    if (item.isSelected) {
//        if(_clickedBlock) {
//            self.clickedBlock(item, indexPath.row);
//        }
//        return;
//    }
//
//    item.isSelected = !item.isSelected;
    
    if (_clickedBlock) {
        self.clickedBlock(item,indexPath.row);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    TSProductBaseModel *item = self.items[indexPath.row];
//    item.isSelected = !item.isSelected;
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
        [_collectionView registerClass:[TSHomePageContainerCollectionViewCell class] forCellWithReuseIdentifier:@"TSHomePageContainerCollectionViewCell"];
    }
    return _collectionView;
}
@end
