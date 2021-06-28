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
#import "TSUniversalCollectionViewCell.h"
#import "TSMaterialImageCell.h"
#import "TSProductDetailHeaderView.h"
#import "TSUniversalFooterView.h"
#import "WMDragView.h"
#import "TSTopFunctionView.h"
#import "TSGoodDetailMaterialView.h"
#import "TSChangePriceView.h"
#import "TSDetailShareView.h"
#import "TSGoodDetailSkuView.h"
#import "SnailQuickMaskPopups.h"
#import "TSGoodDetailMaterialView.h"
#import "TSConventionAlertView.h"
#import "TSHybridViewController.h"
#import "TSCartViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <Photos/Photos.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "WechatShareManager.h"
#import "TSAreaSelectedController.h"
#import "TSMakeOrderController.h"

@interface TSProductDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate,TSTopFunctionViewDelegate,TSChangePriceViewDelegate,ProductDetailBottomViewDelegate,SnailQuickMaskPopupsDelegate,GoodDetailMaterialViewDelegate, TSDetailShareViewDelegate,GoodDetailSkuViewDelegate>

/// 导航栏上的购物车按钮
@property(nonatomic, strong) UIButton *topCartBtn;
/// 悬浮购物车按钮
@property(nonatomic, strong) UIButton *cartButton;
/// 悬浮返回按钮
@property(nonatomic, strong) UIButton *backButton;
/// 悬浮分享按钮
@property(nonatomic, strong) UIButton *shareButton;

/// CollectionView
@property(nonatomic, strong) UICollectionView *collectionView;

/// 底部视图
@property(nonatomic, strong) TSProductDetailBottomView *bottomView;
/// 拖拽（热卖）
@property(nonatomic,strong)WMDragView *dragView;

@property(nonatomic, strong) NSArray *materials;

/// 更多功能Popups
@property(nonatomic, strong) SnailQuickMaskPopups *functionPopups;
/// 功能视图
@property(nonatomic, strong) TSTopFunctionView *functionView;

/// 改价Popups
@property(nonatomic, strong) SnailQuickMaskPopups *changePopups;
/// 改价视图
@property(nonatomic, strong) TSChangePriceView *changeView;

/// 分享Popups
@property (nonatomic, strong) SnailQuickMaskPopups *sharePopups;
/// 分享视图
@property(nonatomic, strong) TSDetailShareView *shareView;

/// skuviewPopups
@property (nonatomic, strong) SnailQuickMaskPopups *skuPpopups;
/// skuview视图
@property(nonatomic, strong) TSGoodDetailSkuView *skuView;

/// 下载更多Popups
@property (nonatomic, strong) SnailQuickMaskPopups *materialPopups;
/// 下载更多视图
@property(nonatomic, strong) TSGoodDetailMaterialView *materialView;

/// 数据中心
@property(nonatomic, strong) TSProductDetailDataController *dataController;

@end

@implementation TSProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_group_t group = dispatch_group_create();
    
    //商品详情
    NSMutableArray *sections = [self.dataController fetchProductDetailWithUuid:self.uuid
                                                           isRequireEnterGroup:YES
                                                                         group:group
                                                                      complete:^(BOOL isSucess) {
            
    }];
    
    if (sections.count > 0) {
        [self.collectionView reloadData];
    }
    
    //购物车角标
    [self.dataController fetchProductDetailCartNumberIsRequireEnterGroup:YES
                                                                   group:group
                                                                complete:^(BOOL isSucess) {
            
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self.topCartBtn setBadgeValue:self.dataController.cartNumber];
    });
    
    __weak __typeof(self)weakSelf = self;
    self.dragView.clickDragViewBlock = ^(WMDragView *dragView){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.changePopups presentAnimated:YES completion:nil];
    };
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(void)setupNavigationBar{
    // 设置导航栏透明
    self.gk_navigationBar.alpha = 0;
    self.gk_navTitle = @"商品详情页";
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:KImageMake(@"mall_detail_navigation_share") forState:UIControlStateNormal];
    [shareBtn setImage:KImageMake(@"mall_detail_navigation_share") forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.frame = CGRectMake(0, 0, 30, 30);
    
    UIButton *cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartBtn setImage:KImageMake(@"mall_detail_navigation_cart") forState:UIControlStateNormal];
    [cartBtn setImage:KImageMake(@"mall_detail_navigation_cart") forState:UIControlStateHighlighted];
    [cartBtn addTarget:self action:@selector(cartAction:) forControlEvents:UIControlEventTouchUpInside];
    cartBtn.frame = CGRectMake(0, 0, 30, 30);
    [cartBtn setBadgeBGColor:UIColor.redColor];
    [cartBtn setBadgeOriginX:17];
    [cartBtn setBadgeTextColor:UIColor.whiteColor];
    [cartBtn setShouldAnimateBadge:YES];
    self.topCartBtn = cartBtn;
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    UIBarButtonItem *cart = [[UIBarButtonItem alloc] initWithCustomView:cartBtn];
    self.gk_navRightBarButtonItems = @[share,cart];
}

