//
//  TSChangePictureController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSChangePictureViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSChangePictureDataController.h"
#import "UIImage+ImageEffects.h"

@interface TSChangePictureViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate>
/// 数据中心
@property(nonatomic, strong) TSChangePictureDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;
/** top视图 */
@property(nonatomic, weak) UIView *topView;
/** back按钮 */
@property(nonatomic, weak) UIButton *backButton;
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 头像 */
@property(nonatomic, weak) UIImageView *avatarImgV;
/** 背景模糊图片 */
@property(nonatomic, weak) UIImageView *bgImgV;
/** 提交按钮 */
@property(nonatomic, weak) UIButton *commitButton;
/** 被选中的item  */
@property(nonatomic, strong) TSChangePictureSectionItemModel *selectedItem;

@end

@implementation TSChangePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setupBasic {
    [super setupBasic];
    self.view.backgroundColor = KWhiteColor;
    self.gk_navigationBar.hidden = YES;
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchChangePictureContentsComplete:^(BOOL isSucess) {
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
    [self.avatarImgV sd_setImageWithURL:[NSURL URLWithString:[TSUserInfoManager userInfo].user.avatar] placeholderImage:KImageMake(@"mall_setting_defautlhead")];
}

- (void)addConstraints {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(235);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_top).with.offset(GK_STATUSBAR_NAVBAR_HEIGHT - 34);
        make.left.equalTo(self.topView.mas_left).with.offset(20);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(28);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton.mas_centerY).with.offset(0);
        make.centerX.equalTo(self.topView.mas_centerX).with.offset(0);
    }];
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).with.offset(0);
        make.top.equalTo(self.topView.mas_top).with.offset(0);
        make.right.equalTo(self.topView.mas_right).with.offset(0);
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(0);
    }];
    [self.avatarImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY).with.offset(20);
        make.centerX.equalTo(self.topView.mas_centerX).with.offset(0);
        make.width.height.mas_equalTo(86);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-48);
        make.height.mas_equalTo(41);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.topView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.commitButton.mas_top).with.offset(0);
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
        _collectionView.backgroundColor = KWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (TSChangePictureDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSChangePictureDataController alloc] init];
    }
    return _dataController;
}

- (UIView *)topView {
    if (_topView == nil) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        UIButton *backButton = [[UIButton alloc] init];
        _backButton = backButton;
        [_backButton setBackgroundImage:KImageMake(@"mall_white_naviback") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:backButton];
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KWhiteColor;
        _titleLabel.font = KRegularFont(18);
        _titleLabel.text = @"更换头像";
        [self.topView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)avatarImgV {
    if (_avatarImgV == nil) {
        UIImageView *avatarImgV = [[UIImageView alloc] init];
        _avatarImgV = avatarImgV;
        _avatarImgV.clipsToBounds = YES;
        [_avatarImgV setCorners:UIRectCornerAllCorners radius:43];
        [self.topView addSubview:_avatarImgV];
    }
    return _avatarImgV;
}

- (UIImageView *)bgImgV {
    if (_bgImgV == nil) {
        UIImageView *bgImgV = [[UIImageView alloc] init];
        _bgImgV = bgImgV;
        //_bgImgV.contentMode = UIViewContentModeScaleToFill;
        _bgImgV.image = [UIImage imageWithColor:KHexAlphaColor(@"#898989", 0.45)];
        [self.topView insertSubview:_bgImgV atIndex:0];
    }
    return _bgImgV;
}

- (UIButton *)commitButton {
    if (_commitButton == nil) {
        UIButton *commitButton = [[UIButton alloc] init];
        _commitButton = commitButton;
        _commitButton.backgroundColor = KHexColor(@"#FF4D49");
        _commitButton.layer.cornerRadius = 20.5;
        _commitButton.clipsToBounds = YES;
        _commitButton.titleLabel.font = KRegularFont(16);
        _commitButton.hidden = YES;
        [_commitButton setTitle:@"立即设置" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_commitButton];
    }
    return _commitButton;
}

#pragma mark - Actions
/** 立即设置 */
- (void)commitAction {
    if (self.selectedItem) {
        [self uploadAvartar:KImageMake(self.selectedItem.icon)];
    }
}

- (void)uploadAvartar:(UIImage *)image {
    [Popover popProgressOnWindowWithText:@"正在上传..."];
    [[TSServicesManager sharedInstance].uploadImageService uploadImage:image success:^(NSString * _Nonnull imageURL) {
        if (imageURL) {
            [self modifyAvartar:imageURL];
        } else {
            [Popover popToastOnWindowWithText:@"头像上传失败！"];
        }
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:@"头像上传失败！"];
    }];
}

- (void)modifyAvartar:(NSString *)avatarURL {
    [[TSServicesManager sharedInstance].userInfoService modifyUserInfoWithKey:@"avatar" value:avatarURL success:^ {
        [Popover popToastOnWindowWithText:@"头像修改成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:@"头像修改失败！"];
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSChangePictureSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSChangePictureSectionModel *model = self.dataController.sections[indexPath.section];
    TSChangePictureSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TSChangePictureSectionModel *model = self.dataController.sections[indexPath.section];
    TSChangePictureSectionItemModel *item = model.items[indexPath.item];
    if (self.selectedItem == item) {
        return;
    }
    item.selected = YES;
    if (self.selectedItem) {
        self.selectedItem.selected = NO;
    } else {
        self.commitButton.hidden = NO;
    }
    self.selectedItem = item;
    [self.collectionView reloadData];
    self.avatarImgV.image = KImageMake(item.icon);
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSChangePictureSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSChangePictureSectionModel *model = self.dataController.sections[indexPath.section];
    TSChangePictureSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSChangePictureSectionModel *model = self.dataController.sections[section];
    return model.column;
}
@end
