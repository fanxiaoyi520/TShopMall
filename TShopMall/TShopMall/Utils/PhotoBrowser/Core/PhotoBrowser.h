//
//  PhotoBrowser.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BrowserConfig.h"

#ifdef DEBUG
#define PHOTO_LOG(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
#define PHOTO_LOG(...) ;
#endif

NS_ASSUME_NONNULL_BEGIN

typedef void (^SelectedPhotosBlock)(NSArray *selectedPhotosArray, NSArray *selectedAssets);


@interface PhotoBrowser : NSObject

@property (nonatomic, copy) SelectedPhotosBlock photosBlock; //回调

/// 初始化方法
/// @param config 配置
/// @param superViewController 父控制器
- (instancetype)initWithBrowserConfig:(BrowserConfig *)config superViewController:(UIViewController *)superViewController;

/// 显示
- (void)showPhotoBrowser;

@end

NS_ASSUME_NONNULL_END
