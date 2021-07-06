//
//  TSPhoneNumVeriViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//
/** 手机号验证 */
#import "TSPhoneNumVeriViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSPhoneNumDataController.h"
#import "TSPhoneNumVeriCell.h"
#import "TSWithdrawalPswSetController.h"

@interface TSPhoneNumVeriViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UniversalFlowLayoutDelegate, UniversalCollectionViewCellDataDelegate, TSPhoneNumVeriCellDelegate>
/// 数据中心
@property(nonatomic, strong) TSPhoneNumDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSPhoneNumVeriViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"手机号验证";
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchPhoneNumContentsComplete:^(BOOL isSucess) {
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
        _collectionView.backgroundColor = KGrayColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (TSPhoneNumDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSPhoneNumDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - TSPhoneNumVeriCellDelegate
- (void)commitActionWithCode:(NSString *)code mobile:(nonnull NSString *)mobile commitButton:(nonnull UIButton *)commitButton {
    [Popover popProgressOnWindowWithText:@"正在校验..."];
    ///校验验证码
    [[TSServicesManager sharedInstance].userInfoService checkCodeMobile:mobile code:code success:^{
        [Popover removePopoverOnWindow];
        TSWithdrawalPswSetController *withdrawalVC = [[TSWithdrawalPswSetController alloc] init];
        withdrawalVC.hasSet = self.hasSet;
        [self.navigationController pushViewController:withdrawalVC animated:YES];
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:errorMsg];
        commitButton.enabled = YES;
    }];
}

- (void)sendCodeWithMobile:(NSString *)mobile codeButton:(UIButton *)codeButton cell:(nonnull TSPhoneNumVeriCell *)cell {
    [self.dataController fetchCheckMobileSMSCodeMobile:mobile complete:^(BOOL isSucess) {
        if (isSucess) {
            ///开启定时器
            [cell startTimer];
            [Popover popToastOnWindowWithText:@"发送手机号验证码成功！"];
        } else {
            ///让验证码按钮enable
            codeButton.enabled = YES;
        }
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSPhoneNumSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSPhoneNumSectionModel *model = self.dataController.sections[indexPath.section];
    TSPhoneNumSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    if ([cell isKindOfClass:[TSPhoneNumVeriCell class]]) {
        TSPhoneNumVeriCell *_cell = (TSPhoneNumVeriCell *)cell;
        _cell.actionDelegate = self;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSPhoneNumSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSPhoneNumSectionModel *model = self.dataController.sections[indexPath.section];
    TSPhoneNumSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSPhoneNumSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSPhoneNumSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(TSUniversalFlowLayout *)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section {
    TSPhoneNumSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

@end
