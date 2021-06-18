//
//  TSHomeViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSHomeViewController.h"
#import "TSCategoryViewController.h"
#import "TSGeneralSearchButton.h"
#import "TSHomePageViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import "KVOController.h"
#import "TSHomePageBaseCell.h"
#import "TSHomePageContainerHeaderView.h"
#import "TSSearchController.h"
#import "TSHomePageContainerCell.h"
#import "YBNestViews.h"
#import "TSHomePageContainerCollectionView.h"
#import "TSEmptyAlertView.h"
#import "TSHomePageLoginBarView.h"

@interface TSHomeViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate, YBNestContainerViewDataSource, YBNestContainerViewDelegate>

/// 搜索按钮
@property(nonatomic, strong) TSGeneralSearchButton *searchButton;
/// 分类按钮
@property(nonatomic, strong) UIButton *categoryButton;

@property(nonatomic, strong) YBNestTableView *tableView;
@property(nonatomic, strong) UIImageView *tableViewBackGroundView;

@property (nonatomic, strong) TSHomePageViewModel *viewModel;

@property (nonatomic, strong) JXCategoryTitleView *segmentHeader;
@property (nonatomic, strong) YBNestContainerView *containerView;
@property (nonatomic, strong) TSHomePageLoginBarView *loginBar;
@end

@implementation TSHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel fetchData];
    [self setupUI];
    [self registCellInfo];
    
    @weakify(self);
    [self.KVOController observe:self.viewModel keyPath:@"dataSource" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.viewModel.dataSource) {
            [self.tableView reloadData];
            self.tableViewBackGroundView.hidden = NO;
            [self configObserve];
        }
    }];
    
    
    [self.view addSubview:self.loginBar];
    self.loginBar.clickBlock = ^{
        
    };
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + 10;
    CGFloat top = self.view.ts_safeAreaInsets.top + 6;
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-49);
        make.top.equalTo(self.view).offset(top);
        make.height.mas_equalTo(32);
    }];
    
    [self.categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchButton.mas_right).offset(8);
        make.centerY.equalTo(self.searchButton);
        make.width.height.mas_equalTo(24);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = KGrayColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchButton.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview:self.tableViewBackGroundView];
    [self.view sendSubviewToBack:self.tableViewBackGroundView];
//    [self.view layoutIfNeeded];
    //    [self loadFixedBackGroundView];
}

- (void)loadFixedBackGroundView{
    UIView *fixedBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    fixedBackGroundView.backgroundColor = KHexColor(@"#FF4D49");
    [self.view addSubview:fixedBackGroundView];
    [self.view sendSubviewToBack:fixedBackGroundView];
}

- (void)fillCustomView{
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.categoryButton];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSHomePageCellViewModel *viewModel = self.viewModel.dataSource[indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:viewModel.model.templateName forIndexPath:indexPath];
    if ([cell isKindOfClass:TSHomePageBaseCell.class]) {
        TSHomePageBaseCell *contentCell = (TSHomePageBaseCell *)cell;
        contentCell.indexPath = indexPath;
        contentCell.cellSuperViewTableView = self.tableView;
        if ([cell isKindOfClass:TSHomePageContainerCell.class]) {
            TSHomePageContainerCell *contentCell = (TSHomePageContainerCell *)cell;
            if (!contentCell.containerView) {
                contentCell.containerView = self.containerView;
                [cell.contentView addSubview:contentCell.containerView];
                [contentCell.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(contentCell.contentView);
                    make.width.equalTo(@(kScreenWidth));
                    make.height.equalTo(@(kScreenHeight - self.searchButton.bottom - self.segmentHeader.height));
                   }];
            }
        }
        
        contentCell.viewModel = viewModel;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TSHomePageCellViewModel *viewModel = self.viewModel.dataSource[section];
    if (viewModel.model.headerTemplateName) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.model.headerTemplateName];
        
        if ([headerView isKindOfClass:TSHomePageContainerHeaderView.class]) {
            TSHomePageContainerHeaderView *header = (TSHomePageContainerHeaderView *)headerView;
            self.segmentHeader = header.segmentHeader;
            self.segmentHeader.delegate = self;
            header.viewModel = viewModel;
        }
        return headerView;
    }
    
    UIView *view = [UIView new];
    UIView *tempView = [UIView new];
    [view addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
        make.height.equalTo(@.2);
    }];
    return view;
}

