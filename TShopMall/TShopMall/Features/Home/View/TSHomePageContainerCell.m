//
//  TSHomePageContainerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageContainerCell.h"
#import "TSCategoryGroupViewModel.h"
#import "TSHomePageContainerCollectionView.h"
#import "YBNestViews.h"
#import <MJRefresh/MJRefresh.h>
#import "TSEmptyAlertView.h"
#import "RefreshGifFooter.h"


@interface TSHomePageContainerCell()<YBNestContainerViewDataSource, YBNestContainerViewDelegate>
@property(nonatomic, strong) TSCategoryGroupViewModel *containerViewModel;

@end
@implementation TSHomePageContainerCell

- (void)setupUI{
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(100)).priorityLow();
       }];
}

- (void)setContainerHeight:(CGFloat)containerHeight{
    _containerHeight = containerHeight;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(containerHeight)).priorityLow();;
       }];
}

- (void)showEmptyView:(TSHomePageContainerCollectionView *)view{
    view.collectionView.mj_footer.hidden = !view.items.count;

    if (view.items.count != 0) {
        [TSEmptyAlertView hideInView:view];
        return ;
    }
    TSEmptyAlertView.new.alertInfo(@"抱歉，没有找到商品哦～", @"重试").show(view, @"center", ^{
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
    alertView.show(view, @"center", ^{
        @strongify(self);
        [self reloadContainerCollectionView:view];
    });
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    
    if (_containerViewModel != viewModel && _containerViewModel != nil) {
        [self.containerView reloadData];
    }
    
    [super setViewModel:viewModel];
    self.containerViewModel = (TSCategoryGroupViewModel *)viewModel;
    @weakify(self);
    [self.KVOController observe:self.containerViewModel keyPath:@"pageIndex" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.containerView.currentPage != self.containerViewModel.pageIndex) {
            self.containerView.currentPage = self.containerViewModel.pageIndex;
        }
        
    }];
    
    [self.KVOController observe:self.containerViewModel keyPath:@"segmentHeaderDatas" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.containerViewModel.segmentHeaderDatas.count) {
            [self.containerView reloadData];
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
        
        [[TSServicesManager sharedInstance].uriHandler openURI:[NSString stringWithFormat:@"page://quote/productDetail?uuid=%@", selectItem.uuid]];
        
        NSLog(@"uri:%@", selectItem.uuid);
    }];
    collectionView.tag = page;
    collectionView.collectionView.backgroundColor = KGrayColor;
    @weakify(self);
    collectionView.collectionView.mj_footer = [RefreshGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self reloadContainerCollectionView:collectionView];

    }];
    collectionView.collectionView.mj_footer.hidden = YES;
    
    [self reloadContainerCollectionView:collectionView];
    
    return collectionView;
}

- (void)reloadContainerCollectionView:(TSHomePageContainerCollectionView *)collectionView{
    
    [Popover popProgressOnWindowWithProgressModel:[Popover defaultConfig] appearBlock:^(id frontView) {
        
    }];
    
    TSCategoryGroup *group = self.containerViewModel.segmentHeaderDatas[collectionView.tag];
    [self.containerViewModel loadData:group success:^(NSArray * _Nonnull list) {
        [Popover removePopoverOnWindow];
        
        collectionView.items = list;
        [collectionView reloadData];
        if (list.count < group.totalNum) {
            [collectionView.collectionView.mj_footer resetNoMoreData];
        } else {
            [collectionView.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showEmptyView:collectionView];
    
    } failure:^(NSError * _Nonnull error) {
        [Popover removePopoverOnWindow];
        [self showErrorView:collectionView];
    }];
}

#pragma mark - nestContainerViewDelegate
- (void)yb_nestContainerView:(YBNestContainerView *)view pageChanged:(NSInteger)page{
    self.containerViewModel.pageIndex = page;
}

@end

