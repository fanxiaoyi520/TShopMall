//
//  ImageDialogModel.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/18.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "BasicDialogModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface ImageDialogModel : BasicDialogModel

/// 图片宽度适应
@property (nonatomic, assign) BOOL imageFitWidth;
/// 图片width
@property (nonatomic, assign) CGFloat imageWidth;
/// 图片Height
@property (nonatomic, assign) CGFloat imageHeight;

/// 图片
@property (nonatomic, strong) UIImage *image;

/// 网络图片Url
@property (nonatomic, copy) NSString *imgUrl;

/// 占位图
@property (nonatomic, strong) UIImage *placeholder;

/// 图片四周边距
@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets;

@end

NS_ASSUME_NONNULL_END
