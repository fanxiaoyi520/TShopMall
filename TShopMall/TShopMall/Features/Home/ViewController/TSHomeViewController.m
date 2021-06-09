//
//  TSHomeViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSHomeViewController.h"
#import "TSHomePageDataController.h"


@interface TSHomeViewController ()<FMCollectionLayoutViewConfigurationDelegate,UICollectionViewDelegate>

/// 数据中心
@property(nonatomic, strong) TSHomePageDataController *dataController;
/// 布局视图
@property(nonatomic, strong) FMLayoutView *layoutView;

@end

@implementation TSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.dataController fetchPlaceholderLayouts];
    
    self.layoutView.sections = self.dataController.layouts;
    [self.layoutView reloadData];
}

- (void)fillCustomView{
    [self.view addSubview:self.layoutView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + 10;
    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bottom);
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

#pragma mark - FMCollectionLayoutViewConfigurationDelegate
- (void)layoutView:(FMLayoutView *)layoutView configurationCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
}

- (void)layoutView:(FMLayoutView *)layoutView configurationHeader:(UICollectionReusableView *)header indexPath:(NSIndexPath *)indexPath{
    
}

- (void)layoutView:(FMLayoutView *)layoutView configurationFooter:(UICollectionReusableView *)footer indexPath:(NSIndexPath *)indexPath{
    
}

- (void)layoutView:(FMLayoutView *)layoutView configurationSectionBg:(UICollectionReusableView *)bg indexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Getter
-(TSHomePageDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSHomePageDataController alloc] init];
    }
    return _dataController;
}

-(FMLayoutView *)layoutView{
    if (!_layoutView) {
        _layoutView = [[FMLayoutView alloc] init];
        _layoutView.configuration = self;
        _layoutView.delegate = self;
        _layoutView.backgroundColor = KGrayColor;
        _layoutView.showsVerticalScrollIndicator = NO;
        _layoutView.showsHorizontalScrollIndicator = NO;
    }
    return _layoutView;
}

@end
