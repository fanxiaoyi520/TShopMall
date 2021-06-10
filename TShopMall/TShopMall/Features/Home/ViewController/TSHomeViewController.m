//
//  TSHomeViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSHomeViewController.h"
#import "TSCategoryViewController.h"
#import "TSHomePageDataController.h"
#import "TSGeneralSearchButton.h"

@interface TSHomeViewController ()<FMCollectionLayoutViewConfigurationDelegate,UICollectionViewDelegate>

/// 数据中心
@property(nonatomic, strong) TSHomePageDataController *dataController;
/// 搜索按钮
@property(nonatomic, strong) TSGeneralSearchButton *searchButton;
/// 分类按钮
@property(nonatomic, strong) UIButton *categoryButton;

@end

@implementation TSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.dataController fetchPlaceholderLayouts];
}

- (void)fillCustomView{
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.categoryButton];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + 10;
    CGFloat top = self.view.ts_safeAreaInsets.top + 6;
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-49);
        make.top.equalTo(self.view).offset(top);
        make.height.mas_equalTo(32);
    }];
    
    [self.categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchButton.mas_right).offset(8);
        make.centerY.equalTo(self.searchButton);
        make.width.height.mas_equalTo(24);
    }];
}

#pragma mark - Action
-(void)searchAction:(TSGeneralSearchButton *)sender{
    
}

-(void)categoryAction:(UIButton *)sender{
    TSCategoryViewController *category = [[TSCategoryViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
}

#pragma mark - Getter
-(TSGeneralSearchButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [TSGeneralSearchButton buttonWithType:UIButtonTypeCustom];
        [_searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

-(UIButton *)categoryButton{
    if (!_categoryButton) {
        _categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryButton setImage:KImageMake(@"mall_home_classification") forState:UIControlStateNormal];
        [_categoryButton setImage:KImageMake(@"mall_home_classification") forState:UIControlStateHighlighted];
        [_categoryButton addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        _categoryButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _categoryButton;
}

-(TSHomePageDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSHomePageDataController alloc] init];
    }
    return _dataController;
}


@end
