//
//  TSRankCoronalViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSRankCoronalViewController.h"
#import "TSRankCurrentMonthController.h"
#import "TSRankLastMonthController.h"
#import "TSRankDataController.h"

@interface TSRankCoronalViewController ()

@property(nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property(nonatomic, strong) TSRankDataController *dataController;

@end

@implementation TSRankCoronalViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
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
    
    [self.dataController fetchRankCoronalComplete:^(BOOL isSucess) {

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
    if (index == 0) {
        TSRankCurrentMonthController *list = [[TSRankCurrentMonthController alloc] init];
        list.coronalSections = self.dataController.coronalSections;
        return list;
    }else{
        TSRankLastMonthController *list = [[TSRankLastMonthController alloc] init];
        list.coronalSections = self.dataController.coronalSections;
        return list;
    }
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
