//
//  TSSettingViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/12.
//

#import "TSSettingViewController.h"
#import "TSSettingDataController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSAboutMeViewController.h"
#import "TSPersonalViewController.h"
#import "TSSecurCenterViewController.h"
#import "TSSecurityViewController.h"
#import "UIAlertController+Color.h"
#import "TSAlertView.h"

@interface TSSettingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>
/// 数据中心
@property(nonatomic, strong) TSSettingDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"个人设置";
    [self.navigationController setNavigationBarHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoModifiedAction) name:TSUserInfoModifiedNotificationName object:nil];
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchSettingContentsComplete:^(BOOL isSucess) {
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
        make.top.equalTo(self.view.mas_top).with.offset(GK_STATUSBAR_NAVBAR_HEIGHT + 1);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

///信息修改成功
- (void)userInfoModifiedAction {
    [self.collectionView reloadData];
}

#pragma mark - Lazy Method
- (UICollectionView *)collectionView{
    if (!_collectionView) {
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

- (TSSettingDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSSettingDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - Actions
- (void)exitAlert {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"退出后不会删除任何历史资料,\n下次登录依然可以使用本账号" preferredStyle:UIAlertControllerStyleAlert];
//    alertController.messageColor = KHexColor(@"#333333");
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    cancelAction.textColor = KHexColor(@"#333333");
//    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    confirmAction.textColor = KHexColor(@"#333333");
//    [alertController addAction:cancelAction];
//    [alertController addAction:confirmAction];
//    [self presentViewController: alertController animated:YES completion: ^{
//
//    }];
    TSAlertView.new.alertInfo(nil, @"退出后不会删除任何历史资料,\n下次登录依然可以使用本账号").confirm(@"退出", ^{
        NSLog(@"退出=========");
        [[TSUserLoginManager shareInstance] logout];

    }).cancel(@"取消", ^{}).show();
//    TSAlertView.new.alertInfo(@"下线通知", @"你的账号于00:00在另一台手机设备登录。请确认是否为本人操作，若非本人操作，建议重新登录App，进行密码重置。").confirm(@"确定", ^{
//        NSLog(@"退出=========");
//        [[TSUserLoginManager shareInstance] logout];
//
//    }).show();
}

#pragma mark - Noti
- (void)loginStateDidChanged:(NSNotification *)noti{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.item == 0) {
        TSPersonalViewController *personalVC = [[TSPersonalViewController alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
        return;
    } else if (indexPath.section == 1 && indexPath.item == 0) {
        TSSecurityViewController *securityVC = [[TSSecurityViewController alloc] init];
        [self.navigationController pushViewController:securityVC animated:YES];
        return;
    } else if (indexPath.section == 1 && indexPath.item == 1) {
        TSSecurCenterViewController *personalVC = [[TSSecurCenterViewController alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
        return;
    } else if (indexPath.section == 2 && indexPath.item == 0) {
        TSSecurCenterViewController *personalVC = [[TSSecurCenterViewController alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
        return;
    } else if (indexPath.section == 3 && indexPath.item == 0) {
        [self exitAlert];
        return;
    }
    TSAboutMeViewController *aboutMeVC = [[TSAboutMeViewController alloc] init];
    [self.navigationController pushViewController:aboutMeVC animated:YES];
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
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

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    TSSettingSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    TSSettingSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
    TSSettingSectionModel *model = self.dataController.sections[section.section];
    return model.docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    TSSettingSectionModel *model = self.dataController.sections[indexPath.section];
    return model.hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.sectionInset;
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

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    TSSettingSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}


@end
