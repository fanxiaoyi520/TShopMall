//
//  BrowserConfig.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BrowserType) {
    BrowserTypeAlbum = 0,  // 相册
    BrowserTypeCamera = 1, // 摄像头
    BrowserTypeSheet = 2,  // 选择
};


@interface BrowserConfig : NSObject

#pragma mark - 相册
@property (nonatomic, assign) NSInteger maxImagesCount;       ///<最大选择图片数
@property (nonatomic, assign) NSInteger columnNumber;         /// 每行显示多少张图片
@property (nonatomic, assign) BOOL showSelectBtn;             ///< 在单选模式下，照片列表页中，显示选择按钮,默认为NO
@property (nonatomic, assign) BOOL allowCrop;                 ///< 允许裁剪,默认为YES，showSelectBtn为NO才生效
@property (nonatomic, assign) BOOL needCircleCrop;            ///< 裁剪圆形
@property (nonatomic, assign) BOOL allowPickingVideo;         /// 是否可选择视频
@property (nonatomic, assign) BOOL allowPickingImage;         /// 是否可选择图片
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto; ///<是否可选原图
@property (nonatomic, assign) BOOL allowPickingGif;           ///<是否可选择gif

#pragma mark - 相机
@property (nonatomic, assign) BOOL showTakeVideoBtn; ///<是否显示拍摄视频按钮
@property (nonatomic, assign) BOOL showTakePhotoBtn; ///<是否显示拍摄照片按钮

#pragma mark - 通用
@property (nonatomic, assign) BrowserType type; //选择类型

#pragma mark - 压缩 （只用于选择当个图片的时候:maxImagesCount 为1）
@property (nonatomic, assign) BOOL needCompress;         // 需要压缩
@property (nonatomic, assign) CGFloat maxCompressLength; // 指定压缩到多少字节以内

@end

NS_ASSUME_NONNULL_END
