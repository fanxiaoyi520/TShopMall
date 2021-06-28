//
//  TSRankCoronalViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSRankCoronalViewController.h"
#import "TSRankDataController.h"
#import "TSRankMonthViewController.h"

@interface TSRankCoronalViewController ()

@property(nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property(nonatomic, strong) TSRankDataController *dataController;

@end

@implementation TSRankCoronalViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.gk_navigationBar.hidden = YES;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleFont = KRegularFont(16);
    self.myCategoryView.titleSelectedFont = KRegularFont(16);
    self.myCategoryView.titleColor = KHexAlphaColor(@"#2D3132", 0.4);
    self.myCategoryView.titleSelectedColor = KHexColor(@"#E64C3D");
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
    lineView.indicatorColor = [UIColor whiteColor];
    self.myCategoryView.indicators = @[lineView];
    self.myCategoryView.separatorLineShowEnabled = YES;
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
    return [[JXCategoryTitleView alloc] init];
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
