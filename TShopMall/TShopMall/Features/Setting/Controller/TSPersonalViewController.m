//
//  TSPersonalViewController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSPersonalViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSPersonalDataController.h"
#import "TSChangePictureViewController.h"
#import "TSChangePictureActionSheet.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "TSAlertView.h"
#import "TSChangePictureViewController.h"
#import "TSSexSelectingView.h"
#import "TSDatePickerView.h"
#import "TSRealnameInfoViewController.h"
#import "TSRealNameAuthViewController.h"
#import "TSModifyNicknameViewController.h"
#import "PhotoBrowser.h"
#import "CMPhotoSelectorController.h"

@interface TSPersonalViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UniversalFlowLayoutDelegate,UniversalCollectionViewCellDataDelegate, TSSexSelectingViewDelegate, TSDatePickerViewDelegate, CMPhotoSelectorControllerDelegate>
/// 数据中心
@property(nonatomic, strong) TSPersonalDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;
/** PhotoBrowser图片选择器  */
@property(nonatomic, strong) PhotoBrowser *photoBrowser;
@end

@implementation TSPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupBasic {
    [super setupBasic];
    self.gk_navTitle = @"个人资料";
    [self userInfoModifiedAction];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoModifiedAction) name:TSUserInfoModifiedNotificationName object:nil];
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

- (void)modifyUserInfoWithKey:(NSString *)key value:(NSString *)value completed:(void (^)(void))completed {
    [Popover popProgressOnWindowWithText:@"提交中..."];
    [[TSServicesManager sharedInstance].userInfoService modifyUserInfoWithKey:key value:value success:^ {
        ///发通知修改成功
        [[NSNotificationCenter defaultCenter] postNotificationName:TSUserInfoModifiedNotificationName object:nil];
        [Popover popToastOnWindowWithText:@"修改成功！"];
        if (completed) {
            completed();
        }
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:errorMsg];
    }];
}

#pragma mark - Actions
///信息修改成功
- (void)userInfoModifiedAction {
    __weak __typeof(self)weakSelf = self;
    [self.dataController fetchPersonalContentsComplete:^(BOOL isSucess) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (isSucess) {
            [strongSelf.collectionView reloadData];
        }
    }];
}
/** 相册权限 */
- (void)photoAuthorized {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {
        //无权限
        [self showOpenSettingAlert];
        return;
    }
    if (status == PHAuthorizationStatusDenied) {
        [self showOpenSettingAlert];
        return;
    }
    if (status == PHAuthorizationStatusNotDetermined) {
        [self pushImagePickerController];
        //请求授权
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            if (status == PHAuthorizationStatusAuthorized) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                });
//            }
//        }];
        return;
    }
    if (status == PHAuthorizationStatusAuthorized) {///已授权
        [self pushImagePickerController];
        return;
    }
}

- (void)showOpenSettingAlert {
    TSAlertView.new.alertInfo(nil, @"请打开相机/相册权限").confirm(@"去打开", ^{
        [self openSetting];
    }).cancel(@"取消", ^{}).show();
}

- (void)showSexAlert {
    TSSexSelectingView *sexSelectedView = [TSSexSelectingView sexSelectingView];
    sexSelectedView.delegate = self;
    [sexSelectedView show];
}

- (void)showDatePickerView {
    TSDatePickerView *datePickerView = [TSDatePickerView datePickerView];
    datePickerView.delegate = self;
    [datePickerView show];
}

#pragma mark - 添加图片
- (void)pushImagePickerController {
    BrowserConfig *config = [[BrowserConfig alloc] init];
    config.type = BrowserTypeSheet;
    config.maxImagesCount = 1;
    config.allowCrop = NO;
    __weak typeof(self) weakSelf = self;
    self.photoBrowser = [[PhotoBrowser alloc] initWithBrowserConfig:config superViewController:self];
    self.photoBrowser.photosBlock = ^(NSArray *_Nonnull selectedPhotosArray, NSArray *_Nonnull selectedAssets) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIImage *image = selectedPhotosArray.firstObject;
        [strongSelf uploadAvartar:image];
    };
    [self.photoBrowser showPhotoBrowser];
}

