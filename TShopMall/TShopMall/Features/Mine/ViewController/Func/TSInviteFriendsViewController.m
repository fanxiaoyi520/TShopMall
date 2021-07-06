//
//  TSInviteFriendsViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/27.
//
#define HEADERVIEW_HEIGHT (400+286+56+43)
#import "TSInviteFriendsViewController.h"
#import "TSInviteFriendsHeader.h"
#import "TSUniversalFlowLayout.h"
#import "TSInviteFriendsDataController.h"
#import "TSInviteFriendsSectionModel.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSUniversalFooterView.h"
@interface TSInviteFriendsViewController ()<UICollectionViewDataSource,UniversalFlowLayoutDelegate,UICollectionViewDelegate,UniversalCollectionViewCellDataDelegate>

@property (nonatomic ,strong) UICollectionView *collectionView;
/// 数据中心
@property(nonatomic, strong) TSInviteFriendsDataController *dataController;
@end

@implementation TSInviteFriendsViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"邀请好友";
    RefreshGifFooter *footer = [RefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer = footer;
    MJWeakSelf
    [self.dataController configureDataSource];
    [self.dataController fetchInvitationCode];
    [self.dataController fetchInvitationRecord];
    
    self.dataController.updateUI = ^{
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (weakSelf.dataController.isNoMore) {
            [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.collectionView reloadData];
    };
    
}

- (void)fillCustomView {
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight-GK_STATUSBAR_NAVBAR_HEIGHT);
  
}

-(void)loadMore {
    self.dataController.pageNo += 1;
    [self.dataController fetchInvitationRecord];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.rowsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSInviteFriendsSectionModel *model = self.dataController.sections[indexPath.section];
    Class className = NSClassFromString(model.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:model.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
    TSInviteFriendsSectionModel *model = self.dataController.sections[indexPath.section];
    if ([model.identify isEqualToString:@"TSInviteFriendsShareCell"]) {
        [self.dataController shareWithType:indexPath.row];
    }
    }
   

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    TSInviteFriendsSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class className = NSClassFromString(sectionModel.headerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:sectionModel.headerIdentify];
        TSInviteFriendsHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.headerIdentify forIndexPath:indexPath];
        header.dataControl = self.dataController;
        [header setCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:8];
        return header;
    }else{
        Class className = NSClassFromString(sectionModel.footerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:sectionModel.footerIdentify];
        TSUniversalFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.footerIdentify forIndexPath:indexPath];
        return footer;
    }
}

 

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSInviteFriendsSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    if (sectionModel.dataSource.count < indexPath.row + 1) {
        return  nil;
    }
    return sectionModel.dataSource[indexPath.row] ;
}

- (void)universalCollectionViewCellClick:(NSIndexPath *)indexPath params:(NSDictionary *)params {
   
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSInviteFriendsSectionModel *model = self.dataController.sections[indexPath.section];
    return model.cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    TSInviteFriendsSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    TSInviteFriendsSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section.section];
    return model.docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    TSInviteFriendsSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    TSInviteFriendsSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}
// MARK: TSInviteFriendsDelegate
- (void)inviteFriendsShareAction:(id)sender {//邀请微信好友
    NSLog(@"邀请好友");
}

- (void)inviteFriendsFuncAction:(id _Nullable)sender {//朋友，微信分享，生成海报
    NSLog(@"分享");
}

- (void)inviteFriendsInvitationAction:(id _Nullable)sender {//今日，全部邀请
    NSLog(@"今日邀请");
}

// MARK: get
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

-(TSInviteFriendsDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSInviteFriendsDataController alloc] init];
    }
    return _dataController;
}
- (void)dealloc {
    NSLog(@"dealloc TSInviteFriendsViewController");
}
@end
