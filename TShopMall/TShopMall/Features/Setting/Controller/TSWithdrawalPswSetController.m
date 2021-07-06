//
//  TSWithdrawalPswSetController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSWithdrawalPswSetController.h"
#import "TSWithdrawalPswSetDataController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "RSA.h"
#import "TSTools.h"

@interface TSWithdrawalPswSetController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>
/// 数据中心
@property(nonatomic, strong) TSWithdrawalPswSetDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSWithdrawalPswSetController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupBasic {
    [super setupBasic];
    if (self.hasSet) {
        self.gk_navTitle = @"修改提现密码";
    } else {
        self.gk_navTitle = @"设置提现密码";
    }
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchWithdrawalPswSetContentsWithHasSet:self.hasSet complete:^(BOOL isSucess) {
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

- (TSWithdrawalPswSetDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSWithdrawalPswSetDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - Actions
/** 提交提现密码的设置 */
- (void)commitWithWithdrawalpsw:(NSString *)psw {
    [Popover popProgressOnWindowWithText:@"正在设置..."];
    [[TSServicesManager sharedInstance].acconutService fetchAccountPublicKeyComplete:^(NSString * _Nonnull publicKey) {
        ///利用公钥对密码进行加密
        NSString *rsaPwd = [RSA encryptString:psw publicKey:publicKey];
        NSString *base64String = [TSTools base64EncodedString:rsaPwd];
        [[TSServicesManager sharedInstance].userInfoService setWithrawalPwd:base64String success:^{
            [Popover popToastOnWindowWithText:@"提现密码设置成功"];
            [self back];
        } failure:^(NSString * _Nonnull errorMsg) {
            [Popover popToastOnWindowWithText:errorMsg];
        }];
    }];
}

- (void)back {
    NSArray *childrenVCs = self.navigationController.viewControllers;
    for (UIViewController *vc in childrenVCs) {
        if ([vc isKindOfClass: NSClassFromString(@"TSSecurityViewController")]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSWithdrawalPswSetSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSWithdrawalPswSetSectionModel *model = self.dataController.sections[indexPath.section];
    TSWithdrawalPswSetSectionItemModel *item = model.items[indexPath.row];
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
    TSWithdrawalPswSetSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

- (void)universalCollectionViewCellClick:(NSIndexPath *)indexPath params:(NSDictionary *)params {
    NSString *cellType = params[@"cellType"];
    if ([cellType isEqualToString:@"TSWithdrawalPswSettingCell"] && [params[@"WithdrawalPswSetClickType"] integerValue] == 1) {///提交按钮
        ///获取密码
        NSString *psw = params[@"WithdrawalPsw"];
        [self commitWithWithdrawalpsw:psw];
    }
}

#pragma mark - UniversalFlowLayoutDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSWithdrawalPswSetSectionModel *model = self.dataController.sections[indexPath.section];
    TSWithdrawalPswSetSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSWithdrawalPswSetSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSWithdrawalPswSetSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(TSUniversalFlowLayout *)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section {
    TSWithdrawalPswSetSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

@end