-(void)fillCustomView{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.cartButton];
    [self.view addSubview:self.dragView];
    [self addConstraints];
    [self addMJHeaderAndFooter];
}

- (void)addConstraints {
    CGFloat top = GK_STATUSBAR_HEIGHT + 6;//self.view.ts_safeAreaInsets.top + KRateH(6);
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + KRateH(54);
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(bottom);
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top).offset(0);
    }];

    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(KRateW(16));
        make.top.equalTo(self.view).offset(top);
        make.width.height.mas_equalTo(32);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-KRateW(16));
        make.top.equalTo(self.view).offset(top);
        make.width.height.mas_equalTo(32);
    }];

    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareButton.mas_left).offset(-KRateW(6));
        make.top.equalTo(self.view).offset(top);
        make.width.height.mas_equalTo(32);
    }];
    ///解决collectionView 往下滑的问题
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)addCollectionCoverView{
    
    CGFloat coverViewX = 0;
    CGFloat coverViewY = -kScreenHeight;
    CGFloat coverViewW = kScreenWidth;
    CGFloat coverViewH = kScreenHeight;
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH)];
    coverView.backgroundColor = KGrayColor;
    [self.collectionView addSubview:coverView];
    [self.collectionView sendSubviewToBack:coverView];
}

/// 添加MJ刷新控件
- (void)addMJHeaderAndFooter {
    //默认【下拉刷新】
    RefreshGifHeader *mj_header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeadreRefresh:)];
    if (GK_STATUSBAR_HEIGHT > 20) {
        mj_header.loadingOffsetTop = 30;
    }
    self.collectionView.mj_header = mj_header;
}

#pragma mark - Actions
-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareAction:(UIButton *)sender{
    [self.functionPopups presentAnimated:YES completion:NULL];
}

-(void)cartAction:(UIButton *)sender{
    TSCartViewController *cart = [[TSCartViewController alloc] init];
    [self.navigationController pushViewController:cart animated:YES];
}

/// 下拉刷新
- (void)mjHeadreRefresh:(MJRefreshNormalHeader *)mj_header {
//    __weak __typeof(self)weakSelf = self;
//    [self.dataController fetchProductDetailWithUuid:self.uuid complete:^(BOOL isSucess) {
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        if (isSucess) {
//            [strongSelf.collectionView.mj_header endRefreshing];
//            [strongSelf.collectionView reloadData];
//        }
//    }];
}

#pragma mark - GoodDetailSkuViewDelegate
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView addShoppingCart:(UIButton *)addButton buyNum:(NSString *)buyNum{
    [self.dataController fetchProductDetailAddProductToCart:self.dataController.productUuid
                                                     buyNum:@"1"
                                                     attrId:self.dataController.attrId
                                                   complete:^(BOOL isSucess) {
            
    }];
}
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView buyImmediately:(UIButton *)buyButton buyNum:(NSString *)buyNum{
    NSLog(@"----");
}
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView specificationExchange:(NSDictionary *)detail{
    NSLog(@"----");
}
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView numberChange:(NSString *)currentNumber{
    NSLog(@"----");
}

#pragma mark - SnailQuickMaskPopupsDelegate
- (void)snailQuickMaskPopupsWillDismiss:(SnailQuickMaskPopups *)popups{
    if (self.materialPopups == popups) {
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:3]];
    }
}

