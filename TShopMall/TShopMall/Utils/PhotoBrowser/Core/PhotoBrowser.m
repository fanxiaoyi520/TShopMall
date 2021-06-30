//
//  PhotoBrowser.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <TZImagePickerController/TZImagePickerController.h>

#import "DialogHeader.h"
#import "ImageCompresser.h"
#import "ImageCropper.h"
#import "PhotoBrowser.h"

#import "UIColor+Plugin.h"
#import "UIImage+fixOrientation.h"


@interface PhotoBrowser () <TZImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}

@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) BrowserConfig *config;

@property (nonatomic, strong) TZImagePickerController *imagePickerVc;
@property (nonatomic, strong) UIImagePickerController *cameraPickerVc;
@property (nonatomic, strong) UIViewController *superViewController;
@property (nonatomic, strong) ImageCropper *cropper;

@end


@implementation PhotoBrowser

#pragma mark - Init Methods
- (instancetype)initWithBrowserConfig:(BrowserConfig *)config superViewController:(UIViewController *)superViewController {
    self = [super init];
    if (self) {
        _config = config;
        _superViewController = superViewController;
        _selectedPhotos = [NSMutableArray array];
        _selectedAssets = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public Methods
/// 显示
- (void)showPhotoBrowser {
    switch (_config.type) {
        case BrowserTypeAlbum: {
            if (_config.maxImagesCount == 0) {
                return;
            }

            if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
                [Dialog showDialogWithTitle:nil subtitle:@"请在“设置-隐私-相册”选项中，允许TCL访问你的手机相册。" buttons:@[@"取消", @"设置"]
                                resultBlock:^BOOL(DialogResult *_Nonnull result) {
                                    if (result.buttonIndex == 1) {
                                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}
                                                                 completionHandler:nil];
                                    }
                                    return YES;
                                }];
            } else {
                [self.superViewController presentViewController:self.imagePickerVc animated:YES completion:nil];
            }
        } break;
        case BrowserTypeCamera: {
            [self takePhoto];
        } break;
        default: {
            NSString *takePhotoTitle = @"相机";
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction *_Nonnull action) {
                                                                        [self takePhoto];
                                                                    }];
            [alertVc addAction:takePhotoAction];
            UIAlertAction *imagePickerAction =
                [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                    if (self.config.maxImagesCount == 0) {
                        return;
                    }

                    if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
                        [Dialog showDialogWithTitle:nil subtitle:@"请在“设置-隐私-相册”选项中，允许TCL访问你的手机相册。" buttons:@[@"取消", @"设置"]
                                        resultBlock:^BOOL(DialogResult *_Nonnull result) {
                                            if (result.buttonIndex == 1) {
                                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}
                                                                         completionHandler:nil];
                                            }
                                            return YES;
                                        }];
                    } else {
                        [self.superViewController presentViewController:self.imagePickerVc animated:YES completion:nil];
                    }
                }];
            [alertVc addAction:imagePickerAction];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVc addAction:cancelAction];
            [self.superViewController presentViewController:alertVc animated:YES completion:nil];
        } break;
    }
}

#pragma mark - Private Methods
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限
        [Dialog showDialogWithTitle:nil subtitle:@"请在“设置-隐私-相机”选项中，允许TCL访问你的相机。" buttons:@[@"取消", @"设置"]
                        resultBlock:^BOOL(DialogResult *_Nonnull result) {
                            if (result.buttonIndex == 1) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}
                                                         completionHandler:nil];
                            }
                            return YES;
                        }];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [Dialog showDialogWithTitle:nil subtitle:@"请在“设置-隐私-相册”选项中，允许TCL访问你的手机相册。" buttons:@[@"取消", @"设置"]
                        resultBlock:^BOOL(DialogResult *_Nonnull result) {
                            if (result.buttonIndex == 1) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}
                                                         completionHandler:nil];
                            }
                            return YES;
                        }];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 使用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.cameraPickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (_config.showTakeVideoBtn) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (_config.showTakePhotoBtn) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            self.cameraPickerVc.mediaTypes = mediaTypes;
        }
        [self.superViewController presentViewController:self.cameraPickerVc animated:YES completion:nil];
    } else {
        PHOTO_LOG(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
        PHOTO_LOG(@"图片名字:%@", fileName);
    }
}

