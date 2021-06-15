//
//  TSProductDetailController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailController.h"
#import "TSProductDetailNavigationBar.h"
#import "TSProductDetailBottomView.h"
#import "TSUniversalFlowLayout.h"
#import "TSProductDetailDataController.h"

@interface TSProductDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UniversalFlowLayoutDelegate>

/// 自定义导航栏
@property(nonatomic, strong) TSProductDetailNavigationBar *navigationBar;
/// CollectionView
@property(nonatomic, strong) UICollectionView *collectionView;
/// 底部视图
@property(nonatomic, strong) TSProductDetailBottomView *bottomView;

@end

@implementation TSProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)fillCustomView{
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + 54;
    
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_offset(GK_STATUSBAR_NAVBAR_HEIGHT);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(bottom);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.bottomView.mas_top).offset(0);
    }];
}


#pragma mark - Getter
-(TSProductDetailNavigationBar *)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [[TSProductDetailNavigationBar alloc] init];
    }
    return _navigationBar;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
//        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(TSProductDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[TSProductDetailBottomView alloc] init];
    }
    return _bottomView;
}

@end
