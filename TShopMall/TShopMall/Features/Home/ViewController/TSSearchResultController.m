//
//  TSSearchResultController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchResultController.h"
#import "TSSearchResultNaviView.h"
#import "TSSearchResultFittleView.h"
#import "TSSearchResultCollectionView.h"
#import "TSSearchResultDataController.h"
#import "TSEmptyAlertView.h"
#import "TSRecomendDataController.h"
#import "TSSearchKeyViewModel.h"

@interface TSSearchResultController ()<TSSearchResultFittleDelegate>
@property (nonatomic, strong) TSSearchResultNaviView *naviView;
@property (nonatomic, strong) TSSearchResultFittleView *fittleView;
@property (nonatomic, strong) TSSearchResultCollectionView *collectionView;
@property (nonatomic, strong) TSSearchResultDataController *dataCon;
@property (nonatomic, strong) RefreshGifHeader *refreshHeader;
@property (nonatomic, strong) RefreshGifFooter *refreshFooter;
@end

@implementation TSSearchResultController

- (instancetype)init{
    if (self == [super init]) {
        self.view.alpha = 0;
        self.dataCon = [TSSearchResultDataController new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenNavigationBar];
    
    [self refreshGoods];
}

- (void)showSearchResultView{
    self.dataCon.isGrid = YES;
    self.naviView.typeBtn.selected = NO;
    [self.dataCon defaultConfig];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        self.naviView.searchView.textField.text = self.searchKey;
        [self refreshGoods];
    }];
    
    [[TSRecomendDataController new] fetchRecomentDatas:^{
            
    }];
}

- (void)hideSearchResultView{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
    }];
}

- (void)refreshGoods{
    __weak typeof(self) weakSelf = self;
    [self.dataCon queryGoods:^(NSError *error) {
        
        if (error) {
            
        } else {
            self.collectionView.sections = self.dataCon.lists;
            [weakSelf.collectionView reloadData];
        }
        [weakSelf endRefresh];
    }];
}

- (void)showSytleChanged:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.dataCon.isGrid = NO;
        self.collectionView.sections = [self.dataCon sectionsForUIWithDatas:self.dataCon.result.list];
        self.collectionView.backgroundColor = UIColor.whiteColor;
    } else {
        self.dataCon.isGrid = YES;
        self.collectionView.sections = [self.dataCon sectionsForUIWithDatas:self.dataCon.result.list];
        self.collectionView.backgroundColor = KHexColor(@"#F4F4F5");
        
    }
    [self.collectionView reloadData];
}

- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType{
    self.dataCon.sortType = type;
    self.dataCon.sort = sortType;
    [self.dataCon defaultConfig];
    [self refreshGoods];
}

/// 下拉刷新
- (void)mjHeadreRefresh:(RefreshGifHeader *)mj_header {
//    [self loadDataIsNew:YES];
    [self.dataCon defaultConfig];
    self.dataCon.keyword = self.searchKey;
    [self refreshGoods];
}

/// 上拉加载
- (void)mjFooterRefresh:(RefreshGifFooter *)mj_footer {
    self.dataCon.currentPage ++;
    [self refreshGoods];
    
}

/// 添加MJ刷新控件
- (void)addMJHeaderAndFooter {
    //默认【下拉刷新】
    RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeadreRefresh:)];
    self.collectionView.mj_header = header;

    RefreshGifFooter *footer = [RefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjFooterRefresh:)];
    self.collectionView.mj_footer = footer;
    self.collectionView.mj_footer.hidden = NO;
    
    self.refreshHeader = header;
    self.refreshFooter = footer;
}

- (void)endRefresh{
    [self.refreshHeader endRefreshing];
    [self.refreshFooter endRefreshing];
    if (self.dataCon.totalNum == self.dataCon.currentNum) {
        [self.refreshFooter endRefreshingWithNoMoreData];
    }
    self.refreshFooter.hidden = self.dataCon.isEmptyView;
}


- (void)viewWillLayoutSubviews{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(GK_STATUSBAR_NAVBAR_HEIGHT);
    }];
    
    [self.fittleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.naviView.mas_bottom);
        make.height.mas_offset(KRateW(56.0));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.fittleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (TSSearchResultNaviView *)naviView{
    if (_naviView) {
        return _naviView;
    }
    self.naviView = [TSSearchResultNaviView new];
    [self.view addSubview:self.naviView];
    __weak typeof(self) weakSelf = self;
    self.naviView.searchView.startSearch = ^(NSString *key) {
        [TSSearchKeyViewModel handleHistoryKeys:key];
        [weakSelf.dataCon defaultConfig];
        weakSelf.searchKey = key;
        [weakSelf refreshGoods];
    };
    
    [self.naviView.backBtn addTarget:self action:@selector(hideSearchResultView) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView.typeBtn addTarget:self action:@selector(showSytleChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    return self.naviView;
}

- (TSSearchResultFittleView *)fittleView{
    if (_fittleView) {
        return _fittleView;
    }
    self.fittleView = [TSSearchResultFittleView new];
    self.fittleView.delegate = self;
    [self.view addSubview:self.fittleView];
    
    return self.fittleView;
}

- (TSSearchResultCollectionView *)collectionView{
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = KRateW(8.0);
    flowLayout.minimumInteritemSpacing  = KRateW(8.0);
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(KRateW(10.0), KRateW(16.0), KRateW(8.0), KRateW(16.0));
    self.collectionView = [[TSSearchResultCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    
    [self addMJHeaderAndFooter];
    
    return self.collectionView;
}

@end
