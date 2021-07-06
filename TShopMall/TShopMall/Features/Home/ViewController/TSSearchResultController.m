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
#import "TSBaseNavigationController.h"

@interface TSSearchResultController ()
@property (nonatomic, strong) TSSearchResultNaviView *naviView;
@property (nonatomic, strong) TSSearchResultDataController *dataCon;
@property (nonatomic, copy) NSString *searchKey;
@end

@implementation TSSearchResultController

+ (TSSearchResultController *)showWithSearchKey:(NSString *)searchKey onController:(UIViewController *)controller{
    TSSearchResultController *con = [TSSearchResultController new];
    con.searchKey = searchKey;
    con.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    TSBaseNavigationController *naviCon = [[TSBaseNavigationController alloc] initWithRootViewController:con];
    naviCon.modalPresentationStyle =  UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [controller presentViewController:naviCon animated:NO completion:^{

    }];
    return con;
}

- (instancetype)init{
    if (self == [super init]) {
        self.view.alpha = 0;
        self.dataCon = [TSSearchResultDataController new];
        self.dataCon.context = self;
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)refreshGoods{
    if (self.sections.count == 0) {
        [self shouldShowSkeletonView:YES];
    }
    self.dataCon.keyword = self.searchKey;
    __weak typeof(self) weakSelf = self;
    [self.dataCon queryGoods:^(NSString *message) {
        [self shouldShowSkeletonView:NO];
        if (message.length != 0) {
            
        } else {
            self.sections = self.dataCon.lists;
        }
        [weakSelf endRefreshIsNoMoreData:!self.dataCon.hasMoreData isEmptyData:weakSelf.dataCon.isEmptyView];
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
    
    __weak typeof(self) weakSelf = self;
    [self.dataCon updateUIStyle:!sender.selected complete:^{
        weakSelf.sections = weakSelf.dataCon.lists;
    }];
    if (sender.selected == YES) {
        [self updateCollectionBackgroundColor:UIColor.whiteColor];
    } else {
        [self updateCollectionBackgroundColor:KHexColor(@"#F4F4F5")];
    }
}

- (void)hideSearchResultView{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}

- (void)showSearchResultView{
    self.dataCon.isGrid = YES;
    self.naviView.typeBtn.selected = NO;
    self.dataCon.keyword = self.searchKey;
    [self.dataCon defaultConfig];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIView animateWithDuration:0.5 animations:^{
            self.view.alpha = 1;
        } completion:^(BOOL finished) {
            self.naviView.searchView.textField.text = self.searchKey;
            [self refreshGoods];
        }];
    }];
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
        if (key.length == 0) return;
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
