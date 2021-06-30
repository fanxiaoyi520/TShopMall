//
//  TSRankCoronalViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSRankCoronalViewController.h"
#import "TSRankDataController.h"
#import "TSRankMonthViewController.h"
#import "TSMonthTitleView.h"

@interface TSRankCoronalViewController ()

@property(nonatomic, strong) TSMonthTitleView *myCategoryView;
@property(nonatomic, strong) TSRankDataController *dataController;

@end

@implementation TSRankCoronalViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = KClearColor;
    self.gk_navigationBar.hidden = YES;
    
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    CGFloat padding = (kScreenWidth - 71 * 2) / 2;
    self.myCategoryView.contentEdgeInsetLeft = padding;
    self.myCategoryView.contentEdgeInsetRight = padding;
    self.myCategoryView.cellWidth = 71;
    self.myCategoryView.titleFont = KRegularFont(14);
    self.myCategoryView.titleSelectedFont = KRegularFont(14);
    self.myCategoryView.titleColor = [KWhiteColor colorWithAlphaComponent:0.5];
    self.myCategoryView.titleSelectedColor = KWhiteColor;
    self.myCategoryView.backgroundColor = KClearColor;
    
    @weakify(self);
    [self.dataController fetchRankCoronalComplete:^(BOOL isSucess) {
        @strongify(self)
        [self.myCategoryView reloadData];
    }];
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[TSMonthTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 53;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {

}

#pragma mark - JXCategoryListContentViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 2;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    TSRankMonthViewController *list = [[TSRankMonthViewController alloc] init];
    list.dataController = self.dataController;
    return list;
}

- (UIView *)listView {
    return self.view;
}

#pragma mark - Getter
-(TSRankDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSRankDataController alloc] init];
    }
    return _dataController;
}

@end
