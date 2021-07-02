//
//  CMPhotoImagesController.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/19.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoImagesController.h"
#import "CMPhotoImageCell.h"
#import "CMPhotoALAssets.h"
#import "CMPhotoGroupsViewModel.h"
#import "CMPhotoSelectorController.h"

@interface CMPhotoImagesController ()
/**
 * 已选中的
 */
@property(nonatomic, strong) CMPhotoALAssets *selectedPhotoALAsset;

@end

@implementation CMPhotoImagesController

static NSString * const reuseIdentifier = @"CMPhotoImagesCell_ReuseIdentifier";

#pragma mark - Load On Demand Method

#pragma mark - On Click Actions Method
/**
 * 完成按钮的点击事件
 */
- (void)doneOnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    CMPhotoSelectorController *selectorController = (CMPhotoSelectorController *)self.navigationController;
    if (self.isMultiSelection) {
        if ([selectorController.selectorDelegate respondsToSelector:@selector(finishMultiSelectionWithData:)]) {
            [selectorController.selectorDelegate finishMultiSelectionWithData:[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages];
        }
    } else {
        if ([selectorController.selectorDelegate respondsToSelector:@selector(finishSingleSelectionWithImage:)]) {
            CMPhotoALAssets *photoALAssets = [CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages.firstObject;
            PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
            imageOptions.synchronous = YES;
            [[PHImageManager defaultManager] requestImageForAsset:photoALAssets.photoAsset targetSize:self.view.bounds.size contentMode:PHImageContentModeAspectFill options:imageOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                [selectorController.selectorDelegate finishSingleSelectionWithImage:result];
            }];
        }
    }
    [self clearAllData];
}

#pragma mark - Setter Method

#pragma mark - Public Method

#pragma mark - Life Cycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///初始化操作
    [self setUpInit];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.selectedPhotoALAsset != nil) {
        self.selectedPhotoALAsset.selected = NO;
    }
}

#pragma mark - UICollectionViewDataSource Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMPhotoALAssets *photoALAssets = [self.dataSource objectAtIndex:indexPath.item];
    CMPhotoImageCell *cell = (CMPhotoImageCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.photoALAssets = photoALAssets;
    return cell;
}

#pragma mark - UICollectionViewDelegate Method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CMPhotoALAssets *photoALAssets = [self.dataSource objectAtIndex:indexPath.item];
    if (!photoALAssets.isSelected) {///如果是未选中状态
        if (self.isMultiSelection) {///允许多选
            if ([CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages.count >= self.maxCount) {
                return;
            } else {
                [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages addObject:photoALAssets];
            }
        } else {///单选
            if (self.selectedPhotoALAsset != nil) {
                self.selectedPhotoALAsset.selected = NO;
                NSInteger item = [self.dataSource indexOfObject:self.selectedPhotoALAsset];
                [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeAllObjects];
                [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:item inSection:0]]];
            } else if ([CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages.count) {
                [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeAllObjects];
            }
            self.selectedPhotoALAsset = photoALAssets;
            [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages addObject:photoALAssets];
        }
        
    } else {///如果是选中状态
        if (![[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages containsObject:photoALAssets]) {
            if (self.isMultiSelection) {///允许多选
                [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeObject:photoALAssets];
            } else {///单选
                if (self.selectedPhotoALAsset != nil) {
                    self.selectedPhotoALAsset.selected = NO;
                    NSInteger item = [self.dataSource indexOfObject:self.selectedPhotoALAsset];
                    self.selectedPhotoALAsset = nil;
                    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:item inSection:0]]];
                    [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeAllObjects];
                } else if ([CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages.count) {
                    [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeAllObjects];
                }
            }
        } else {
            [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeObject:photoALAssets];
        }
    }
    self.navigationItem.rightBarButtonItem.enabled = !photoALAssets.isSelected;
    photoALAssets.selected = !photoALAssets.isSelected;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self setupTitleWithCount:[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages.count];
}

#pragma mark - Private Method
/**
 * 初始化操作
 */
- (void)setUpInit {
    ///设置背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    ///设置导航栏右边的完成按钮
    [self setNavigationRightBtn];
    ///注册Cell
    [self.collectionView registerClass:[CMPhotoImageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setupTitleWithCount:[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages.count];
}

- (void)setNavigationRightBtn {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneOnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)clearAllData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages enumerateObjectsUsingBlock:^(CMPhotoALAssets * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = NO;
        }];
        [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel].selectedPhotoImages removeAllObjects];
    });
}

- (void)setupTitleWithCount:(NSInteger)count {
    self.title = [NSString stringWithFormat:@"%zd / %zd", count, self.maxCount];
}
@end
