//
//  TSCategoryViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSCategoryViewController.h"
#import "TSCategoryHeaderReusableView.h"
#import "TSGeneralSearchButton.h"
#import "TSCategoryDataController.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSCategoryKindCell.h"
#import "TSUniversalFlowLayout.h"
#import "TSCategoryKindViewModel.h"
#import "TSCategoryContentViewModel.h"

#import "TSProductDetailController.h"
#import "TSSearchController.h"
#import "TSCategoryContainerViewController.h"

@interface TSCategoryViewController ()<UITableViewDelegate,UITableViewDataSource, TSCategoryContainerDataSource>

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
/// 右边边ViewModel
@property(nonatomic, strong) TSCategoryContentViewModel *contentViewModel;

@property(nonatomic, strong) TSCategoryDataController *dataController;

//@property (nonatomic, assign) BOOL isScrollDown;

@end

@implementation TSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.container];

    
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchKindsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            self.container.dataSource = self;
            [strongSelf.kindViewModel viewModelWithKinds:self.dataController.kinds selectedRow:0];
            [strongSelf.contentViewModel viewModelWithSubjects:self.dataController.sections selectedRow:0];
            [strongSelf.tableView reloadData];
//            [strongSelf.collectionView reloadData];
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
    else{
        return 10;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        TSCategoryKindCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TSCategoryKindCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bindKindViewModel:self.kindViewModel.cellViewModels[indexPath.row]];
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return 44;
    }else{
        return 44;
    }
    return 0;
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

-(TSCategoryContentViewModel *)contentViewModel{
    if (!_contentViewModel) {
        _contentViewModel = [[TSCategoryContentViewModel alloc] init];
    }
    return _contentViewModel;
}

- (NSInteger)numberOfContentsInContainerView:(nonnull TSCategoryContainerViewController *)viewController {
    return self.dataController.kinds.count;
}

- (nonnull UIView *)viewForContainerViewController:(nonnull TSCategoryContainerViewController *)viewController {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor redColor];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    if (@available(iOS 11.0, *)) {
        tableView.estimatedRowHeight = 200;
        tableView.estimatedSectionHeaderHeight = 30;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return tableView;
}


@end
