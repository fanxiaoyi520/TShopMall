//
//  TSAccountCancelNextViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/19.
//

#import "TSAccountCancelNextViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSAccountCancelBottomCell.h"
#import "TSAccountCancelDataController.h"
#import "TSAccountCancelConfirmViewController.h"

@interface TSAccountCancelNextViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate,TSAccountCancelBottomCellDelegate>
/// 数据中心
@property(nonatomic, strong) TSAccountCancelDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSAccountCancelNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"账号注销";
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchCancelNextContentsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (void)fillCustomView {
    [super fillCustomView];
    ///设置约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(GK_STATUSBAR_NAVBAR_HEIGHT + 1);
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
        _collectionView.backgroundColor = KHexColor(@"#F4F4F5");
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (TSAccountCancelDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSAccountCancelDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - TSAccountCancelBottomCellDelegate
/** 确认注销 */
- (void)confirmAction {
    @weakify(self);
    [[TSServicesManager sharedInstance].acconutService fetchAccountCancelCallBack:^(NSString * _Nonnull date, NSString * _Nonnull nickname) {
        @strongify(self);
        TSAccountCancelConfirmViewController *nextVC = [[TSAccountCancelConfirmViewController alloc] init];
        nextVC.nickname = nickname;
        nextVC.date = date;
        [self.navigationController pushViewController:nextVC animated:YES];
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:errorMsg];
    }];
    
}
/** 取消 */
- (void)cancelAction {
    NSArray *childrenVCs = self.navigationController.viewControllers;
    for (UIViewController *vc in childrenVCs) {
        if ([vc isKindOfClass:NSClassFromString(@"TSSecurityViewController")]) {
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
    TSAccountCancelSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSAccountCancelSectionModel *model = self.dataController.sections[indexPath.section];
    TSAccountCancelSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    if ([cell isKindOfClass:[TSAccountCancelBottomCell class]]) {
        TSAccountCancelBottomCell *_cell = (TSAccountCancelBottomCell *)cell;
        _cell.actionDelegate = self;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSAccountCancelSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSAccountCancelSectionModel *model = self.dataController.sections[indexPath.section];
    TSAccountCancelSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSAccountCancelSectionModel *model = self.dataController.sections[section];
    return model.column;
}

@end
