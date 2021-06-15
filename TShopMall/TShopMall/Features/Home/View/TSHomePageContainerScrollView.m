//
//  TSHomePageContainerScrollView.m
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import "TSHomePageContainerScrollView.h"
#import "KVOController.h"
#import "TSGridButtonCollectionView.h"
#import "UIView+TSFrameValueBlock.h"
#import "TSHomePageContainerCollectionView.h"

@interface TSHomePageContainerScrollView()<UIScrollViewDelegate>
@property(nonatomic, strong) NSMutableArray *collectionViewGroup;

@end

@implementation TSHomePageContainerScrollView
- (void)dealloc
{

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}

- (void)setViewModel:(TSHomePageContainerViewModel *)viewModel{
    _viewModel = viewModel;
    @weakify(self);
    [self.KVOController unobserveAll];
    [self.KVOController observe:viewModel.containerHeaderViewModel keyPath:@"currentIndex" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.collectionViewGroup.count == 0) {
            [self loadPageContainer];
        }
        [self getPageContainerDataWithGroupIndex:self.viewModel.containerHeaderViewModel.currentIndex];
    }];
    
    [self.KVOController observe:viewModel keyPath:@"allGroupDict" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew  block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        TSHomePageContainerGroup *currentGroup = self.viewModel.containerHeaderViewModel.segmentHeaderDatas[self.viewModel.containerHeaderViewModel.currentIndex];

        NSArray <TSHomePageContainerModel *> *items =  self.viewModel.allGroupDict[currentGroup.groupId];
        if (items.count) {
            [self updatePageContainerWithGroups:items];
            [self layoutIfNeeded];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.contentSize.height));
            }];
            if (self.frameValueBlock) {
                self.frameValueBlock();
            }
        }
      }];
}

- (void)getPageContainerDataWithGroupIndex:(NSInteger)currentIndex{
    TSHomePageContainerGroup *group = self.viewModel.containerHeaderViewModel.segmentHeaderDatas[self.viewModel.containerHeaderViewModel.currentIndex];

    NSArray <TSHomePageContainerModel *> *items =  self.viewModel.allGroupDict[group.groupId];

    if (!items.count) {
        [self.viewModel getPageContainerDataWithStartIndex:items.count count:10 group:group];
    }
}

- (void)loadPageContainer{
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < self.viewModel.containerHeaderViewModel.segmentHeaderDatas.count; i ++) {
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 16, 16, 16);
        
        TSHomePageContainerCollectionView *collectionView =  [[TSHomePageContainerCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:8 rowSpacing:8 itemsHeight:282 rows:0 columns:2 padding:padding clickedBlock:^(TSHomePageContainerModel *selectItem, NSInteger index) {
            NSLog(@"uri:%@", selectItem.uri);
        }];
        collectionView.collectionView.backgroundColor = KGrayColor;
        [weakSelf addSubview:collectionView];
        [weakSelf.collectionViewGroup addObject:collectionView];
    }

    if (weakSelf.collectionViewGroup.count > 1) {
        [weakSelf.collectionViewGroup mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        // 设置array的垂直方向的约束
        [weakSelf.collectionViewGroup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
            make.width.mas_equalTo(kScreenWidth);
        }];
    }
}

- (void)updatePageContainerWithGroups:(NSArray<TSHomePageContainerModel *> *)items
{
    TSHomePageContainerCollectionView *collectionView = self.collectionViewGroup[self.viewModel.containerHeaderViewModel.currentIndex];
    collectionView.items = items;
    [collectionView reloadData];
    
}

- (NSMutableArray *)collectionViewGroup{
    if (!_collectionViewGroup) {
        _collectionViewGroup = @[].mutableCopy;
    }
    return _collectionViewGroup;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = (int)((scrollView.contentOffset.x + scrollView.width / 2) / scrollView.width);
    NSLog(@"currentPage %ld",currentPage);
    if (currentPage == self.viewModel.containerHeaderViewModel.currentIndex) {
        return;
    }
   self.viewModel.containerHeaderViewModel.currentIndex = currentPage;
}
@end
