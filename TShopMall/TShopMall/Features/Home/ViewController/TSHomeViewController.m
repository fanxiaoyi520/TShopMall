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
#import "TSHomePageBaseCell.h"
#import "TSHomePageContainerHeaderView.h"
#import "TSSearchController.h"
#import "TSHomePageContainerCell.h"
#import "YBNestViews.h"
#import "TSHomePageLoginBarView.h"
#import "TSHomePagePerchView.h"

#import "TSProductDetailController.h"

#define tableViewBackGroundViewHeight 204.0

@interface TSHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

/// 搜索按钮
@property(nonatomic, strong) TSGeneralSearchButton *searchButton;
/// 分类按钮
@property(nonatomic, strong) UIButton *categoryButton;

@property(nonatomic, strong) YBNestTableView *tableView;
//背景图
@property(nonatomic, strong) UIImageView *tableViewBackGroundView;
//导航栏背景图
@property(nonatomic, strong) UIView * navBackgroundView;
@property (nonatomic, strong) TSHomePageViewModel *viewModel;

@property (nonatomic, strong) YBNestContainerView *containerView;
@property (nonatomic, strong) TSHomePageLoginBarView *loginBar;
//缺省图
@property (nonatomic, strong) TSHomePagePerchView *perchView;

@end

@implementation TSHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.gk_navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel fetchData];
    [self registCellInfo];

    @weakify(self);
    [self.KVOController observe:self.viewModel keyPath:@"dataSource" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.viewModel.dataSource) {
            self.view.backgroundColor = KGrayColor;
            if (!self.perchView.hidden) {
                self.perchView.hidden = YES;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self configObserve];
        }
    }];

    if ([TSUserLoginManager shareInstance].state == None) {
        [self.view addSubview:self.loginBar];
        self.loginBar.clickBlock = ^{
            [[TSUserLoginManager shareInstance] startLogin];
        };
    }
    
}

#pragma mark - UI
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
    
    [self.perchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchButton.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchButton.mas_bottom).offset(11);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.navBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.tableView.mas_top);

    }];
}

- (void)fillCustomView{
    self.view.backgroundColor = KWhiteColor;

    [self.view addSubview:self.tableViewBackGroundView];
    [self.view addSubview:self.navBackgroundView];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.categoryButton];
    [self.view addSubview:self.perchView];
    [self.view addSubview:self.tableView];
    [self.perchView configPerch];
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
            if (contentCell.containerHeight == 0) {
                contentCell.containerHeight = kScreenHeight - self.navBackgroundView.bottom - 48;
            }
            self.containerView = contentCell.containerView;
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
            header.viewModel = (TSHomePageContainerViewModel *)viewModel;
        }
        return headerView;
    }
    
    UIView *view = [UIView new];
    UIView *tempView = [UIView new];
    [view addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
        make.height.equalTo(@.2).priorityLow();
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
        UIImage *image = self.tableViewBackGroundView.image;
        CGFloat height = kScreenWidth/image.size.width * image.size.height;
        CGFloat y = -((image.size.height - tableViewBackGroundViewHeight)/image.size.height * height);
        CGRect frame = CGRectMake(0, y - self.tableView.contentOffset.y, self.view.width, height);
        self.tableViewBackGroundView.frame = frame;
        self.navBackgroundView.backgroundColor = self.tableView.contentOffset.y > 0?KHexColor(@"FF4D49"):[UIColor clearColor];
    }];
    
}

#pragma mark - Noti
- (void)loginStateDidChanged:(NSNotification *)noti{
    self.loginBar.hidden = ![noti.object intValue];
    [self.viewModel fetchData];
}

#pragma mark - Action
- (void)refreshHeaderDataMehtod {
    [self.viewModel fetchData];
}

-(void)searchAction:(TSGeneralSearchButton *)sender{
    [TSSearchController show];
}

-(void)categoryAction:(UIButton *)sender{
    [[TSUserInfoManager userInfo] clearUserInfo];
    return;
    
    TSProductDetailController *con = [[TSProductDetailController alloc] init];
//    TSCategoryViewController *category = [[TSCategoryViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - Getter
- (TSHomePageLoginBarView *)loginBar{
    if (!_loginBar) {
        _loginBar = [[TSHomePageLoginBarView alloc] initWithFrame:CGRectMake(16, kScreenHeight - 12 - 44 - GK_TABBAR_HEIGHT, kScreenWidth - 32, 44)];
    }
    return _loginBar;
}

- (TSHomePagePerchView *)perchView{
    if (!_perchView) {
        _perchView = [[TSHomePagePerchView alloc] initWithFrame:CGRectZero];
    }
    return _perchView;
}

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
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
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
        _tableViewBackGroundView = [[UIImageView alloc] init];
        _tableViewBackGroundView.image = [UIImage imageNamed:@"mall_home_bg1"];
    }
    return _tableViewBackGroundView;
}

- (UIView *)navBackgroundView{
    if (!_navBackgroundView) {
        _navBackgroundView = [UIView new];
    }
    return _navBackgroundView;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.containerView mainScrollViewDidScroll:scrollView];
}


@end
