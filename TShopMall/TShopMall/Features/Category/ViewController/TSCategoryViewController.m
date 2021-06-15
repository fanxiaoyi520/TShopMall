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

@interface TSCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>

/// 搜索按钮
@property(nonatomic, strong) TSGeneralSearchButton *searchButton;
/// 分类按钮
@property(nonatomic, strong) UIButton *categoryButton;
/// 左边分类
@property(nonatomic, strong) UITableView *tableView;
/// 右边商品列表
@property(nonatomic, strong) UICollectionView *collectionView;
/// 左边ViewModel
@property(nonatomic, strong) TSCategoryKindViewModel *kindViewModel;
/// 右边边ViewModel
@property(nonatomic, strong) TSCategoryContentViewModel *contentViewModel;

@property(nonatomic, strong) TSCategoryDataController *dataController;

@end

@implementation TSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchKindsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.kindViewModel viewModelWithKinds:self.dataController.kinds selectedRow:0];
            [strongSelf.contentViewModel viewModelWithSubjects:self.dataController.sections selectedRow:0];
            [strongSelf.tableView reloadData];
            [strongSelf.collectionView reloadData];
        }
    }];
}

-(void)setupNavigationBar{
    [super setupNavigationBar];
    
    self.navigationItem.titleView = self.searchButton;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryButton];
}

- (void)fillCustomView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(88);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(GK_TABBAR_HEIGHT);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_right).offset(1);
        make.top.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-GK_TABBAR_HEIGHT);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - Action
-(void)searchAction:(TSGeneralSearchButton *)sender{
    
}

-(void)categoryAction:(UIButton *)sender{
    TSCategoryViewController *category = [[TSCategoryViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataController.kinds.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCategoryKindCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TSCategoryKindCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindKindViewModel:self.kindViewModel.cellViewModels[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.kindViewModel viewModelExchangeSelectedRow:indexPath.row];
    [self.contentViewModel viewModelExchangeSelectedRow:indexPath.row];
    [tableView reloadData];
    [self.collectionView scrollToTop];
    [self.collectionView reloadData];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.contentViewModel.currentCellViewModel.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    TSCategorySectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSProductDetailController *detail = [[TSProductDetailController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    TSCategorySectionModel *sectionModel = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class className = NSClassFromString(sectionModel.headerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:sectionModel.headerIdentify];
        TSCategoryHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.headerIdentify forIndexPath:indexPath];
        [header bindCategorySectionModel:sectionModel];
        return header;
    }else{
        return nil;
    }
    return nil;
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSCategorySectionModel *section = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    return section.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    TSCategorySectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    return model.hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    return model.hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section.section];
    return model.docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    return model.hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[section];
    return model.spacingWithLastSection;
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
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TSCategoryKindCell class] forCellReuseIdentifier:NSStringFromClass([TSCategoryKindCell class])];
    }
    return _tableView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(TSCategoryDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSCategoryDataController alloc] init];
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

@end
