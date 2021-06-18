//
//  TSContentBaseViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSContentBaseViewController.h"
#import "TSBaseListController.h"

@interface TSContentBaseViewController ()<JXCategoryViewDelegate>

@end

@implementation TSContentBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];

    self.categoryView.frame = CGRectMake(0, 0, kScreenWidth, categoryViewHeight);
    self.listContainerView.frame = CGRectMake(0,categoryViewHeight,kScreenWidth,kScreenHeight - categoryViewHeight);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - Public
- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {

}

#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    TSBaseListController *list = [[TSBaseListController alloc] init];
    return list;
}

#pragma mark - Getter
- (JXCategoryBaseView *)categoryView {
    if (!_categoryView) {
        _categoryView = [self preferredCategoryView];
        _categoryView.delegate = self;
        _categoryView.listContainer = self.listContainerView;
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        _listContainerView.backgroundColor = UIColor.whiteColor;
    }
    return _listContainerView;
}
@end
