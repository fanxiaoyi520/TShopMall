//
//  TSHomePageContainerScrollView.m
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import "TSHomePageContainerScrollView.h"
#import "KVOController.h"
#import "TSGridButtonCollectionView.h"
#import "TSHomePageContainerCollectionView.h"

@interface TSHomePageContainerScrollView()<UIScrollViewDelegate>

@end

@implementation TSHomePageContainerScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;

    }
    return self;
}

- (void)loadPageContainer:(NSInteger)headerCount{
    for (int i = 0; i < headerCount; i ++) {
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 16, 16, 16);
        
        TSHomePageContainerCollectionView *collectionView =  [[TSHomePageContainerCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:8 rowSpacing:8 itemsHeight:282 rows:0 columns:2 padding:padding clickedBlock:^(TSProductBaseModel *selectItem, NSInteger index) {
            NSLog(@"uri:%@", selectItem.uuid);
        }];
        collectionView.collectionView.backgroundColor = KGrayColor;
        collectionView.collectionView.scrollEnabled = NO;
        [self addSubview:collectionView];
        [self.collectionViewGroup addObject:collectionView];
    }

    if (self.collectionViewGroup.count > 1) {
        [self.collectionViewGroup mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        // 设置array的垂直方向的约束
        [self.collectionViewGroup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(kScreenWidth);
        }];
    }
}

//- (void)setItems:(NSArray<TSHomePageContainerModel *> *)items{
//    _items = items;
//    TSHomePageContainerCollectionView *collectionView = self.collectionViewGroup[_currentPage];
//    collectionView.items = items;
//    [collectionView reloadData];
//    
//}

- (void)updatePageContainerWithItems:(NSArray<TSProductBaseModel *> * )items pageIndex:(NSInteger)pageIndex{    TSHomePageContainerCollectionView *collectionView = self.collectionViewGroup[pageIndex];
    collectionView.items = items;
    [collectionView reloadData];
}


- (NSMutableArray *)collectionViewGroup{
    if (!_collectionViewGroup) {
        _collectionViewGroup = @[].mutableCopy;
    }
    return _collectionViewGroup;
}

@end