- (void)registCellInfo {
    [self.tableView registerClass:NSClassFromString(@"TSHomePageBannerCell") forCellReuseIdentifier:@"TSHomePageBanner"];
    [self.tableView registerClass:NSClassFromString(@"TSHomePageCategoryCell") forCellReuseIdentifier:@"TSHomePageCategory"];
    [self.tableView registerClass:NSClassFromString(@"TSHomePageReleaseCell") forCellReuseIdentifier:@"TSHomePageRelease"];
    [self.tableView registerClass:NSClassFromString(@"TSHomePageContainerCell") forCellReuseIdentifier:@"TSHomePageContainer"];
    [self.tableView registerClass:NSClassFromString(@"TSHomePageContainerHeaderView") forHeaderFooterViewReuseIdentifier:@"TSHomePageContainerHeader"];
    [self.tableView registerClass:NSClassFromString(@"TSHomePageReleaseTitleCell") forCellReuseIdentifier:@"TSHomePageReleaseTitle"];
}

#pragma mark - KVO
- (void)configObserve{
    @weakify(self);
    [self.KVOController observe:self.tableView keyPath:@"contentOffset" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        CGRect frame = self.tableViewBackGroundView.frame;
        frame.origin.y = - self.tableView.contentOffset.y;
        self.tableViewBackGroundView.frame = frame;
    }];
    
    [self.KVOController observe:self.viewModel keyPath:@"pageIndex" options:( NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.segmentHeader.selectedIndex != self.viewModel.pageIndex) {
            [self.segmentHeader selectItemAtIndex:self.viewModel.pageIndex];
        }
        if (self.containerView.currentPage != self.viewModel.pageIndex) {
            self.containerView.currentPage = self.viewModel.pageIndex;
        }
    }];
    
}

#pragma mark - Action
- (void)refreshHeaderDataMehtod {
    [self.viewModel fetchData];
}

-(void)searchAction:(TSGeneralSearchButton *)sender{
    [TSSearchController show];
}

-(void)categoryAction:(UIButton *)sender{
    TSCategoryViewController *category = [[TSCategoryViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
}

#pragma mark - Getter
-(TSGeneralSearchButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [TSGeneralSearchButton buttonWithType:UIButtonTypeCustom];
        [_searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

-(UIButton *)categoryButton{
    if (!_categoryButton) {
        _categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryButton setImage:KImageMake(@"mall_home_classification") forState:UIControlStateNormal];
        [_categoryButton setImage:KImageMake(@"mall_home_classification") forState:UIControlStateHighlighted];
        [_categoryButton addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        _categoryButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _categoryButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[YBNestTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderDataMehtod)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = header;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 200;
            _tableView.estimatedSectionHeaderHeight = 20;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (TSHomePageViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [TSHomePageViewModel new];
    }
    return _viewModel;
}

- (UIImageView *)tableViewBackGroundView{
    if (!_tableViewBackGroundView) {
        CGFloat height = kScreenWidth/375 * 205;
        _tableViewBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, height)];
        _tableViewBackGroundView.image = [UIImage imageNamed:@"mall_home_bg"];
        _tableViewBackGroundView.hidden = YES;
    }
    return _tableViewBackGroundView;
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
    return self.viewModel.containerViewModel.segmentHeaderDatas.count;
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
        TSHomePageContainerGroup *group = self.viewModel.containerViewModel.segmentHeaderDatas[self.segmentHeader.selectedIndex];
        [self.viewModel.containerViewModel loadData:group callBack:^(NSArray * _Nonnull list) {
            collectionView.items = list;
            [collectionView reloadData];
            if (list.count < group.totalNum) {
                [collectionView.collectionView.mj_footer resetNoMoreData];
            } else {
                [collectionView.collectionView.mj_footer endRefreshingWithNoMoreData];
            }

        }];
    }];
    [self.viewModel.containerViewModel loadData:self.viewModel.containerViewModel.segmentHeaderDatas[self.segmentHeader.selectedIndex] callBack:^(NSArray * _Nonnull list) {
        collectionView.items = list;
        [collectionView reloadData];
        [self showEmptyView:collectionView];
    }];
    
    return collectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.containerView mainScrollViewDidScroll:scrollView];
}

- (void)yb_nestContainerView:(YBNestContainerView *)view pageChanged:(NSInteger)page{
    self.viewModel.pageIndex = page;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    self.viewModel.pageIndex = index;
}

- (void)showEmptyView:(UIView *)view{
    if (self.viewModel.containerViewModel.currentGroup.list.count != 0) {
        [TSEmptyAlertView hideInView:view];
        return ;
    }
    TSEmptyAlertView *alertView = [TSEmptyAlertView new];
    alertView.alertInfo(@"抱歉，没有找到商品哦～", @"重试");
    [view addSubview:alertView];
    alertView.frame = view.bounds;
    alertView.alertImage(@"homePage_container_error");
    alertView.show(view, ^{
        
    });
}

- (TSHomePageLoginBarView *)loginBar{
    if (!_loginBar) {
        _loginBar = [[TSHomePageLoginBarView alloc] initWithFrame:CGRectMake(16, kScreenHeight - 12 - 44 - GK_TABBAR_HEIGHT, kScreenWidth - 32, 44)];
    }
    return _loginBar;
}
@end
