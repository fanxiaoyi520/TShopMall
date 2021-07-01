//
//  TSSearchResultController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/29.
//

#import "TSSearchResultController.h"
#import "TSSearchResultDataController.h"
#import "TSSearchResultNaviView.h"
#import "TSSearchKeyViewModel.h"

@interface TSSearchResultController ()
@property (nonatomic, strong) TSSearchResultNaviView *naviView;
@property (nonatomic, strong) TSSearchResultDataController *dataCon;
@end

@implementation TSSearchResultController


- (instancetype)init{
    if (self == [super init]) {
        self.dataCon = [TSSearchResultDataController new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hiddenNavigationBar];
    [self configRefreshFooterWithTarget:self selector:@selector(mjFooterRefresh:)];
    [self configRefreshHeaderWithTarget:self selector:@selector(mjHeadreRefresh:)];
    
    [self showSearchResultView];
}

- (void)refreshGoods{
    __weak typeof(self) weakSelf = self;
    [self.dataCon queryGoods:^(NSError *error) {
        
        if (error) {
            
        } else {
            self.sections = self.dataCon.lists;
        }
        BOOL isNoMoreData = YES;
        if (self.dataCon.totalNum == self.dataCon.currentNum) {
            isNoMoreData = NO;
        }
        [weakSelf endRefreshIsNoMoreData:isNoMoreData isEmptyData:weakSelf.dataCon.isEmptyView];
    }];
}


- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType{
    self.dataCon.sortType = type;
    self.dataCon.sort = sortType;
    [self.dataCon defaultConfig];
    [self refreshGoods];
}

/// 下拉刷新
- (void)mjHeadreRefresh:(RefreshGifHeader *)mj_header {
    [self.dataCon defaultConfig];
    self.dataCon.keyword = self.searchKey;
    [self refreshGoods];
}

/// 上拉加载
- (void)mjFooterRefresh:(RefreshGifFooter *)mj_footer {
    self.dataCon.currentPage ++;
    [self refreshGoods];
}

- (void)showSytleChanged:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.dataCon.isGrid = NO;
        self.sections = [self.dataCon sectionsForUIWithDatas:self.dataCon.result.list];
        [self updateCollectionBackgroundColor:UIColor.whiteColor];
    } else {
        self.dataCon.isGrid = YES;
        self.sections = [self.dataCon sectionsForUIWithDatas:self.dataCon.result.list];
        [self updateCollectionBackgroundColor:KHexColor(@"#F4F4F5")];
    }
}

- (void)hideSearchResultView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSearchResultView{
    self.dataCon.isGrid = YES;
    self.naviView.typeBtn.selected = NO;
    self.dataCon.keyword = self.searchKey;
    [self.dataCon defaultConfig];
    
    self.naviView.searchView.textField.text = self.searchKey;
    [self refreshGoods];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(GK_STATUSBAR_NAVBAR_HEIGHT);
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

@end
