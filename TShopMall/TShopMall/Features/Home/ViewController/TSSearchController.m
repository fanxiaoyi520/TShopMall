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
#import "TSGoodsListController.h"
#import "TSSearchKeyViewModel.h"

@interface TSSearchController ()
@property (nonatomic, strong) TSSearchView *searchView;
@property (nonatomic, strong) TSSearchDataController *dataCon;
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
}

- (void)refreshData{
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetchData:^(NSArray<TSSearchSection *> *sections, NSError *error) {
        self.searchView.sections = sections;
        [weakSelf.searchView.refreshConfiger endRefresh:YES];
    }];
}

- (void)goToGoodsList:(NSString *)key{
    [TSSearchKeyViewModel handleHistoryKeys:key];
    TSGoodsListController *con = [TSGoodsListController new];
    con.searchKey = key;
    [self.navigationController pushViewController:con animated:YES];
    
    self.searchView.sections = [TSSearchDataController updateHistorySections:self.dataCon.sections];
}

- (void)viewWillAppear:(BOOL)animated{
    [super view];
    [self hiddenNavigationBar];
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

@end
