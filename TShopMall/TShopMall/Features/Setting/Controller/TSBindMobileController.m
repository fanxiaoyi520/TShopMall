//
//  TSBindMobileController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBindMobileController.h"
#import "TSBindMobileDataController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSBindMobileCell.h"

@interface TSBindMobileController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>
/// 数据中心
@property(nonatomic, strong) TSBindMobileDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSBindMobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"绑定手机号码";
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"mall_login_close" target:self action:@selector(dismissPage)];
    self.gk_navLeftBarButtonItem = item;
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchBindMobileContentsComplete:^(BOOL isSucess) {
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
/** 绑定手机号的操作 */
- (void)bindMobile:(NSString *)phoneNumber code:(NSString *)code {
    [self.dataController fetchBindUserByAuthCode:self.token type:@"2" platformId:@"3" phone:phoneNumber smsCode:code complete:^(BOOL isSucess) {
        if (self.bindedBlock) {
            self.bindedBlock();
        }
    }];
}

- (void)dismissPage{
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
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
    if ([cell isKindOfClass:[TSBindMobileCell class]]) {
        @weakify(self);
        TSBindMobileCell *bindMobileCell = (TSBindMobileCell *)cell;
        bindMobileCell.codeButtonClickBlock = ^(NSString *phoneNumber){
            @strongify(self);
            [self.dataController fetchLoginSMSCodeMobile:phoneNumber complete:^(BOOL isSucess) {
                if (isSucess) {
                    
                }else
                {
                    
                }
            }];
        };
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSBindMobileSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

- (void)universalCollectionViewCellClick:(NSIndexPath *)indexPath params:(NSDictionary *)params {
    NSString *cellType = params[@"cellType"];
    if ([cellType isEqualToString:@"TSBindMobileCell"] && [params[@"commitType"] integerValue] == 1) {///提交按钮
        NSString *mobileNumber = params[@"MobileNumber"];///手机号
        NSString *code = params[@"CodeNumber"];///验证码
        [self bindMobile:mobileNumber code:code];
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
