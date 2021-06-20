//
//  TSWebImageAutoSize.m
//  TSale
//
//  Created by 陈洁 on 2021/1/11.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSWebImageAutoSize.h"

static CGFloat const estimateDefaultHeight = 300;

@implementation TSWebImageAutoSize

+(CGFloat)imageHeightForURL:(NSURL *)url layoutWidth:(CGFloat)layoutWidth estimateHeight:(CGFloat )estimateHeight{
    CGFloat showHeight = estimateDefaultHeight;
    if(estimateHeight) showHeight = estimateHeight;
    if(!url || !layoutWidth) return showHeight;
    CGSize size = [self imageSizeFromCacheForURL:url];
    CGFloat imgWidth = size.width;
    CGFloat imgHeight = size.height;
    if(imgWidth>0 && imgHeight >0)
    {
        showHeight = layoutWidth/imgWidth*imgHeight;
    }
    return showHeight;
}

+(void)storeImageSize:(UIImage *)image forURL:(NSURL *)url completed:(TSWebImageAutoSizeCacheCompletionBlock)completedBlock{
    
    [[TSWebImageAutoSizeCache shardCache] storeImageSize:image forKey:[self cacheKeyForURL:url] completed:completedBlock];
    
}
+(void)storeReloadState:(BOOL)state forURL:(NSURL *)url completed:(TSWebImageAutoSizeCacheCompletionBlock)completedBlock{

    [[TSWebImageAutoSizeCache shardCache] storeReloadState:state forKey:[self cacheKeyForURL:url] completed:completedBlock];
     
}
+(CGSize )imageSizeFromCacheForURL:(NSURL *)url{
    return [[TSWebImageAutoSizeCache shardCache] imageSizeFromCacheForKey:[self cacheKeyForURL:url]];
}

+(BOOL)reloadStateFromCacheForURL:(NSURL *)url{

  return [[TSWebImageAutoSizeCache shardCache] reloadStateFromCacheForKey:[self cacheKeyForURL:url]];
}

#pragma mark - TSWebImageAutoSize (private)

+(NSString *)cacheKeyForURL:(NSURL *)url{
    return [url absoluteString];
}

@end
