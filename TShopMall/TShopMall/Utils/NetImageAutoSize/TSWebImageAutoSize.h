//
//  TSWebImageAutoSize.h
//  TSale
//
//  Created by 陈洁 on 2021/1/11.
//  Copyright © 2021 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableView+TSWebImageAutoSize.h"
#import "UICollectionView+TSWebImageAutoSize.h"
#import "TSWebImageAutoSizeCache.h"

NS_ASSUME_NONNULL_BEGIN


@interface TSWebImageAutoSize : NSObject

/// Get image height
/// @param url imageURL
/// @param layoutWidth layoutWidth
/// @param estimateHeight estimateHeight(default 100)
+(CGFloat)imageHeightForURL:(NSURL *)url layoutWidth:(CGFloat)layoutWidth estimateHeight:(CGFloat )estimateHeight;

/// Get image size from cache,query the disk cache synchronously after checking the memory cache
/// @param url imageURL
+(CGSize )imageSizeFromCacheForURL:(NSURL *)url;

/// Store an imageSize into memory and disk cache
/// @param image image
/// @param url imageURL
/// @param completedBlock An block that should be executed after the imageSize has been saved (optional)
+(void)storeImageSize:(UIImage *)image forURL:(NSURL *)url completed:(TSWebImageAutoSizeCacheCompletionBlock)completedBlock;

/// Get reload state from cache,query the disk cache synchronously after checking the memory cache
/// @param url imageURL
+(BOOL)reloadStateFromCacheForURL:(NSURL *)url;

/// Store an reloadState into memory and disk cache
/// @param state reloadState
/// @param url imageURL
/// @param completedBlock An block that should be executed after the reloadState has been saved (optional)
+(void)storeReloadState:(BOOL)state forURL:(NSURL *)url completed:(TSWebImageAutoSizeCacheCompletionBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
