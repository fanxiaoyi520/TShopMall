//
//  TSSecurityViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSecurityViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSSecurityDataController.h"
#import "TSPhoneNumVeriViewController.h"
#import "TSBindMobileController.h"
#import "TSWithdrawalPswSetController.h"
#import "TSAccountCancelViewController.h"
#import "TSSecurCenterViewController.h"
#import "TSAlertView.h"

@interface TSSecurityViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>
/// 数据中心
@property(nonatomic, strong) TSSecurityDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupBasic {
    [super setupBasic];
    self.title = @"账号安全";
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchSecurityContentsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)fillCustomView {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(1);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

#pragma mark - Lazy Method
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.backgroundColor = KGrayColor;//KHexColor(@"#E6E6E6");
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (TSSecurityDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSSecurityDataController alloc] init];
    }
    return _dataController;
}
/** 解绑微信 */
- (void)showUnbindWechatAlert {
    TSAlertView.new.alertInfo(@"确认解绑", @"解绑后需要重新绑定微信账号，才能用微信登录").confirm(@"继续解绑", ^{
        
    }).cancel(@"取消", ^{}).show();
}

/** 解绑Apple登录 */
- (void)showUnbindAppleAlert {
    TSAlertView.new.alertInfo(@"确认解绑", @"解绑后需要重新绑定Apple账号，才能用Apple账号登录").confirm(@"继续解绑", ^{
        
    }).cancel(@"取消", ^{}).show();
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSSettingSectionModel *model = self.dataController.sections[indexPath.section];
    TSSettingSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0) {
        TSBindMobileController *bindVC = [[TSBindMobileController alloc] init];
//        TSPhoneNumVeriViewController *bindVC = [[TSPhoneNumVeriViewController alloc] init];
        [self.navigationController pushViewController:bindVC animated:YES];
        return;
    } else if (indexPath.section == 0 && indexPath.item == 1) {
        TSAccountCancelViewController *accoutCancelVC = [[TSAccountCancelViewController alloc] init];
        [self.navigationController pushViewController:accoutCancelVC animated:YES];
        return;
    } else if (indexPath.section == 1 && indexPath.item == 0) {
        TSWithdrawalPswSetController *pswSetVC = [[TSWithdrawalPswSetController alloc] init];
        [self.navigationController pushViewController:pswSetVC animated:YES];
        return;
    } else if (indexPath.section == 3 && indexPath.item == 0) {
        TSSecurCenterViewController *secriCenterVC = [[TSSecurCenterViewController alloc] init];
        [self.navigationController pushViewController:secriCenterVC animated:YES];
        return;
    }
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSSettingSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSSettingSectionModel *model = self.dataController.sections[indexPath.section];
    TSSettingSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(TSUniversalFlowLayout *)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section {
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

@end
