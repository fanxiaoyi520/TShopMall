//
//  TSPaySuccessController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPaySuccessController.h"
#import "TSPaySuccessView.h"
#import "TSPaySuccessDataController.h"
#import "TSRecomendDataController.h"
#import "TSPaySuccessBaseCell.h"

@interface TSPaySuccessController ()<TSPaySucceddCellDelegate>
@property (nonatomic, strong) TSPaySuccessView *collectionView;
@property (nonatomic, strong) TSPaySuccessDataController *dataCon;
@end

@implementation TSPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.collectionView.sections = self.dataCon.sections;
    [self configRecomendView];
}

- (void)setupNavigationBar{
    self.gk_navTitle = @"支付成功";
    self.gk_backImage = KImageMake(@"mall_white_naviback");
    self.gk_navTitleFont = KRegularFont(18);
    self.gk_navTitleColor = KWhiteColor;
    self.gk_navigationBar.gk_navBarBackgroundAlpha = 0;
    self.gk_navigationBar.layer.zPosition = 1;
}

- (void)configRecomendView{
    [TSRecomendDataController checkCurrentRecomendPage:RecomendCartPage finished:^(TSRecomendModel *recomendInfo, TSRecomendPageInfo *pageInfo) {
        if (recomendInfo.goodsList.count != 0) {
            [self.dataCon configRecomendSection:recomendInfo.goodsList isGrid:YES];
            self.collectionView.sections = self.dataCon.sections;
        }
    }];
}

- (void)backToHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goToOrderDetail{
    
}

- (void)recomendGoodsTapped:(TSRecomendGoods *)goods{
    
}

- (void)changeNaviBarBgAlpha:(NSString *)alpha{
    self.gk_navigationBar.gk_navBarBackgroundAlpha = alpha.floatValue;
}

- (TSPaySuccessView *)collectionView{
    if (_collectionView) {
        return _collectionView;
    }
    TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
    self.collectionView = [[TSPaySuccessView alloc] initWithFrame:self.view.frame
                                         collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    flowLayout.delegate = self.collectionView;
    self.collectionView.con = self;
    
    return self.collectionView;
}

- (TSPaySuccessDataController *)dataCon{
    if (_dataCon) {
        return _dataCon;
    }
    self.dataCon = [TSPaySuccessDataController new];
    
    return self.dataCon;
}

@end
