//
//  TSPaySuccessViewController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSPaySuccessViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSPaySuccessDataController.h"

@interface TSPaySuccessViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>

/// 数据中心
@property(nonatomic, strong) TSPaySuccessDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;
/** 释放需要导航栏和状态栏  */
@property(nonatomic, assign) BOOL updateDefaultStatus;

@end

@implementation TSPaySuccessViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.gk_navTitle = @"支付成功";
    self.updateDefaultStatus = NO;
    self.gk_navTitleColor = KWhiteColor;
    self.gk_navigationBar.gk_navBarBackgroundAlpha = 0;
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchPaySuccessComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (void)fillCustomView {
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(self.view.ts_safeAreaInsets.bottom);
    }];
}

- (UIView *)listView {
    return self.view;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.updateDefaultStatus == NO) {
        self.gk_backImage = KImageMake(@"mall_white_naviback");
        self.gk_navTitleColor = KWhiteColor;
        return UIStatusBarStyleLightContent;
    } else {
        self.gk_backImage = KImageMake(@"navi_back");
        self.gk_navTitleColor = KTextColor;
    }
    return UIStatusBarStyleDefault;
}

#pragma mark - Getter

- (TSPaySuccessDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSPaySuccessDataController alloc] init];
    }
    return _dataController;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.backgroundColor = KGrayColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSPaySuccessSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSPaySuccessSectionModel *model = self.dataController.sections[indexPath.section];
    TSPaySuccessSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSPaySuccessSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSPaySuccessSectionModel *model = self.dataController.sections[indexPath.section];
    TSPaySuccessSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSPaySuccessSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSPaySuccessSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    TSPaySuccessSectionModel *model = self.dataController.sections[section];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    TSPaySuccessSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSPaySuccessSectionModel *model = self.dataController.sections[section];
    return model.sectionInset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat maxAlphaOffset = 176 - GK_STATUSBAR_NAVBAR_HEIGHT;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = offset / maxAlphaOffset;
    if (alpha < 0) {
        alpha = -alpha;
    }
    if (alpha >= 1.0) {
        alpha = 1.0;
        if (self.updateDefaultStatus == NO) {
            self.updateDefaultStatus = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else {
        if (self.updateDefaultStatus) {
            self.updateDefaultStatus = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    self.gk_navigationBar.gk_navBarBackgroundAlpha = alpha;
}

@end
