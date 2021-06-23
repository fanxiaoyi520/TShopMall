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

#import "TSMineWalletViewController.h"
#import "TSSettingViewController.h"
#import "TSOrderManageViewController.h"
#import "TSSettingViewController.h"

@interface TSMineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate,TSUserInfoViewDelegate,TSMineOrderHeaderViewDelegate>

/// 背景视图
@property(nonatomic, strong) UIImageView *bgImageView;
/// 设置按钮
@property(nonatomic, strong) UIButton *setButton;
/// 个人信息视图
@property(nonatomic, strong) TSUserInfoView *infoView;
/// CollectionView
@property(nonatomic, strong) UICollectionView *collectionView;

/// 数据中心
@property(nonatomic, strong) TSMineDataController *dataController;

@end

@implementation TSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak __typeof(self)weakSelf = self;
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
                [self.infoView setModel:self.dataController.merchantUserInformationModel];
                [strongSelf.collectionView reloadData];
            }
        }];
    }
}

-(void)fillCustomView{

    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.infoView];
    [self.view addSubview:self.setButton];
    
    CGFloat top = 6 + GK_STATUSBAR_HEIGHT;
    
    self.bgImageView.frame = CGRectMake(0, 0, kScreenWidth, 205);
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - GK_TABBAR_HEIGHT);
    self.infoView.frame = CGRectMake(0, 30, kScreenWidth, 60);
    self.setButton.frame = CGRectMake(kScreenWidth - 48, top, 32, 32);
}

-(void)setupNavigationBar{
    [super setupNavigationBar];
    
    self.gk_navigationBar.alpha = 0;
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setButton setTitle:@"设置" forState:UIControlStateNormal];
    [setButton setTitleColor:KTextColor forState:UIControlStateNormal];
    setButton.titleLabel.font = KRegularFont(14);
    [setButton addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
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

#pragma mark - Action
-(void)setAction:(UIButton *)sender{
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
        frame.size.height = 205 - offsetY;
        self.bgImageView.frame = frame;
        
    } else {
        CGRect frame = self.bgImageView.frame;
        frame.origin.y = -offsetY;
        self.bgImageView.frame = frame;
    }
    self.setButton.alpha = 0.2 - progress;
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
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.item == 0) {//测试我的订单
//        TSOrderManageViewController *orderVc = [[TSOrderManageViewController alloc] init];
//        [self.navigationController pushViewController:orderVc animated:YES];
//        return;
//    }
//
//    TSSettingViewController *settingVC = [[TSSettingViewController alloc] init];
//    [self.navigationController pushViewController:settingVC animated:YES];
    if (indexPath.section == 0) {
        TSOrderManageViewController *orderVc = [[TSOrderManageViewController alloc] init];
        [self.navigationController pushViewController:orderVc animated:YES];
    } else if (indexPath.section == 1) {
        TSMineWalletViewController *vc = [TSMineWalletViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 2) {
        
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

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSMineSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

- (void)universalCollectionViewCellClick:(NSIndexPath *)indexPath params:(NSDictionary *)params {
    NSString *cellType = (NSString *)[params objectForKey:@"cellType"];
    if ([@"TSMineEarningsCell" isEqualToString:cellType]) {
        NSInteger clickType = (NSInteger)[params objectForKey:@"clickType"];
        switch (clickType) {
            case 0:
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

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = KImageMake(@"mall_mine_bg");
    }
    return _bgImageView;
}

-(TSUserInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[TSUserInfoView alloc] initWithRoleType:TSRoleTypePlatinum];
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
