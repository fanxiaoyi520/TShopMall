//
//  TSGoodsListController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/29.
//

#import "TSGoodsListController.h"
#import "TSSearchResultCollectionView.h"
#import "TSSearchResultDataController.h"
#import "TSEmptyAlertView.h"
#import "TSRecomendDataController.h"

@interface TSGoodsListController ()
@property (nonatomic, strong) TSSearchResultFittleView *fittleView;
@property (nonatomic, strong) TSSearchResultCollectionView *collectionView;
@property (nonatomic, strong) RefreshGifHeader *refreshHeader;
@property (nonatomic, strong) RefreshGifFooter *refreshFooter;
@end

@implementation TSGoodsListController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType{}
- (void)updateCollectionBackgroundColor:(UIColor *)color{
    self.collectionView.backgroundColor = color;
}

- (void)setSections:(NSArray<TSSearchSection *> *)sections{
    _sections = sections;
    self.collectionView.sections = sections;
    [self.collectionView reloadData];
}


- (void)configRefreshHeaderWithTarget:(id)target selector:(SEL)selector{
    RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingTarget:target refreshingAction:selector];
    self.collectionView.mj_header = header;
    
    self.refreshHeader = header;
}

- (void)configRefreshFooterWithTarget:(id)target selector:(SEL)selector{
    RefreshGifFooter *footer = [RefreshGifFooter footerWithRefreshingTarget:target refreshingAction:selector];
    self.collectionView.mj_footer = footer;
    self.collectionView.mj_footer.hidden = NO;
    
    self.refreshFooter = footer;
}

- (void)endRefreshIsNoMoreData:(BOOL)noMoreData isEmptyData:(BOOL)isEmptyData{
    [self.refreshHeader endRefreshing];
    [self.refreshFooter endRefreshing];
    if (noMoreData) {
        [self.refreshFooter endRefreshingWithNoMoreData];
    }
    self.refreshFooter.hidden = isEmptyData;
}



- (void)viewWillLayoutSubviews{
    [self.fittleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(GK_STATUSBAR_NAVBAR_HEIGHT);
        make.height.mas_offset(KRateW(56.0));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.fittleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
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
    
    
    return self.collectionView;
}

@end
