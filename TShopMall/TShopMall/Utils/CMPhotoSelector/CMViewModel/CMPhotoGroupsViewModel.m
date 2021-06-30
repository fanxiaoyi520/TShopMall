//
//  CMPhotoGroupsViewModel.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoGroupsViewModel.h"
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "CMPhotoALAssets.h"
#import "CMPhotoGroup.h"

#define CMPhotoSelectorCellHeight 55.0

@interface CMPhotoGroupsViewModel ()

@property (nonatomic, strong) PHImageRequestOptions *imageOptions;

@property (nonatomic, strong) NSMutableArray<CMPhotoGroup *> *photoGroupArray;

@end

@implementation CMPhotoGroupsViewModel

implementationSingleton(CMPhotoGroupsViewModel)

- (NSMutableArray<CMPhotoGroup *> *)photoGroupArray {
    if (_photoGroupArray == nil) {
        _photoGroupArray = [NSMutableArray array];
    }
    return _photoGroupArray;
}

- (NSMutableArray<CMPhotoALAssets *> *)selectedPhotoImages {
    if (_selectedPhotoImages == nil) {
        _selectedPhotoImages = [NSMutableArray array];
    }
    return _selectedPhotoImages;
}

- (PHImageRequestOptions *)imageOptions {
    if (!_imageOptions) {
        _imageOptions = [[PHImageRequestOptions alloc] init];
        _imageOptions.synchronous = YES;
    }
    return _imageOptions;
}

- (void)getAllPhotoGroupsWithCompletedBlock:(void(^)(NSArray<CMPhotoGroup *> *dataSource))completionBlock unAuthorizedStatus:(void(^)(void))unAuthorizedBlock {
    if (self.photoGroupArray.count && completionBlock != nil) {
        completionBlock(self.photoGroupArray);
        return;
    }
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (unAuthorizedBlock != nil) {
                    unAuthorizedBlock();
                }
            });
        } else {
            PHFetchResult *results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            [results enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {
                [self photoGroupWithCollection:collection];
            }];
            results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            [results enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {
                if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                    [self photoGroupWithCollection:collection];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock != nil) {
                    completionBlock(self.photoGroupArray);
                }
            });
        }
    }];
}

- (void)photoGroupWithCollection:(PHAssetCollection *)collection {
    __weak typeof(self) weakSelf = self;
    [self coverImageWithCollection:collection completion:^(UIImage *image) {
        CMPhotoGroup *photoGroup = [CMPhotoGroup photGroupWithGroupName:collection.localizedTitle groupIcon:image];
        [weakSelf.photoGroupArray addObject:photoGroup];
        [weakSelf photoGroupSetALAsset:collection photoGroup:photoGroup];
    }];
}

- (void)photoGroupSetALAsset:(PHAssetCollection *)collection photoGroup:(CMPhotoGroup *)photoGroup {
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [assetResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            CMPhotoALAssets *photoALAssets = [[CMPhotoALAssets alloc] initWithPhotoAsset:asset isSelected:NO];
            [photoGroup.photoALAssets addObject:photoALAssets];
        }
    }];
}

- (void)coverImageWithCollection:(PHAssetCollection *)collection completion:(void(^)(UIImage *image))completedBlock {
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [assetResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            CGSize targetSize = CGSizeMake(CMPhotoSelectorCellHeight, CMPhotoSelectorCellHeight);
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:self.imageOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                completedBlock(result);
                *stop = YES;
            }];
        }
    }];
}
@end
