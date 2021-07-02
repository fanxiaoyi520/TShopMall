//
//  ImageCropper.h
//  TCLPlus
//
//  Created by OwenChen on 2020/10/15.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSBaseViewController.h"

@class ImageCropper;

typedef void (^ImageCropperCancel)(ImageCropper *cropping);
typedef void (^ImageCropperSure)(ImageCropper *cropping, UIImage *croppedImage);


@interface ImageCropper : TSBaseViewController

/// 取消回调
@property (nonatomic, copy) ImageCropperCancel cancelBlock;

/// 确定回调
@property (nonatomic, copy) ImageCropperSure sureBlock;

/**
 裁剪的图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 裁剪区域
 */
@property (nonatomic, assign) CGSize cropSize;

/**
 是否裁剪成圆形
 */
@property (nonatomic, assign) BOOL isRound;

@end
