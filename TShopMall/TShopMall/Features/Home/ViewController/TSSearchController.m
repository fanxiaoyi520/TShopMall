//
//  TSSearchController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchController.h"
#import "TSBaseNavigationController.h"
#import "TSSearchView.h"
#import "TSSearchDataController.h"
#import "TSSearchKeyViewModel.h"
#import "TSSearchResultController.h"
#import "TSRecomendDataController.h"
#import "TSProductDetailController.h"

@interface TSSearchController ()
@property (nonatomic, strong) TSSearchView *searchView;
@property (nonatomic, strong) TSSearchDataController *dataCon;
@property (nonatomic, strong) TSSearchResultController *searchResultCon;
@end

@implementation TSSearchController

+ (void)show{
    TSSearchController *searchCon = [TSSearchController new];
    TSBaseNavigationController *naviCon = [[TSBaseNavigationController alloc] initWithRootViewController:searchCon];
    naviCon.modalPresentationStyle = UIModalPresentationFullScreen;
    UIViewController *con = [UIApplication sharedApplication].delegate.window.rootViewController;
    [con presentViewController:naviCon animated:YES completion:nil];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    if (@available(iOS 13.0, *)) {
//        return [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
//    } else {
//        return [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.dataCon = [TSSearchDataController new];
    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super view];
    [self hiddenNavigationBar];
    
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)refreshData{
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetchData:^{
        weakSelf.searchView.sections = weakSelf.dataCon.sections;
        [self configRecomendView];
    }];
}

- (void)configRecomendView{
    [TSRecomendDataController checkCurrentRecomendPage:RecomendCartPage finished:^(TSRecomendModel *recomendInfo, TSRecomendPageInfo *pageInfo) {
        if (recomendInfo.goodsList.count != 0) {
            [self.dataCon configRecomendSection:recomendInfo.goodsList isGrid:NO];
            self.searchView.sections = self.dataCon.sections;
        }
    }];
}

- (void)goToGoodsList:(NSString *)key{
    [TSSearchKeyViewModel handleHistoryKeys:key];
    [self.dataCon configHistorySection];
    TSSearchResultController *con = [TSSearchResultController new];
    con.searchKey = key;
    [self.navigationController pushViewController:con animated:YES];
    
    self.searchView.sections = self.dataCon.sections;
}

- (void)recomentGoodsSelected:(NSString *)uuid{
    TSProductDetailController *detail = [[TSProductDetailController alloc] init];
    detail.uuid = uuid;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewWillLayoutSubviews{
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (TSSearchView *)searchView{
    if (_searchView) {
        return _searchView;
    }
    self.searchView = [TSSearchView new];
    self.searchView.backgroundColor = UIColor.whiteColor;
    self.searchView.controller = self;
    [self.view addSubview:self.searchView];
    
    return self.searchView;
}

- (TSSearchResultController *)searchResultCon{
    if (_searchResultCon) {
        return _searchResultCon;
    }
    self.searchResultCon = [TSSearchResultController new];
    self.searchResultCon.view.frame = self.view.frame;
    [self.view addSubview:self.searchResultCon.view];
    [self addChildViewController:self.searchResultCon];
    
    return self.searchResultCon;
}

- (TSSearchDataController *)dataCon {
    if (_dataCon) {
        return _dataCon;
    }
    self.dataCon = [TSSearchDataController new];
    self.dataCon.context = self;
    
    return self.dataCon;
}
@end