- (void)uploadAvartar:(UIImage *)image {
    [Popover popProgressOnWindowWithText:@"正在上传..."];
    [[TSServicesManager sharedInstance].userInfoService uploadImage:image success:^(NSString * _Nonnull imageURL) {
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
        [TSServicesManager sharedInstance].userInfoService.user.avatar = avatarURL;
        [[NSNotificationCenter defaultCenter] postNotificationName:TSUserInfoModifiedNotificationName object:nil];
        [Popover popToastOnWindowWithText:@"头像修改成功！"];
    } failure:^(NSString * _Nonnull errorMsg) {
        [Popover popToastOnWindowWithText:@"头像修改失败！"];
    }];
}

//- (void)pushImagePickerController {
//    CMPhotoSelectorController *selectorController = [CMPhotoSelectorController photoSelectorControllerWithMultiSelection:NO maxCount:1];
//    selectorController.selectorDelegate = self;
//    selectorController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self.navigationController presentViewController:selectorController animated:YES completion:nil];
//}

/** 相机权限 */
- (void)captureAuthorized {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted) {
        //无权限
        [self showOpenSettingAlert];
        return;
    }
    if (authStatus  == AVAuthorizationStatusDenied) {
        [self showOpenSettingAlert];
        return;
    }
    if (authStatus  == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType: AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {///成功授权
                
            }
        }];
        return;
    }
    if (authStatus == AVAuthorizationStatusAuthorized) {
        
        return;
    }
}

- (void)openSetting {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)showPictureSheet {
    TSChangePictureActionSheet *actionSheet = [TSChangePictureActionSheet actionSheetWithTitles:@[@"拍照", @"从相册中选择", @"系统默认头像"] actionHandler:^(NSInteger index, NSString * _Nonnull title) {
        if (index == 0) {///拍照
            [self captureAuthorized];
        } else if (index == 1) {///从相册中选择
            [self photoAuthorized];
        } else if (index == 2) {///系统默认头像
            TSChangePictureViewController *changePictureVC = [[TSChangePictureViewController alloc] init];
            [self.navigationController pushViewController:changePictureVC animated:YES];
        }
    }];
    [actionSheet show];
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

- (TSPersonalDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSPersonalDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - TSSexSelectingViewDelegate(性别选择)
- (void)selectedSex:(Sex)sex {
    NSString *sexString = [NSString stringWithFormat:@"%d", sex];
    @weakify(self);
    [self modifyUserInfoWithKey:@"sex" value:sexString completed:^{
        @strongify(self);
        [TSServicesManager sharedInstance].userInfoService.user.sex = sex;
        [self userInfoModifiedAction];
    }];
}

#pragma mark - TSDatePickerViewDelegate(日期选择器）
- (void)selectedDateString:(NSString *)dateString {
    @weakify(self);
    [self modifyUserInfoWithKey:@"birthday" value:dateString completed:^{
        @strongify(self);
        [TSServicesManager sharedInstance].userInfoService.user.birthday = dateString;
        [self userInfoModifiedAction];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSPersonalSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSPersonalSectionModel *model = self.dataController.sections[indexPath.section];
    TSPersonalSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        [self showPictureSheet];
        return;
    } else if (indexPath.item == 1) {
        TSModifyNicknameViewController *nicknameVC = [[TSModifyNicknameViewController alloc] init];
        [self.navigationController pushViewController:nicknameVC animated:YES];
        return;
    } else if (indexPath.item == 2) {
//        TSRealnameInfoViewController *realnameInfoVC = [[TSRealnameInfoViewController alloc] init];
//        [self.navigationController pushViewController:realnameInfoVC animated:YES];
        TSRealNameAuthViewController *realnameAuthVC = [[TSRealNameAuthViewController alloc] init];
        [self.navigationController pushViewController:realnameAuthVC animated:YES];
        return;
    } else if (indexPath.item == 3) {
        [self showSexAlert];
        return;
    } else if (indexPath.item == 4) {
        [self showDatePickerView];
        return;
    }
    TSChangePictureViewController *changePicVC = [[TSChangePictureViewController alloc] init];
    [self.navigationController pushViewController:changePicVC animated:YES];
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSPersonalSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSPersonalSectionModel *model = self.dataController.sections[indexPath.section];
    TSPersonalSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSPersonalSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    TSPersonalSectionModel *model = self.dataController.sections[section];
    return model.lineSpacing;
}

#pragma mark - CMPhotoSelectorControllerDelegate

- (void)finishMultiSelectionWithData:(NSArray<CMPhotoALAssets *> *)photoAssets {
    
}

- (void)finishSingleSelectionWithImage:(UIImage *)image {
    NSLog(@"选择的图片====%@", image);
}


@end

