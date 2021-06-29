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
#import "TSSearchResultController.h"
#import "TSSearchKeyViewModel.h"
#import "TSTestSearchResultController.h"
#import "TSRecomendDataController.h"

@interface TSSearchController ()
@property (nonatomic, strong) TSSearchView *searchView;
@property (nonatomic, strong) TSSearchDataController *dataCon;
@property (nonatomic, strong) TSTestSearchResultController *searchResultCon;
@end

@implementation TSSearchController

+ (void)show{
    TSSearchController *searchCon = [TSSearchController new];
    TSBaseNavigationController *naviCon = [[TSBaseNavigationController alloc] initWithRootViewController:searchCon];
    naviCon.modalPresentationStyle = UIModalPresentationFullScreen;
    UIViewController *con = [UIApplication sharedApplication].delegate.window.rootViewController;
    [con presentViewController:naviCon animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.dataCon = [TSSearchDataController new];
    [self refreshData];
    [self configRecomendView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super view];
    [self hiddenNavigationBar];
}

- (void)refreshData{
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetchData:^(NSArray<TSSearchSection *> *sections, NSError *error) {
        weakSelf.searchView.sections = sections;
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
    self.searchView.sections = [TSSearchDataController updateHistorySections:self.dataCon.sections];
    
    self.searchResultCon.searchKey = key;
    [self.searchResultCon showSearchResultView];
}

- (void)recomentGoodsSelected:(TSRecomendModel *)recomend{
    
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

- (TSTestSearchResultController *)searchResultCon{
    if (_searchResultCon) {
        return _searchResultCon;
    }
    self.searchResultCon = [TSTestSearchResultController new];
    self.searchResultCon.view.frame = self.view.frame;
    [self.view addSubview:self.searchResultCon.view];
    [self addChildViewController:self.searchResultCon];
    
    return self.searchResultCon;
}
@end
