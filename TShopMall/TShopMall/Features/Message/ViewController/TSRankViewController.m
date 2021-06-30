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

@property (nonatomic, strong) UIImageView * background_imgView;
/// 分割线
//@property (nonatomic, strong) UIView *seperateView;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation TSRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景红色图
    _background_imgView = [[UIImageView alloc] initWithImage:KImageMake(@"mall_rank_background")];
    [self.view addSubview:_background_imgView];
    
    self.myCategoryView.titles = @[@"冲冠榜", @"财富榜", @"热销榜"];
    self.myCategoryView.contentEdgeInsetLeft = 24;
    self.myCategoryView.contentEdgeInsetRight = 24;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleFont = KRegularFont(14);
    self.myCategoryView.titleSelectedFont = KRegularFont(14);
    self.myCategoryView.titleColor = [KWhiteColor colorWithAlphaComponent:0.5];
    self.myCategoryView.titleSelectedColor = KWhiteColor;
    self.myCategoryView.backgroundColor = KClearColor;

    [self.view addSubview:self.categoryView];
//    [self.view addSubview:self.seperateView];
    [self.view addSubview:self.listContainerView];
    
    [_background_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(KRateH(161));
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupBasic{
    [super setupBasic];
    self.gk_navTitle = @"排行榜";
    self.gk_navTitleColor = KWhiteColor;
    self.gk_navBackgroundColor = KClearColor;
    self.listContainerView.backgroundColor = KClearColor;
//    self.view.backgroundColor = KBlueColor;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat categoryY = CGRectGetHeight(self.gk_navigationBar.frame);
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    
    CGFloat containViewY = categoryViewHeight;
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom;

    self.myCategoryView.frame = CGRectMake(0, categoryY, kScreenWidth, categoryViewHeight);
//    self.seperateView.frame = CGRectMake(0, categoryY + categoryViewHeight, kScreenWidth, 1);
    CGFloat listContainerY = categoryY + containViewY;
    self.listContainerView.frame = CGRectMake(0, listContainerY, kScreenWidth ,kScreenHeight - listContainerY - bottom);
    //self.listContainerView.backgroundColor = UIColor.redColor;
    //NSLog(@" screenHeight == %f, self.listContainerView == %f", kScreenHeight, CGRectGetHeight(self.listContainerView.frame));
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 44;
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
        //list.titles = titles;
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
//-(UIView *)seperateView{
//    if (!_seperateView) {
//        _seperateView = [[UIView alloc] init];
//        _seperateView.backgroundColor = KHexColor(@"#EEEEEE");
//    }
//    return _seperateView;
//}

@end