- (void)compressImage {
    if (self.config.maxImagesCount == 1 && self.config.needCompress && self.config.maxCompressLength > 0) {
        for (NSInteger i = 0; i < _selectedPhotos.count; i++) {
            id object = _selectedPhotos[i];
            if ([object isKindOfClass:[UIImage class]]) {
                UIImage *image = (UIImage *)object;
                UIImage *newImage = [ImageCompresser compressOriginalImage:image toMaxDataSizeKBytes:self.config.maxCompressLength];
                if (newImage) {
                    [_selectedPhotos replaceObjectAtIndex:i withObject:newImage];
                }
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    return YES;
}

- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    return YES;
}

- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
                        infos:(NSArray<NSDictionary *> *)infos {
    if (self.config.allowCrop && assets.count == 1 && photos.count == 1) { // 允许裁剪,去裁剪
        self.cropper = [[ImageCropper alloc] init];
        self.cropper.image = [photos firstObject];
        self.cropper.isRound = self.config.needCircleCrop;
        [self.imagePickerVc pushViewController:self.cropper animated:YES];

        __weak typeof(self) weakSelf = self;
        self.cropper.sureBlock = ^(ImageCropper *cropping, UIImage *croppedImage) {
            [weakSelf refreshSelectedArrayWithAddedAsset:[assets firstObject] image:croppedImage];
        };
    } else if (assets.count >= 1 && photos.count >= 1) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        _selectedAssets = [NSMutableArray arrayWithArray:assets];

        // 1.打印图片名字
        [self printAssetsName:assets];
        // 2.图片位置信息
        for (PHAsset *phAsset in assets) {
            PHOTO_LOG(@"location:%@", phAsset.location);
        }

        [self compressImage];

        if (self.photosBlock) {
            self.photosBlock(_selectedPhotos, _selectedAssets);
        }

        if (self.imagePickerVc) {
            [self.imagePickerVc dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    [self.imagePickerVc dismissViewControllerAnimated:YES completion:nil];
}

// If user picking a video and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
        // NSData *data = [NSData dataWithContentsOfFile:outputPath];
        PHOTO_LOG(@"视频导出到本地完成,沙盒路径为:%@", outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        PHOTO_LOG(@"视频导出失败:%@,error:%@", errorMessage, error);
    }];

    [self compressImage];

    if (self.photosBlock) {
        self.photosBlock(_selectedPhotos, _selectedAssets);
    }
}

// If user picking a gif image and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [self compressImage];
    if (self.photosBlock) {
        self.photosBlock(_selectedPhotos, _selectedAssets);
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];

    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        __weak typeof(self) weakSelf = self;
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:self.location completion:^(PHAsset *asset, NSError *error) {
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                PHOTO_LOG(@"图片保存失败 %@", error);
            } else {
                if (weakSelf.config.allowCrop) { // 允许裁剪,去裁剪
                    weakSelf.cropper = [[ImageCropper alloc] init];
                    weakSelf.cropper.image = [image fixOrientation];
                    weakSelf.cropper.isRound = weakSelf.config.needCircleCrop;

                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:weakSelf.cropper];
                    [nav.navigationBar
                        setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    nav.modalPresentationStyle = UIModalPresentationFullScreen;
                    [weakSelf.superViewController presentViewController:nav animated:YES completion:nil];

                    weakSelf.cropper.sureBlock = ^(ImageCropper *cropping, UIImage *croppedImage) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf refreshSelectedArrayWithAddedAsset:asset image:croppedImage];
                    };
                } else {
                    [weakSelf refreshSelectedArrayWithAddedAsset:asset image:image];
                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            __weak typeof(self) weakSelf = self;
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            [strongSelf refreshSelectedArrayWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshSelectedArrayWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];

    if (self.imagePickerVc) {
        [self.imagePickerVc dismissViewControllerAnimated:YES completion:nil];
    }

    [self compressImage];
    if (self.photosBlock) {
        self.photosBlock(_selectedPhotos, _selectedAssets);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Lazy Loads Methods

- (TZImagePickerController *)imagePickerVc {
    if (!_imagePickerVc) {
        _imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_config.maxImagesCount columnNumber:_config.columnNumber delegate:self
                                                               pushPhotoPickerVc:YES];
        _imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        _imagePickerVc.autoDismiss = NO;
        _imagePickerVc.isSelectOriginalPhoto = NO;
        if (_config.maxImagesCount > 1) {
            // 1.设置目前已经选中的图片数组
            _imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
        }
        _imagePickerVc.allowTakePicture = NO;     // 在内部显示拍照按钮
        _imagePickerVc.allowTakeVideo = NO;       // 在内部显示拍视频按
        _imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
        [_imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
            imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        }];
        _imagePickerVc.autoSelectCurrentWhenDone = NO;
        // 2. 在这里设置imagePickerVc的外观
        _imagePickerVc.navigationBar.barTintColor = [UIColor colorWithHexString:@"#E64C3D"];
        _imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
        _imagePickerVc.oKButtonTitleColorNormal = [UIColor blackColor];
        _imagePickerVc.navigationBar.translucent = NO;
        _imagePickerVc.iconThemeColor = [UIColor colorWithHexString:@"#E64C3D"];
        _imagePickerVc.showPhotoCannotSelectLayer = YES;
        _imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        // 3. 设置是否可以选择视频/图片/原图
        _imagePickerVc.allowPickingVideo = _config.allowPickingVideo;
        _imagePickerVc.allowPickingImage = _config.allowPickingImage;
        _imagePickerVc.allowPickingOriginalPhoto = _config.allowPickingOriginalPhoto;
        _imagePickerVc.allowPickingGif = _config.allowPickingGif;
        _imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
        // 4. 照片排列按修改时间升序
        _imagePickerVc.sortAscendingByModificationDate = YES;
        /// 5. 单选模式,maxImagesCount为1时才生效
        _imagePickerVc.showSelectBtn = _config.showSelectBtn;
        _imagePickerVc.allowCrop = _config.allowCrop;
        _imagePickerVc.needCircleCrop = _config.needCircleCrop;
        _imagePickerVc.scaleAspectFillCrop = NO;

        // 设置是否显示图片序号
        _imagePickerVc.showSelectedIndex = YES;
    }
    return _imagePickerVc;
}

- (UIImagePickerController *)cameraPickerVc {
    if (!_cameraPickerVc) {
        _cameraPickerVc = [[UIImagePickerController alloc] init];
        _cameraPickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _cameraPickerVc.navigationBar.barTintColor = self.superViewController.navigationController.navigationBar.barTintColor;
        _cameraPickerVc.navigationBar.tintColor = self.superViewController.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _cameraPickerVc;
}

@end
