//
//  TSWebImageAutoSizeCache.h
//  TSale
//
//  Created by 陈洁 on 2021/1/11.
//  Copyright © 2021 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TSWebImageAutoSizeCacheCompletionBlock)(BOOL result);

@interface TSWebImageAutoSizeCache : NSObject

/// Return global shared cache instance
+(TSWebImageAutoSizeCache *)shardCache;

/// Store an imageSize into memory and disk cache at the given key.
/// @param image The image to store
/// @param key The unique imageSize cache key, usually it's image absolute URL
-(BOOL)storeImageSize:(UIImage *)image forKey:(NSString *)key;

/// Store an imageSize into memory and disk cache at the given key.
/// @param image The image to store
/// @param key The unique imageSize cache key, usually it's image absolute URL
/// @param completedBlock An block that should be executed after the imageSize has been saved (optional)
-(void)storeImageSize:(UIImage *)image forKey:(NSString *)key completed:(TSWebImageAutoSizeCacheCompletionBlock)completedBlock;

/// Query the disk cache synchronously after checking the memory cache
/// @param key The unique key used to store the wanted imageSize
-(CGSize)imageSizeFromCacheForKey:(NSString *)key;

/// Store an reloadState into memory and disk cache at the given key.
/// @param state reloadState
/// @param key The unique reloadState cache key, usually it's image absolute URL
-(BOOL)storeReloadState:(BOOL)state forKey:(NSString *)key;

/// Store an reloadState into memory and disk cache at the given key
/// @param state reloadState
/// @param key The unique reloadState cache key, usually it's image absolute URL
/// @param completedBlock An block that should be executed after the reloadState has been saved (optional)
-(void)storeReloadState:(BOOL)state forKey:(NSString *)key completed:(TSWebImageAutoSizeCacheCompletionBlock)completedBlock;

/// Query the disk cache synchronously after checking the memory cache
/// @param key The unique key used to store the wanted reloadState
-(BOOL)reloadStateFromCacheForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
