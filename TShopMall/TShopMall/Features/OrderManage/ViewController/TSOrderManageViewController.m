//
//  TSOrderManageViewController.m
//  TShopMall
//
//  Created by EDY on 2021/6/17.
//

#import "TSOrderManageViewController.h"
#import <JXCategoryView/JXCategoryView.h>

@interface TSOrderManageViewController ()<JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation TSOrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];
    
    self.myCategoryView.titles = @[@"待付款", @"待发货", @"待收货", @"待完成", @"全部订单"];
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleFont = KRegularFont(16);
    self.myCategoryView.titleSelectedFont = KRegularFont(16);
    self.myCategoryView.titleColor = KHexAlphaColor(@"#2D3132", 1.0);
    self.myCategoryView.titleSelectedColor = KHexAlphaColor(@"#E64C3D", 1.0);
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    
    JXCategoryIndicatorLineView *backgroundView = [[JXCategoryIndicatorLineView alloc] init];
    backgroundView.indicatorColor = [UIColor whiteColor];
    self.myCategoryView.indicators = @[backgroundView];
    self.myCategoryView.separatorLineShowEnabled = YES;
    self.listContainerView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.myCategoryView];
    [self.view addSubview:self.listContainerView];
    self.myCategoryView.listContainer = self.listContainerView;
}


-(void)setupBasic{
//    [super setupBasic];
    
    self.navigationItem.title = @"我的订单";
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    CGFloat containViewY = categoryViewHeight;

    self.myCategoryView.frame = CGRectMake(0, 0,self.view.bounds.size.width, categoryViewHeight);
    self.listContainerView.frame = CGRectMake(0, containViewY, self.view.bounds.size.width ,self.view.bounds.size.height);
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

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {

}

@end
