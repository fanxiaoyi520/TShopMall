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

@property (nonatomic, assign) BOOL isScrollDown;

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
    
    self.gk_navigationItem.titleView = self.searchButton;
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryButton];
}

- (void)fillCustomView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
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
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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

#pragma mark - <TableView 联动 CollectionView >
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self updateTableViewWithRow:indexPath.row];
    
    //UICollectionView 滚动到指定 Section
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.dataController.kinds[indexPath.row].startSection] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)updateTableViewWithRow:(NSInteger)row {
    [self.kindViewModel viewModelExchangeSelectedRow:row];
    [self.tableView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.contentViewModel.cellViewModels.count * categoryContentCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    
    TSCategorySectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSCategorySectionModel *model = self.contentViewModel.currentCellViewModel.sections[indexPath.section];
    TSCategorySectionItemModel *item = (TSCategorySectionRecommendItemModel *)model.items[indexPath.row];
    if ([item isKindOfClass:TSCategorySectionRecommendItemModel.class]) {
        TSCategorySectionRecommendItemModel *model = (TSCategorySectionRecommendItemModel *)item;
        [[TSServicesManager sharedInstance].uriHandler openURI:[NSString stringWithFormat:@"page://quote/productDetail?uuid=%@", model.uuid]];
    }
    else if ([item isKindOfClass:TSCategorySectionKindItemModel.class]){
        TSCategorySectionKindItemModel *model = (TSCategorySectionKindItemModel *)item;
//        [[TSServicesManager sharedInstance].uriHandler openURI:[NSString stringWithFormat:@"page://quote/productDetail?uuid=%@", model.uuid]];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class className = NSClassFromString(model.headerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:model.headerIdentify];
        TSCategoryHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:model.headerIdentify forIndexPath:indexPath];
        [header bindCategorySectionModel:model];
        return header;
    }else{
        return nil;
    }
    return nil;
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    TSCategorySectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:section];
    TSCategorySectionModel *model = self.contentViewModel.cellViewModels[TSIndexPath.section].sections[TSIndexPath.item];
    return model.spacingWithLastSection;
}

#pragma mark - <CollectionView 联动 TableView >
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;

    if (self.collectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(8.0)) {
    if (!_isScrollDown && collectionView.dragging)
    {
        NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section];
        [self updateTableViewWithRow:TSIndexPath.section];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isScrollDown && collectionView.dragging)
    {
        NSIndexPath *TSIndexPath = [self.dataController fatchContentIndexPath:indexPath.section + 1];
        [self updateTableViewWithRow:TSIndexPath.section];
    }
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

@end
