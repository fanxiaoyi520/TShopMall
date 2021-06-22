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
#import "TSUniversalCollectionViewCell.h"
#import "TSUniversalFooterView.h"
#import "TSMineNavigationBar.h"
#import "TSSettingViewController.h"
#import "TSOrderManageViewController.h"

@interface TSMineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>

/// 自定义导航栏
@property(nonatomic, strong) TSMineNavigationBar *navigationBar;
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
}

-(void)fillCustomView{

    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.infoView];
    [self.collectionView addSubview:self.setButton];
    [self.view addSubview:self.navigationBar];
    
    CGFloat top = 6;
    
    self.bgImageView.frame = CGRectMake(0, 0, kScreenWidth, 205);
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - GK_TABBAR_HEIGHT);
    self.infoView.frame = CGRectMake(0, 30, kScreenWidth, 60);
    self.setButton.frame = CGRectMake(kScreenWidth - 48, top, 32, 32);
    self.navigationBar.frame = CGRectMake(0, 0, kScreenWidth, GK_STATUSBAR_NAVBAR_HEIGHT);

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self hiddenNavigationBar];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
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
    if (offsetY <= 0) {
        CGRect frame = self.bgImageView.frame;
        frame.size.height = 205 - offsetY;
        self.bgImageView.frame = frame;
        
    } else {
        CGRect frame = self.bgImageView.frame;
        frame.origin.y = -offsetY;
        self.bgImageView.frame = frame;
    }
    
    self.navigationBar.alpha = offsetY / 50.0;
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
    
    if (indexPath.item == 0) {//测试我的订单
        TSOrderManageViewController *orderVc = [[TSOrderManageViewController alloc] init];
        [self.navigationController pushViewController:orderVc animated:YES];
        return;
    }
    
    TSSettingViewController *settingVC = [[TSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
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


#pragma mark - Getter
-(TSMineNavigationBar *)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [[TSMineNavigationBar alloc] init];
        _navigationBar.alpha = 0;
    }
    return _navigationBar;
}

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
