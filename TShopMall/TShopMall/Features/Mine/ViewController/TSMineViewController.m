//
//  TSMineViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSMineViewController.h"
#import "TSMineDataController.h"

#import "TSUserInfoView.h"
#import "TSUniversalFlowLayout.h"
#import "TSMineOrderHeaderView.h"
#import "TSUniversalFooterView.h"
#import "TSMineNavigationBar.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSMineEarningsCell.h"
#import "TSMineLeftBarView.h"

#import "TSMineWalletCenterViewController.h"
#import "TSSettingViewController.h"
#import "TSHybridViewController.h"
#import "TSScoreViewController.h"
#import "TSOfficialServicesViewController.h"
#import "TSInviteFriendsViewController.h"

@interface TSMineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate,TSUserInfoViewDelegate,TSMineOrderHeaderViewDelegate>

/// 背景视图
@property(nonatomic, strong) UIImageView *bgImageView;
/// 设置按钮
@property(nonatomic, strong) UIButton *setButton;
/// 个人信息视图
@property(nonatomic, strong) TSUserInfoView *infoView;
/// CollectionView
@property(nonatomic, strong) UICollectionView *collectionView;
///左边导航view
@property(nonatomic, strong) TSMineLeftBarView *leftBarView;

/// 数据中心
@property(nonatomic, strong) TSMineDataController *dataController;

@end

@implementation TSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    __weak __typeof(self)weakSelf = self;
    RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingBlock:^{
       [weakSelf.dataController fetchDataComplete:^(BOOL isSucess) {
           [weakSelf.collectionView.mj_header endRefreshing];
           [weakSelf.collectionView reloadData];
       }];
   }];
    header.indicatorStyle = IndicatorStyleWhite;
    self.collectionView.mj_header = header;
    
    [self.dataController fetchMineContentsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.collectionView reloadData];
        }
    }];
    
    if ([TSGlobalManager shareInstance].currentUserInfo) {
        __weak __typeof(self)weakSelf = self;
        [self.dataController fetchDataComplete:^(BOOL isSucess) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (isSucess) {
                [strongSelf.infoView setModel:strongSelf.dataController.merchantUserInformationModel];
                [strongSelf.leftBarView.userImg sd_setImageWithURL:[NSURL URLWithString:[TSGlobalManager shareInstance].currentUserInfo.user.avatar]];
                strongSelf.leftBarView.userName.text = [TSGlobalManager shareInstance].currentUserInfo.user.nickname;
                [strongSelf.collectionView reloadData];
            }
        }];
    }
}

-(void)fillCustomView{
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.infoView];
    [self.view addSubview:self.setButton];
    
    CGFloat top = 6 + GK_STATUSBAR_HEIGHT;
    
    self.bgImageView.frame = CGRectMake(0, 0, kScreenWidth, 143 + GK_STATUSBAR_NAVBAR_HEIGHT);
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - GK_TABBAR_HEIGHT);
    self.infoView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT - 5  , kScreenWidth, 90);
    self.setButton.frame = CGRectMake(kScreenWidth - 48, top, 32, 32);
}

-(void)setupNavigationBar{
    [super setupNavigationBar];
    
    self.gk_navigationBar.alpha = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:KImageMake(@"mall_mine_setting") style:UIBarButtonItemStylePlain target:self action:@selector(setAction:)];
    item.tintColor = [UIColor blackColor];
    self.gk_navRightBarButtonItem = item;
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBarView];
    
}

