//
//  TSChangeMobileViewController.m
//  TShopMall
//
//  Created by edy on 2021/6/25.
//

#import "TSChangeMobileViewController.h"
#import "TSBindMobileDataController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSChangeMobileCell.h"

@interface TSChangeMobileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>
/// 数据中心
@property(nonatomic, strong) TSBindMobileDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSChangeMobileViewController

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"更换手机号码";
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchChangeMobileContentsComplete:^(BOOL isSucess) {
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

- (TSBindMobileDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSBindMobileDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - Actions
/** 更换手机号的操作 */
- (void)changeMobile:(NSString *)phoneNumber oldMobile:(NSString *)oldPhoneNumber code:(NSString *)code {
    NSLog(@"新手机号 === %@ 旧手机号 === %@ 验证码 === %@", phoneNumber, oldPhoneNumber, code);
}
/** 发送验证码 */
- (void)sendCode {
    NSLog(@"发送验证码请求====");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSBindMobileSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSBindMobileSectionModel *model = self.dataController.sections[indexPath.section];
    TSBindMobileSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSBindMobileSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

- (void)universalCollectionViewCellClick:(NSIndexPath *)indexPath params:(NSDictionary *)params {
    NSString *cellType = params[@"cellType"];
    if ([cellType isEqualToString:@"TSChangeMobileCell"] && [params[@"ChangeMobileButtonClickType"] integerValue] == ChangeMobileValueTypeCommit) {///提交按钮
        NSString *mobileNumber = params[@"MobileNumber"];///手机号
        NSString *code = params[@"CodeNumber"];///验证码
        NSString *oldMobileNumber = params[@"OldMobileNumber"];///旧手机号
        [self changeMobile:mobileNumber oldMobile:oldMobileNumber code:code];
    } else if ([cellType isEqualToString:@"TSChangeMobileCell"] && [params[@"ChangeMobileButtonClickType"] integerValue] == ChangeMobileValueTypeSendCode) {///发送验证码事件
        [self sendCode];
    }
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSBindMobileSectionModel *model = self.dataController.sections[indexPath.section];
    TSBindMobileSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSBindMobileSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSBindMobileSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(TSUniversalFlowLayout *)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section {
    TSBindMobileSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}



@end