#pragma mark - TSTopFunctionViewDelegate
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView closeClick:(UIButton *_Nonnull)sender{
    [self.functionPopups dismissAnimated:YES completion:nil];
}
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView changeClick:(TSFuncButton *_Nonnull)sender{
    __weak __typeof(self)weakSelf = self;
    [self.functionPopups dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.changePopups presentInView:strongSelf.view animated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
            
        }];
    }];
}
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView shareClick:(TSFuncButton *_Nonnull)sender{
    __weak __typeof(self)weakSelf = self;
    [self.functionPopups dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.sharePopups presentAnimated:YES completion:nil];
    }];
}
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView downloadClick:(TSFuncButton *_Nonnull)sender{
    __weak __typeof(self)weakSelf = self;
    [self.functionPopups dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.materialPopups = [strongSelf materialPopupsModels:strongSelf.dataController.materialModels];
        [strongSelf.materialPopups presentAnimated:YES completion:nil];
    }];
}
     
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView sharePosterClick:(TSFuncButton *_Nonnull)sender{
        
}

#pragma mark - ProductDetailBottomViewDelegate
-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView mallClick:(TSDetailFunctionButton *_Nullable)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}
-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView customClick:(TSDetailFunctionButton *_Nullable)sender{
    TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:@"http://www.baidu.com"];
    [self.navigationController pushViewController:hybrid animated:YES];
}
-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView addClick:(TSDetailFunctionButton *_Nullable)sender{
    
    if ([TSUserLoginManager shareInstance].state == TSLoginStateNone) {
        [[TSUserLoginManager shareInstance] startLogin];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchProductDetailAddProductToCart:self.dataController.productUuid
                                                     buyNum:@"1"
                                                     attrId:self.dataController.attrId
                                                   complete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSLog(@"---");
        
    }];
}

-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView buyClick:(UIButton *_Nullable)sender{
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchProductDetailCustomBuy:@""
                                            complete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            TSMakeOrderController *order = [[TSMakeOrderController alloc] init];
            [strongSelf.navigationController pushViewController:order animated:YES];
        }
    }];
}
-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView sellClick:(UIButton *_Nullable)sender{
    
}

