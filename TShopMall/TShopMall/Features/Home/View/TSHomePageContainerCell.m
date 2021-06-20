//
//  TSHomePageContainerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageContainerCell.h"
#import "TSHomePageContainerViewModel.h"
#import "TSHomePageContainerCollectionView.h"
#import "YBNestViews.h"
#import <MJRefresh/MJRefresh.h>
#import "TSEmptyAlertView.h"

@interface TSHomePageContainerCell()<YBNestContainerViewDataSource, YBNestContainerViewDelegate>
@property(nonatomic, strong) TSHomePageContainerViewModel *containerViewModel;

@end
@implementation TSHomePageContainerCell

- (void)setupUI{
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(100));
       }];
}

- (void)setContainerHeight:(CGFloat)containerHeight{
    _containerHeight = containerHeight;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(containerHeight));
       }];
}

- (void)showEmptyView:(TSHomePageContainerCollectionView *)view{
    if (view.items.count != 0) {
        [TSEmptyAlertView hideInView:view];
        return ;
    }
    
    TSEmptyAlertView.new.alertInfo(@"抱歉，没有找到商品哦～", @"重试").show(view, ^{
        [self reloadContainerCollectionView:view];
    });
}

- (void)showErrorView:(TSHomePageContainerCollectionView *)view{
    @weakify(self);
    TSEmptyAlertView *alertView = [TSEmptyAlertView new];
    alertView.alertInfo(@"服务器开小差了", @"刷新");
    [view addSubview:alertView];
    alertView.frame = view.bounds;
    alertView.alertImage(@"homePage_container_error");
    alertView.show(view, ^{
        @strongify(self);
        [self reloadContainerCollectionView:view];
    });
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    
    if (_containerViewModel != viewModel && _containerViewModel != nil) {
        [self.containerView reloadData];
    }
    
    [super setViewModel:viewModel];
    self.containerViewModel = (TSHomePageContainerViewModel *)viewModel;
    @weakify(self);
    [self.KVOController observe:self.containerViewModel keyPath:@"pageIndex" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.containerView.currentPage != self.containerViewModel.pageIndex) {
            self.containerView.currentPage = self.containerViewModel.pageIndex;
        }
        
    }];
    
}

- (YBNestContainerView *)containerView {
    if (!_containerView) {
        _containerView = [YBNestContainerView viewWithDataSource:self];
        _containerView.delegate = self;
    }
    return _containerView;
}

#pragma mark - <YBNestContainerViewDataSource>

- (NSInteger)yb_numberOfContentsInNestContainerView:(YBNestContainerView *)view {
    return self.containerViewModel.segmentHeaderDatas.count;
}

- (id<YBNestContentProtocol>)yb_nestContainerView:(YBNestContainerView *)view contentAtPage:(NSInteger)page{
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 16, 16, 16);
   
    TSHomePageContainerCollectionView *collectionView =  [[TSHomePageContainerCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:8 rowSpacing:8 itemsHeight:282 rows:0 columns:2 padding:padding clickedBlock:^(TSProductBaseModel *selectItem, NSInteger index) {
        NSLog(@"uri:%@", selectItem.uuid);
    }];
    collectionView.collectionView.backgroundColor = KGrayColor;
    @weakify(self);
    collectionView.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self reloadContainerCollectionView:collectionView];

    }];
    [self reloadContainerCollectionView:collectionView];
    
    return collectionView;
}

- (void)reloadContainerCollectionView:(TSHomePageContainerCollectionView *)collectionView{
    TSHomePageContainerGroup *group = self.containerViewModel.segmentHeaderDatas[self.containerViewModel.pageIndex];
    [self.containerViewModel loadData:group callBack:^(NSArray * _Nonnull list, NSError * _Nonnull error) {
        if (!error) {
            collectionView.items = list;
            [collectionView reloadData];
            if (list.count < group.totalNum) {
                [collectionView.collectionView.mj_footer resetNoMoreData];
            } else {
                [collectionView.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            [self showEmptyView:collectionView];
        }
        else{
            [self showErrorView:collectionView];
        }
    }];
}

#pragma mark - nestContainerViewDelegate
- (void)yb_nestContainerView:(YBNestContainerView *)view pageChanged:(NSInteger)page{
    self.containerViewModel.pageIndex = page;
}

@end