#pragma mark - Noti
- (void)loginStateDidChanged:(NSNotification *)noti{
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchMineContentsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (void)userInfoUpdated{
    [self.collectionView reloadData];
    [self.infoView setModel:self.dataController.merchantUserInformationModel];
}

#pragma mark - Action
-(void)setAction:(UIButton *)sender{
    
//    NSString *path = @"http://10.68.245.26:8080/seller-app-h5/pages/bridgeDemo/index";
//    TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
//    [self.navigationController pushViewController:hybrid animated:YES];
//    return;
    
    
    
    TSSettingViewController *settingVC = [[TSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = ceil(scrollView.contentOffset.y);
    CGFloat progress = offsetY / GK_STATUSBAR_NAVBAR_HEIGHT;
    self.gk_navigationBar.alpha = progress;
    if (offsetY <= 0) {
        CGRect frame = self.bgImageView.frame;
//        frame.origin.y +=  offsetY;
        frame.size.height = 143 + GK_STATUSBAR_NAVBAR_HEIGHT - offsetY;
        self.bgImageView.frame = frame;

    } else {
        CGRect frame = self.bgImageView.frame;
        frame.size.height = 143 + GK_STATUSBAR_NAVBAR_HEIGHT;
        frame.origin.y = -offsetY;
        self.bgImageView.frame = frame;
    }
    if (progress > 0) {
        self.setButton.alpha = 0.2 - progress;
    } else {
        self.setButton.alpha = 1;
    }
   
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSMineSectionModel *model = self.dataController.sections[indexPath.section];
    TSMineSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.cellSuperViewCollectionView = self.collectionView;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSMineSectionModel *model = self.dataController.sections[indexPath.section];
    
    if ([model.headerName isEqualToString: @"订单"]) {
        TSMineSectionOrderItemModel *item = (TSMineSectionOrderItemModel *)model.items[indexPath.row];
        if ([item.title isEqualToString: @"待付款"]) {
            NSString *path = [NSString stringWithFormat:@"%@%@?&orderType=%@&orderState=%@",kMallH5ApiPrefix,kMallH5OrderManageUrl,@"1",@"1"];
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            [self.navigationController pushViewController:hybrid animated:YES];
        } else if ([item.title isEqualToString: @"待发货"]) {
            NSString *path = [NSString stringWithFormat:@"%@%@?&orderType=%@&orderState=%@",kMallH5ApiPrefix,kMallH5OrderManageUrl,@"1",@"4"];
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            [self.navigationController pushViewController:hybrid animated:YES];
        } else if ([item.title isEqualToString: @"待收货"]) {
            NSString *path = [NSString stringWithFormat:@"%@%@?&orderType=%@&orderState=%@",kMallH5ApiPrefix,kMallH5OrderManageUrl,@"1",@"6"];
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            [self.navigationController pushViewController:hybrid animated:YES];
        } else if ([item.title isEqualToString: @"已完成"]) {
            
            NSString *path = [NSString stringWithFormat:@"%@%@?&orderType=%@&orderState=%@",kMallH5ApiPrefix,kMallH5OrderManageUrl,@"1",@"7"];
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            [self.navigationController pushViewController:hybrid animated:YES];
        } else if ([item.title isEqualToString: @"退款/退货"]) {
            NSString *path = [NSString stringWithFormat:@"%@%@",kMallH5ApiPrefix,kMallH5RefundManageUrl];
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            [self.navigationController pushViewController:hybrid animated:YES];
        }
    }
   
    if ([model.headerName isEqualToString: @"更多服务"]) {
        TSMineSectionOrderItemModel *item = (TSMineSectionOrderItemModel *)model.items[indexPath.row];
        
        if ([item.title isEqualToString: @"合伙人中心"]) {
            NSString *path = @"https://testwap.tclo2o.cn/seller-app-h5/pages/mine/index";
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            [self.navigationController pushViewController:hybrid animated:YES];
           
        }else if ([item.title isEqualToString: @"官方服务"]) {
            TSOfficialServicesViewController *vc = [TSOfficialServicesViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([item.title isEqualToString: @"在线客服"]) {
            NSString *url = @"https://wap.service.tcl.com/web/index.php?apps=thome";
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:url];
            [self.navigationController pushViewController:hybrid animated:YES];
           
        } else if ([item.title isEqualToString: @"发票管理"]) {
            NSString *path = [NSString stringWithFormat:@"%@%@",kMallH5ApiPrefix,kMallH5InvoiceListUrl];
            TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
            hybrid.isInvoice = YES;
            [self.navigationController pushViewController:hybrid animated:YES];
        } else if ([item.title isEqualToString: @"地址管理"]) {
            UIViewController *con = [NSClassFromString(@"TSShippingAddressController") new];
            [self.navigationController pushViewController:con animated:YES];
        } else if ([item.title isEqualToString: @"去评分"]) {
            TSScoreViewController *vc = [TSScoreViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([item.title isEqualToString: @"站点设置"]) {
            
#ifdef DEBUG

            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"站点设置" message:[NSString stringWithFormat:@"当前站点：%@",kMallH5ApiPrefix] preferredStyle:UIAlertControllerStyleAlert];
            [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.text = @"";
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                kMallH5ApiPrefix = alertVc.textFields.firstObject.text;
            }];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
               
            }] ;
            [alertVc addAction:cancle];
            [alertVc addAction:confirm];
            [self presentViewController:alertVc animated:true completion:nil];


#endif
            

        }
    }
    
    //邀请好友
    if ([model.headerName isEqualToString: @"邀请"]) {
        TSMineSectionAdsItemModel *item = (TSMineSectionAdsItemModel *)model.items.firstObject;
        NSString *uri = [[TSServicesManager sharedInstance].uriHandler configUriWithTypeValue:item.imageAdModel.linkData.typeValue objectValue:item.imageAdModel.linkData.objectValue];
        [[TSServicesManager sharedInstance].uriHandler openURI:uri];
        NSLog(@"uri:%@",uri);
        
//        TSInviteFriendsViewController *vc = [TSInviteFriendsViewController new];
//        vc.salesmanUuid = self.dataController.merchantUserInformationModel.ucUuid;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //我的钱包
    if ([model.headerName isEqualToString: @"我的收益"]) {
        TSMineWalletCenterViewController *vc = [TSMineWalletCenterViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    TSMineSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class className = NSClassFromString(sectionModel.headerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:sectionModel.headerIdentify];
        TSMineOrderHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.headerIdentify forIndexPath:indexPath];
        [header bindMineSectionModel:sectionModel];
        if ([sectionModel.headerIdentify isEqualToString:@"TSMineOrderHeaderView"]) {
            header.kDelegate = self;
        }
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

#pragma mark - mineOrderHeaderMoreAction
-(void)mineOrderHeaderMoreAction:(id _Nullable)sender{
    NSString *path = [NSString stringWithFormat:@"%@%@?orderType=1",kMallH5ApiPrefix,kMallH5OrderManageUrl];
    TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
    [self.navigationController pushViewController:hybrid animated:YES];
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSMineSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    if ([sectionModel.items[indexPath.row].identify isEqualToString: @"TSMineEarningsCell"]) {
        return  self.dataController.earningModel;
    } else if ([sectionModel.items[indexPath.row].identify isEqualToString: @"TSMinePartnerCenterCell"]) {
        return  self.dataController.partnerCenterDataModel;
    } else if ([sectionModel.items[indexPath.row].identify isEqualToString: @"TSMineAdsCell"]) {
        return  sectionModel.items.firstObject;
    }   else {
        return sectionModel.items[indexPath.row];
    }
    
}

- (void)universalCollectionViewCellClick:(NSIndexPath *)indexPath params:(NSDictionary *)params {
    NSString *cellType = (NSString *)[params objectForKey:@"cellType"];
    if ([@"TSMineEarningsCell" isEqualToString:cellType]) {
        NSInteger clickType = (NSInteger)[params objectForKey:@"clickType"];
        switch (clickType) {
            case 0:
        self.dataController.earningModel.eyeIsOn = ! self.dataController.earningModel.eyeIsOn;
            break;
        }
    }else if ([@"TSMinePartnerCenterCell" isEqualToString:cellType]){
        switch ([params[@"clickType"] integerValue] ) {
            case 0:
                self.dataController.partnerCenterDataModel.eyeIsOn = !self.dataController.partnerCenterDataModel.eyeIsOn;
             break;
            default:
            {
                NSString *path = [NSString stringWithFormat:@"%@%@",kMallH5ApiPrefix,kMallH5CopartnerUrl];
                TSHybridViewController *hybrid = [[TSHybridViewController alloc] initWithURLString:path];
                [self.navigationController pushViewController:hybrid animated:YES];
            }
                break;
        }
       
    }
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSMineSectionModel *model = self.dataController.sections[indexPath.section];
    TSMineSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    TSMineSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    TSMineSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
    TSMineSectionModel *model = self.dataController.sections[section.section];
    return model.docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    TSMineSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    TSMineSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

#pragma mark - TSUserInfoViewDelegate
-(void)userInfoLoginAction:(id _Nullable)sender {
    
}
-(void)userInfoSeeCodeAction:(id _Nullable)sender {
    self.dataController.merchantUserInformationModel.eyeIsOn = !self.dataController.merchantUserInformationModel.eyeIsOn;
}

- (void)userInfoKCopyCodeAction:(id _Nullable)sender {
    UIPasteboard *pab = (UIPasteboard *)sender;
    if (pab) {
        [self.collectionView makeToast:@"复制成功" duration:2.0 position:CSToastPositionBottom];
    } else {
        [self.collectionView makeToast:@"复制失败" duration:2.0 position:CSToastPositionBottom];
    }
}

#pragma mark - TSMineOrderHeaderViewDelegate
- (void)moreAction:(id)sender {
    NSLog(@"查看全部订单");
}

#pragma mark - Getter
-(UIButton *)setButton{
    if (!_setButton) {
        _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setButton setImage:KImageMake(@"mall_mine_setting") forState:UIControlStateNormal];
        [_setButton setImage:KImageMake(@"mall_mine_setting") forState:UIControlStateHighlighted];
        [_setButton addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
        _setButton.imageView.contentMode = UIViewContentModeCenter;
    }
    
    return _setButton;
}

-(TSMineLeftBarView *)leftBarView{
    if (!_leftBarView) {
        _leftBarView = [[TSMineLeftBarView  alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 44)];
    }
    return _leftBarView;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = KImageMake(@"mall_mine_bg");
        _bgImageView.contentMode = UIViewContentModeRedraw;
    }
    return _bgImageView;
}

-(TSUserInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[TSUserInfoView alloc] init];
        _infoView.kDelegate = self; 
    }
    return _infoView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}

-(TSMineDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}

@end
