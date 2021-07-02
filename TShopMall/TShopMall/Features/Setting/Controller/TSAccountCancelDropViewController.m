//
//  TSAccountCancelDropViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/19.
//

#import "TSAccountCancelDropViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSAccountCancelDataController.h"
#import "TSCommitCell.h"

@interface TSAccountCancelDropViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate, TSCommitCellDelegate>
/// 数据中心
@property(nonatomic, strong) TSAccountCancelDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSAccountCancelDropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"账号注销";
    if ([self.date containsString:@"T"]) {
        self.date = [self.date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchDropConfirmContentsWithDropTime:self.date complete: ^(BOOL isSucess) {
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

#pragma mark - TSCommitCellDelegate
- (void)commitAction {
    [[TSServicesManager sharedInstance].acconutService fetchAccountCancelBackCallBack:^(BOOL isSucess) {
        if (isSucess) {
            [Popover popToastOnWindowWithText:@"取消注销操作成功！"];
            [self back];
        } else {
            [Popover popToastOnWindowWithText:@"取消操作失败！请稍候~~"];
        }
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
    if ([cell isKindOfClass:[TSCommitCell class]]) {
        TSCommitCell *_cell = (TSCommitCell *)cell;
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
