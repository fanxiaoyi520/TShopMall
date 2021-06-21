//
//  TSRankViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSRankViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "TSRankCoronalViewController.h"
#import "TSRankWealthController.h"
#import "TSRankHotCellController.h"

@interface TSRankViewController ()<JXCategoryListContainerViewDelegate>
/// 分割线
@property (nonatomic, strong) UIView *seperateView;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation TSRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myCategoryView.titles = @[@"冲冠榜", @"财富榜", @"热销榜"];
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleFont = KRegularFont(16);
    self.myCategoryView.titleSelectedFont = KRegularFont(16);
    self.myCategoryView.titleColor = KHexAlphaColor(@"#2D3132", 0.4);
    self.myCategoryView.titleSelectedColor = KHexColor(@"#E64C3D");
    self.myCategoryView.backgroundColor = [UIColor whiteColor];

    JXCategoryIndicatorLineView *backgroundView = [[JXCategoryIndicatorLineView alloc] init];
    backgroundView.indicatorColor = [UIColor whiteColor];
    self.myCategoryView.indicators = @[backgroundView];
    self.myCategoryView.separatorLineShowEnabled = YES;


    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.seperateView];
    [self.view addSubview:self.listContainerView];
}

-(void)setupBasic{
    [super setupBasic];
    self.navigationItem.title = @"排行版";
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    CGFloat containViewY = categoryViewHeight + 1;
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom;

    self.myCategoryView.frame = CGRectMake(0, 0,kScreenWidth, categoryViewHeight);
    self.seperateView.frame = CGRectMake(0, categoryViewHeight, kScreenWidth, 1);
    self.listContainerView.frame = CGRectMake(0, containViewY, kScreenWidth ,kScreenHeight - containViewY - bottom);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 56;
}

#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSArray *titles = @[@"本月", @"上月"];
    if (index == 0) {
        TSRankCoronalViewController *list = [[TSRankCoronalViewController alloc] init];
        list.titles = titles;
        return list;
    }else if (index == 1){
        TSRankWealthController *list = [[TSRankWealthController alloc] init];
        list.titles = titles;
        return list;
    }else{
        TSRankHotCellController *list = [[TSRankHotCellController alloc] init];
        list.titles = titles;
        return list;
    }
}

#pragma mark - JXCategoryListContainerViewDelegate
- (void)listContainerViewDidScroll:(UIScrollView *)scrollView{
    if ([self isKindOfClass:[TSRankCoronalViewController class]]) {
        CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
        CGFloat absIndex = fabs(index - self.currentIndex);
        if (absIndex >= 1) {
            self.listContainerView.scrollView.panGestureRecognizer.enabled = NO;
            self.listContainerView.scrollView.panGestureRecognizer.enabled = YES;
            _currentIndex = floor(index);
        }
    }
}

#pragma mark - Getter
-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = KHexColor(@"#EEEEEE");
    }
    return _seperateView;
}

@end
