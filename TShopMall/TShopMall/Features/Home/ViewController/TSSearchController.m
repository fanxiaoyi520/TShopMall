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
#import <Lottie/Lottie.h>

@interface TSSearchController ()
@property (nonatomic, strong) TSSearchView *searchView;
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
    [TSSearchDataController fetchData:^(NSArray<TSSearchSection *> *sections, NSError *error) {
        self.searchView.sections = sections;
    }];
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
