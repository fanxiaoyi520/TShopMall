//
//  TSCategoryViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSCategoryViewController.h"
#import "TSGeneralSearchButton.h"
#import "TSCategoryDataController.h"
#import "TSCategoryKindCell.h"
#import "TSCategoryKindViewModel.h"
#import "TSSearchController.h"
#import "TSCategoryContainerViewController.h"
#import "TSCategoryBannerCell.h"
#import "TSMeasureCell.h"
#import "TSRecommendCell.h"
#import "TSTableViewBaseCell.h"
#import "TSTabBarController.h"
@interface TSCategoryViewController ()<UITableViewDelegate,UITableViewDataSource, TSCategoryContainerDataSource, TSTabBarControllerProtocol>

/// 搜索按钮
@property(nonatomic, strong) TSGeneralSearchButton *searchButton;
/// 分类按钮
@property(nonatomic, strong) UIButton *categoryButton;
/// 左边分类
@property(nonatomic, strong) UITableView *leftTableView;
/// 右边商品列表
@property(nonatomic, strong) TSCategoryContainerViewController *container;
/// 左边ViewModel
@property(nonatomic, strong) TSCategoryKindViewModel *kindViewModel;

@property(nonatomic, strong) TSCategoryDataController *dataController;

@end

@implementation TSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.container];
    
//    @weakify(self);
//    [self.KVOController observe:self.dataController keyPath:@"kinds" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        @strongify(self)
//        if (self.dataController.kinds) {
//            [self.kindViewModel viewModelWithKinds:self.dataController.kinds selectedRow:0];
//            [self.tableView reloadData];
//        }
//    }];
//    
//    [self.KVOController observe:self.dataController keyPath:@"sections" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        @strongify(self)
//        if (self.dataController.sections) {
//            self.container.dataSource = self;
//            [self.container showContentAtPage:0];
//        }
//    }];

    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchKindsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            self.container.dataSource = self;
            [strongSelf.kindViewModel viewModelWithKinds:self.dataController.kinds selectedRow:0];
            [strongSelf.tableView reloadData];
            [strongSelf.container showContentAtPage:0];
        }
    }];
}

-(void)setupNavigationBar{
    [super setupNavigationBar];
    
    self.gk_navigationItem.titleView = self.searchButton;
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryButton];
}

- (void)fillCustomView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.container.view];
    
    NSArray *childArr = self.navigationController.childViewControllers;
    
    CGFloat bottom = -GK_TABBAR_HEIGHT;
    if (childArr.count > 1) {
        bottom = 0;
    }

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(88);
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(bottom);
    }];
    
    [self.container.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_right).offset(1);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(bottom);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - Action
-(void)searchAction:(TSGeneralSearchButton *)sender{
    [TSSearchController show];
}

-(void)categoryAction:(UIButton *)sender{

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.dataController.kinds.count;
    }
   
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }
    else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        TSCategoryKindCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TSCategoryKindCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bindKindViewModel:self.kindViewModel.cellViewModels[indexPath.row]];
        return cell;
        
    }else{
        TSCategoryContentModel *model = self.dataController.sections[self.kindViewModel.selectedRow];
        TSTableViewBaseCell *cell;
        if (indexPath.section == 0) {
            cell =  [tableView dequeueReusableCellWithIdentifier:@"TSCategoryBannerCell"];
        }else if(indexPath.section == 1){
            cell =  [tableView dequeueReusableCellWithIdentifier:@"TSMeasureCell"];

        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"TSRecommendCell"];
        }
        cell.indexPath = indexPath;
        cell.cellSuperViewTableView = tableView;
        cell.data = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return nil;
    }
    if (section != 0) {
        UIView *view = [UIView new];
        UILabel *titleLabel = [UILabel new];
        titleLabel = [[UILabel alloc] init];
        titleLabel.text = section==1?@"产品类型":@"推荐商品";
        titleLabel.font = KFont(PingFangSCMedium, 14);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = KTextColor;
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.centerY.equalTo(view);
        }];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0;
    }else{
        if (section != 0) {
            return 32;
        }
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.leftTableView) {
        [self updateTableViewWithRow:indexPath.row];
        [self.container showContentAtPage:indexPath.row];
    }
   
}

- (void)updateTableViewWithRow:(NSInteger)row {
    [self.kindViewModel viewModelExchangeSelectedRow:row];
    [self.leftTableView reloadData];
}

#pragma mark - Getter
-(TSGeneralSearchButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [TSGeneralSearchButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"电视" forState:UIControlStateNormal];
        _searchButton.backgroundColor = KGrayColor;
        [_searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        _searchButton.frame = CGRectMake(16, 0, kScreenWidth - 65, 32);
    }
    return _searchButton;
}

-(UIButton *)categoryButton{
    if (!_categoryButton) {
        _categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryButton setImage:KImageMake(@"mall_category_cart") forState:UIControlStateNormal];
        [_categoryButton setImage:KImageMake(@"mall_category_cart") forState:UIControlStateHighlighted];
        [_categoryButton addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        _categoryButton.imageView.contentMode = UIViewContentModeCenter;
        _categoryButton.bounds = CGRectMake(0, 0, 32, 32);
    }
    return _categoryButton;
}

-(UITableView *)tableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_leftTableView registerClass:[TSCategoryKindCell class] forCellReuseIdentifier:NSStringFromClass([TSCategoryKindCell class])];
    }
    return _leftTableView;
}

-(TSCategoryContainerViewController *)container{
    if (!_container) {
        _container = [TSCategoryContainerViewController new];
    }
    return _container;
}

-(TSCategoryDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSCategoryDataController alloc] init];
        _dataController.context = self;
    }
    return _dataController;
}

-(TSCategoryKindViewModel *)kindViewModel{
    if (!_kindViewModel) {
        _kindViewModel = [[TSCategoryKindViewModel alloc] init];
    }
    return _kindViewModel;
}

- (NSInteger)numberOfContentsInContainerView:(nonnull TSCategoryContainerViewController *)viewController {
    return self.dataController.kinds.count;
}

- (nonnull UIView *)viewForContainerViewController:(nonnull TSCategoryContainerViewController *)viewController currentPage:(NSInteger)page{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = KWhiteColor;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[TSMeasureCell class] forCellReuseIdentifier:@"TSMeasureCell"];
    [tableView registerClass:[TSCategoryBannerCell class] forCellReuseIdentifier:@"TSCategoryBannerCell"];
    [tableView registerClass:[TSRecommendCell class] forCellReuseIdentifier:@"TSRecommendCell"];
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];


    if (@available(iOS 11.0, *)) {
        tableView.estimatedRowHeight = 200;
        tableView.estimatedSectionHeaderHeight = 30;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return tableView;
}

#pragma mark -TSTabBarControllerProtocol
- (void)refreshData{
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchKindsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            self.container.dataSource = self;
            [strongSelf.kindViewModel viewModelWithKinds:self.dataController.kinds selectedRow:0];
            [strongSelf.tableView reloadData];
            [strongSelf.container showContentAtPage:0];
        }
    }];
}
@end
