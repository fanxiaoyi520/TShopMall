//
//  TSGoodsListController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSGoodsListController.h"
#import "TSSearchTextView.h"
#import "TSGoodsListFittleView.h"
#import "TSRefreshConfiger.h"
#import "TSGoodsListDataController.h"
#import "TSGoodsListCell.h"
#import "TSSearchController.h"
#import "TSEmptyAlertView.h"
#import "TSMakeOrderController.h"

@interface TSGoodsListController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TSRefreshDelegate, TSGoodsListFittleDelegate>{
    NSArray<TSGoodsListSection *> *sections;
}
@property (nonatomic, strong) TSSearchTextView *searchView;
@property (nonatomic, strong) UIButton *styleBtn;
@property (nonatomic, strong) TSGoodsListFittleView *fittleView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TSRefreshConfiger *refreshConfiger;
@property (nonatomic, strong) TSGoodsListDataController *dataCon;
@end

@implementation TSGoodsListController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setNaviBar];
    
    self.dataCon = [TSGoodsListDataController new];
    self.dataCon.keyword = self.searchKey;
    [self refreshGoods];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)refreshGoods{
    __weak typeof(self) weakSelf = self;
    [self.dataCon queryGoods:^(NSError *error) {
        if (error) {
            
        } else {
            self->sections = self.dataCon.lists;
            [weakSelf.collectionView reloadData];
        }
        [weakSelf showRefreshUI];
        [weakSelf showEmptyView];
    }];
}

- (void)showRefreshUI{
    if (self.dataCon.currentNum !=0) {//表明是加载更多
        if (self.dataCon.currentNum == [sections lastObject].rows.count) {//数据加载失败
            [self.refreshConfiger endRefresh:NO];
        } else {
            [self.refreshConfiger endRefresh:YES];
        }
    } else{
        [self.refreshConfiger endRefresh:YES];
    }
}

- (void)showEmptyView{
    if (self.dataCon.currentNum != 0) {
        [TSEmptyAlertView hideInView:self.collectionView];
        return ;
    }
    TSEmptyAlertView.new.alertInfo(@"抱歉，没有找到商品哦～", @"重试").show(self.collectionView, ^{
        [self refreshGoods];
    });
}

- (void)goToSearch{
    TSSearchController *searchCon = nil;
    for (UIViewController *con in self.navigationController.viewControllers) {
        if ([con isKindOfClass:[TSSearchController class]]) {
            searchCon = (TSSearchController *)con;
            break;
        }
    }
    if (searchCon == nil) {
        [self presentViewController:[TSSearchController new] animated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)showSytleChanged:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.dataCon.isGrid = NO;
        sections = [self.dataCon sectionsForUIWithDatas:self.dataCon.result.list];
        self.collectionView.backgroundColor = UIColor.whiteColor;
        [self.refreshConfiger changeRefreshType:NO];
    } else {
        self.dataCon.isGrid = YES;
        sections = [self.dataCon sectionsForUIWithDatas:self.dataCon.result.list];
        self.collectionView.backgroundColor = KHexColor(@"#F4F4F5");
        [self.refreshConfiger changeRefreshType:YES];
        
    }
    [self.collectionView reloadData];
}

- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType{
    self.dataCon.sortType = type;
    self.dataCon.sort = sortType;
    [self.dataCon defaultConfig];
    [self refreshGoods];
}

- (void)setNaviBar{
    self.navigationItem.titleView = self.searchView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.styleBtn];
}

#pragma mark -- UICollectionViewDataSource --
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sections[section].rows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSSearchRow *row = sections[indexPath.section].rows[indexPath.row];
    Class className = NSClassFromString(row.cellIdentifier);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:row.cellIdentifier];
    TSGoodsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
    cell.obj = row.obj;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    TSSearchSection *section = sections[indexPath.section];
    [collectionView registerClass:NSClassFromString(section.headerIdentifier) forSupplementaryViewOfKind:kind withReuseIdentifier:section.headerIdentifier];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:section.headerIdentifier forIndexPath:indexPath];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSGoodsListRow *row = sections[indexPath.section].rows[indexPath.row];
    return row.rowSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    TSSearchSection *searchSection = sections[section];
    return CGSizeMake(kScreenWidth, searchSection.headerHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    TSSearchSection *searchSection = sections[section];
    return CGSizeMake(kScreenWidth, searchSection.footerHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSSearchRow *row = sections[indexPath.section].rows[indexPath.row];
    TSGoodListViewModel *vm = (TSGoodListViewModel *)row.obj;
    TSMakeOrderController *con = [TSMakeOrderController new];
    [self.navigationController pushViewController:con animated:YES];
}

- (BOOL)hasMoreData{
    return self.dataCon.currentNum < self.dataCon.totalNum;
}

- (BOOL)isShowFooter{
    return self.dataCon.currentNum;
}

- (void)headerRefresh{
    [self.dataCon defaultConfig];
    [self refreshGoods];
}

- (void)footerRefresh{
    self.dataCon.currentPage ++;
    [self refreshGoods];
}

- (void)viewWillLayoutSubviews{
    [self.fittleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_offset(KRateW(56.0));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.fittleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (TSSearchTextView *)searchView{
    if (_searchView) {
        return _searchView;
    }
    self.searchView = [TSSearchTextView new];
    self.searchView.textField.enabled = NO;
    self.searchView.textField.text = self.searchKey;
    self.searchView.frame = CGRectMake(0, 0, KRateW(250.0), KRateW(32.0));
    
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSearch)];
    gesTap.numberOfTapsRequired = 1;
    [self.searchView addGestureRecognizer:gesTap];
    
    return self.searchView;
}

- (UIButton *)styleBtn{
    if (_styleBtn) {
        return _styleBtn;
    }
    self.styleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.styleBtn.frame = CGRectMake(0, 0, KRateW(24), KRateW(24.0));
    [self.styleBtn setBackgroundImage:KImageMake(@"mall_category_btn_gird") forState:UIControlStateNormal];
    [self.styleBtn setBackgroundImage:KImageMake(@"mall_category_btn_rail") forState:UIControlStateSelected];
    [self.styleBtn addTarget:self action:@selector(showSytleChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    return self.styleBtn;
}

- (TSGoodsListFittleView *)fittleView{
    if (_fittleView) {
        return _fittleView;
    }
    self.fittleView = [TSGoodsListFittleView new];
    [self.view addSubview:self.fittleView];
    
    return self.fittleView;
}

-(UICollectionView *)collectionView{
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = KRateW(8.0);
    flowLayout.minimumInteritemSpacing  = KRateW(8.0);
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(KRateW(10.0), KRateW(16.0), KRateW(8.0), KRateW(16.0));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = KHexColor(@"#F4F4F5");
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    self.refreshConfiger = [TSRefreshConfiger configScrollView:self.collectionView isLight:YES response:self type:Both];
    
    return self.collectionView;
}

@end