#pragma mark - GoodDetailMaterialViewDelegate
-(void)goodDetailMaterialView:(TSGoodDetailMaterialView *_Nullable)materialView downloadClick:(UIButton *_Nullable)sender{
    for (TSMaterialImageModel *model in self.materials) {
        if (model.selected && model.materialImage) {
            UIImageWriteToSavedPhotosAlbum(model.materialImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

#pragma mark - TSChangePriceViewDelegate
-(void)changePriceView:(TSChangePriceView *_Nullable)changePriceView closeClick:(UIButton *_Nonnull)sender{
    [self.view endEditing:YES];
    [self.changePopups dismissAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat progress = offsetY / GK_STATUSBAR_NAVBAR_HEIGHT;
    CGFloat diff = 1.0 - progress;
    if (diff < 0) {
        self.backButton.alpha = 0;
        self.shareButton.alpha = 0;
        self.cartButton.alpha = 0;
    }else{
        self.backButton.alpha = diff;
        self.shareButton.alpha = diff;
        self.cartButton.alpha = diff;
    }
    self.gk_navigationBar.alpha = progress;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSGoodDetailSectionModel *model = self.dataController.sections[indexPath.section];
    TSGoodDetailItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    TSGoodDetailSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class className = NSClassFromString(sectionModel.headerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:sectionModel.headerIdentify];
        TSProductDetailHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.headerIdentify forIndexPath:indexPath];
        return header;
    }else{
        Class className = NSClassFromString(sectionModel.footerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:sectionModel.footerIdentify];
        TSUniversalBottomFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.footerIdentify forIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSGoodDetailSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    TSGoodDetailItemModel *item = sectionModel.items[indexPath.row];
    if ([item isKindOfClass:[TSGoodDetailItemDownloadImageModel class]]) {
        TSGoodDetailItemDownloadImageModel *maItem = (TSGoodDetailItemDownloadImageModel *)item;
        self.materials = maItem.materialModels;
    }
    return item;
}

-(void)universalCollectionViewCellClick:(NSIndexPath *)indexPath
                                 params:(NSDictionary *)params{
    
    if ([@"TSGoodDetailImageCell" isEqualToString:params[@"cellType"]]) {
        NSArray *models = params[@"models"];
        if ([params[@"downloadType"] intValue] == 0) {//下载更多素材
            self.materialPopups = [self materialPopupsModels:models];
            [self.materialPopups presentAnimated:YES completion:nil];
            [self.materialView reloadMaterialView];
        } else {// 直接下载素材,保存图片到相册
            
            for (TSMaterialImageModel *model in self.materials) {
                if (model.selected && model.materialImage) {
                    UIImageWriteToSavedPhotosAlbum(model.materialImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                }
            }
        }
    }else if ([@"TSProductDetailPurchaseCell" isEqualToString:params[@"cellType"]]){
        if ([params[@"purchaseType"] intValue] == 0) {//赠品
            
        } else if ([params[@"purchaseType"] intValue] == 1){//已选
            TSGoodDetailSectionModel *section = self.dataController.sections[5];
            [self.skuPpopups presentAnimated:YES completion:NULL];
            self.skuView.purchaseModel = (TSGoodDetailItemPurchaseModel *)[section.items firstObject];
        } else if ([params[@"purchaseType"] intValue] == 2){//配送
            [TSAreaSelectedController showAreaSelected:^(TSAreaModel *provice, TSAreaModel *city, TSAreaModel *eare, TSAreaModel *street, NSString *location) {
                
                NSLog(@"-----");
                
            } OnController:self];
            
        }else{//运费
            [TSAreaSelectedController showAreaSelected:^(TSAreaModel *provice, TSAreaModel *city, TSAreaModel *eare, TSAreaModel *street, NSString *location) {
                
                NSLog(@"-----");
                
            } OnController:self];
        }
    }
    
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSGoodDetailSectionModel *model = self.dataController.sections[indexPath.section];
    TSGoodDetailItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    TSGoodDetailSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    TSGoodDetailSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section.section];
    return model.docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    TSGoodDetailSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    TSGoodDetailSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

#pragma mark - TSDetailShareViewDelegate
- (void)shareViewView:(UIView *)view closeClick:(UIButton *)sender{
    [self.sharePopups dismissAnimated:YES completion:nil];
}

- (void)shareViewView:(UIView *)view shareFriendsAction:(UIButton *)sender{
    [[WechatShareManager shareInstance] shareWXWithTitle:@"标题" andDescription:@"描述" andShareURL:@"http://www.baidu.com" andThumbImage:nil andWXScene:WechatShareTypeFriends];
}

- (void)shareViewView:(UIView *)view sharePYQAction:(UIButton *)sender{
}

- (void)shareViewView:(UIView *)view downloadAction:(UIButton *)sender{
    
}

#pragma mark - Private
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error  contextInfo:(void *)contextInfo{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (error) {
        TSConventionAlertView *alert =   [TSConventionAlertView tcl_alertViewWithTitle:@"存储失败" message:@"请打开 设置-隐私-照片 来进行设置" preferredStyle:TCLAlertViewStyleAlert msgFont:KRegularFont(16.0) widthMargin:16.0 highlightedText:@"" hasPrefixStr:@"" highlightedColor:KTextColor];
        TSConventionAlertItem  *sureAlert  = [TSConventionAlertItem tcl_itemWithTitle:@"确定"  titleColor:KTextColor style:TCLAlertItemStyleDefault handler:^(TSConventionAlertItem *item) {}];
        [alert tcl_addAlertItem:sureAlert];
        [alert tcl_showView];
    }else{
        [Popover popToastOnWindowWithText:@"保存成功"];
    }
}

#pragma mark - Getter
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:KImageMake(@"mall_productDetail_back") forState:UIControlStateNormal];
        [_backButton setImage:KImageMake(@"mall_productDetail_back") forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:KImageMake(@"mall_productDetail_share") forState:UIControlStateNormal];
        [_shareButton setImage:KImageMake(@"mall_productDetail_share") forState:UIControlStateHighlighted];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

-(UIButton *)cartButton{
    if (!_cartButton) {
        _cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cartButton setImage:KImageMake(@"mall_productDetail_cart") forState:UIControlStateNormal];
        [_cartButton setImage:KImageMake(@"mall_productDetail_cart") forState:UIControlStateHighlighted];
        [_cartButton addTarget:self action:@selector(cartAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cartButton;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = KGrayColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(TSProductDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[TSProductDetailBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

-(WMDragView *)dragView{
    if (!_dragView) {
        _dragView = [[WMDragView alloc] initWithFrame:CGRectMake(kScreenWidth - 94, 230, 80, 77)];
        _dragView.backgroundColor = UIColor.clearColor;
        _dragView.dragEnable = YES;
        _dragView.isKeepBounds = YES;
        [_dragView.button setImage:KImageMake(@"mall_detail_ hover_sell") forState:UIControlStateNormal];
        [_dragView.button setImage:KImageMake(@"mall_detail_ hover_sell") forState:UIControlStateHighlighted];
    }
    return _dragView;
}

-(TSProductDetailDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSProductDetailDataController alloc] init];
        _dataController.context = self;
    }
    return _dataController;
}

- (SnailQuickMaskPopups *)functionPopups{
    if (!_functionPopups) {
        TSTopFunctionView *functionView = [[TSTopFunctionView alloc] init];
        functionView.frame = CGRectMake(0, 0, kScreenWidth, 168);
        [functionView setCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) radius:8.0];
        functionView.delegate = self;
        functionView.clipsToBounds = YES;
        self.functionView = functionView;
        
        _functionPopups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:functionView];
        _functionPopups.presentationStyle = PresentationStyleTop;
        _functionPopups.transitionStyle = TransitionStyleFromTop;
        _functionPopups.isAllowPopupsDrag = YES;
        _functionPopups.maskAlpha = 0.8;
    }
    return  _functionPopups;
}

- (SnailQuickMaskPopups *)changePopups{
    if (!_changePopups) {
        TSChangePriceView *changeView = [[TSChangePriceView alloc] init];
        changeView.frame = CGRectMake(0, 0, kScreenWidth, 450);
        [changeView setCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:8.0];
        changeView.clipsToBounds = YES;
        changeView.delegate = self;
        self.changeView = changeView;
        
        _changePopups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:changeView];
        _changePopups.presentationStyle = PresentationStyleBottom;
        _changePopups.transitionStyle = TransitionStyleFromBottom;
        _changePopups.isAllowPopupsDrag = YES;
        _changePopups.maskAlpha = 0.8;
    }
    return  _changePopups;
}

-(SnailQuickMaskPopups *)sharePopups{
    if (!_sharePopups) {
        TSDetailShareView *shareView = [[TSDetailShareView alloc] init];
        shareView.delegate = self;
        shareView.frame = CGRectMake(0, 0, kScreenWidth, 180);
        [shareView setCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:8.0];
        shareView.clipsToBounds = YES;
        shareView.delegate = self;
        self.shareView = shareView;
        
        _sharePopups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:shareView];
        _sharePopups.presentationStyle = PresentationStyleBottom;
        _sharePopups.transitionStyle = TransitionStyleFromBottom;
        _sharePopups.isAllowPopupsDrag = YES;
        _sharePopups.maskAlpha = 0.8;
    }
    return  _sharePopups;
}

-(SnailQuickMaskPopups *)skuPpopups{
    if (!_skuPpopups) {
        TSGoodDetailSkuView *skuView = [[TSGoodDetailSkuView alloc] init];
        skuView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.68);
        [skuView setCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:8.0];
        skuView.clipsToBounds = YES;
        skuView.delegate = self;
        self.skuView = skuView;
        
        _skuPpopups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:skuView];
        _skuPpopups.presentationStyle = PresentationStyleBottom;
        _skuPpopups.transitionStyle = TransitionStyleFromRight;
        _skuPpopups.isAllowPopupsDrag = YES;
        _skuPpopups.maskAlpha = 0.8;
    }
    return _skuPpopups;
}

-(SnailQuickMaskPopups *)materialPopupsModels:(NSArray <TSMaterialImageModel *> *)models{
    if (!_materialPopups) {
        TSGoodDetailMaterialView *materialView = [[TSGoodDetailMaterialView alloc] initWithMaterialModels:models];
        materialView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.6);
        [materialView setCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:8.0];
        materialView.clipsToBounds = YES;
        materialView.delegate = self;
        self.materialView = materialView;
        
        _materialPopups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:materialView];
        _materialPopups.presentationStyle = PresentationStyleBottom;
        _materialPopups.transitionStyle = TransitionStyleFromRight;
        _materialPopups.isAllowPopupsDrag = YES;
        _materialPopups.delegate = self;
        _materialPopups.maskAlpha = 0.8;
    }
    return _materialPopups;
}

@end
