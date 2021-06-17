//
//  TSRankHotCellController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankHotCellController.h"
#import "TSRankCurrentMonthController.h"
#import "TSRankLastMonthController.h"

@interface TSRankHotCellController ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation TSRankHotCellController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleFont = KRegularFont(16);
    self.myCategoryView.titleSelectedFont = KRegularFont(16);
    self.myCategoryView.titleColor = KHexAlphaColor(@"#2D3132", 0.4);
    self.myCategoryView.titleSelectedColor = KHexAlphaColor(@"#E64C3D", 0.4);
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
    lineView.indicatorColor = [UIColor whiteColor];
    self.myCategoryView.indicators = @[lineView];
    self.myCategoryView.separatorLineShowEnabled = YES;
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
        return list;
    }else{
        TSRankLastMonthController *list = [[TSRankLastMonthController alloc] init];
        return list;
    }
}

- (UIView *)listView {
    return self.view;
}

@end
