//
//  Dialog+Image.h
//  TCLPlus
//
//  Created by OwenChen on 2021/1/4.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "Dialog.h"


@interface Dialog (Image)

#pragma mark - 自动显示弹框

/// 显示普通标题和副标题（顶部有icon图片）
/// @param topIcon 顶部icon图片
/// @param bigIcon icon是否是大图（大图的话宽度与弹框相同，高度置顶；小图的话是34*34 size大小，顶部距离按照规范）
/// @param title 主标题
/// @param subtitle 副标题
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showDialogWithTopIcon:(UIImage *)topIcon
                              bigIcon:(BOOL)bigIcon
                                title:(NSString *)title
                             subtitle:(NSString *)subtitle
                              buttons:(NSArray<NSString *> *)buttons
                          resultBlock:(ResultBlock)resultBlock;

/// 显示普通标题和副标题（副标题是富文本， 顶部icon图片）
/// @param topIcon 顶部icon图片
/// @param bigIcon icon是否是大图（大图的话宽度与弹框相同，高度置顶；小图的话是34*34 size大小，顶部距离按照规范）
/// @param title 主标题
/// @param attributedSubtitle 富文本副标题
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showDialogWithTopIcon:(UIImage *)topIcon
                              bigIcon:(BOOL)bigIcon
                                title:(NSString *)title
                   attributedSubtitle:(NSAttributedString *)attributedSubtitle
                              buttons:(NSArray<NSString *> *)buttons
                          resultBlock:(ResultBlock)resultBlock;

/// 显示本地图片弹框
/// @param title 主标题
/// @param subtitle 副标题
/// @param image 图片
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showImageDialogWithTitle:(NSString *)title
                                subtitle:(NSString *)subtitle
                                   image:(UIImage *)image
                                 buttons:(NSArray<NSString *> *)buttons
                             resultBlock:(ResultBlock)resultBlock;

/// 显示本地图片弹框（图片宽度适应组件）
/// @param title 主标题
/// @param subtitle 副标题
/// @param image 图片
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showFitWidthImageDialogWithTitle:(NSString *)title
                                        subtitle:(NSString *)subtitle
                                           image:(UIImage *)image
                                         buttons:(NSArray<NSString *> *)buttons
                                     resultBlock:(ResultBlock)resultBlock;

/// 显示网络图片弹框
/// @param title 主标题
/// @param subtitle 副标题
/// @param imageUrl 图片地址
/// @param imageWidth 图片宽度
/// @param imageHeight 图片高度
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showImageDialogWithTitle:(NSString *)title
                                subtitle:(NSString *)subtitle
                                imageUrl:(NSString *)imageUrl
                              imageWidth:(CGFloat)imageWidth
                             imageHeight:(CGFloat)imageHeight
                                 buttons:(NSArray<NSString *> *)buttons
                             resultBlock:(ResultBlock)resultBlock;

/// 显示网络图片弹框（图片宽度适应组件）
/// @param title 主标题
/// @param subtitle 副标题
/// @param imageUrl 图片地址
/// @param imageWidth 图片宽度
/// @param imageHeight 图片高度
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showFitWidthImageDialogWithTitle:(NSString *)title
                                        subtitle:(NSString *)subtitle
                                        imageUrl:(NSString *)imageUrl
                                      imageWidth:(CGFloat)imageWidth
                                     imageHeight:(CGFloat)imageHeight
                                         buttons:(NSArray<NSString *> *)buttons
                                     resultBlock:(ResultBlock)resultBlock;


/// 显示网络图片弹框--图片在最上
/// @param imageUrl 图片地址
/// @param placeholder 占位图
/// @param title 主标题
/// @param subtitle 副标题
/// @param imageWithTitleGap 图片跟主标题间隔
/// @param titleWithSubTitleGap 主标题跟副标题间隔
/// @param imageWidth 图片宽度
/// @param imageHeight 图片高度
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)showImageDialogWithImageUrl:(NSString *)imageUrl
                                placeholder:(UIImage *)placeholder
                                      Title:(NSString *)title
                                   subtitle:(NSString *)subtitle
                          imageWithTitleGap:(CGFloat)imageWithTitleGap
                       titleWithSubTitleGap:(CGFloat)titleWithSubTitleGap
                                 imageWidth:(CGFloat)imageWidth
                                imageHeight:(CGFloat)imageHeight
                                    buttons:(NSArray<NSString *> *)buttons
                                resultBlock:(ResultBlock)resultBlock;

#pragma mark - 生成弹框，不自动显示

/// 普通标题和副标题（顶部有icon图片）
/// @param topIcon 顶部icon图片
/// @param bigIcon icon是否是大图（大图的话宽度与弹框相同，高度置顶；小图的话是34*34 size大小，顶部距离按照规范）
/// @param title 主标题
/// @param subtitle 副标题
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)dialogWithTopIcon:(UIImage *)topIcon
                          bigIcon:(BOOL)bigIcon
                            title:(NSString *)title
                         subtitle:(NSString *)subtitle
                          buttons:(NSArray<NSString *> *)buttons
                      resultBlock:(ResultBlock)resultBlock;

/// 普通标题和副标题（副标题是富文本， 顶部icon图片）
/// @param topIcon 顶部icon图片
/// @param bigIcon icon是否是大图（大图的话宽度与弹框相同，高度置顶；小图的话是34*34 size大小，顶部距离按照规范）
/// @param title 主标题
/// @param attributedSubtitle 富文本副标题
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)dialogWithTopIcon:(UIImage *)topIcon
                          bigIcon:(BOOL)bigIcon
                            title:(NSString *)title
               attributedSubtitle:(NSAttributedString *)attributedSubtitle
                          buttons:(NSArray<NSString *> *)buttons
                      resultBlock:(ResultBlock)resultBlock;

/// 本地图片弹框
/// @param title 主标题
/// @param subtitle 副标题
/// @param image 图片
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)imageDialogWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                               image:(UIImage *)image
                             buttons:(NSArray<NSString *> *)buttons
                         resultBlock:(ResultBlock)resultBlock;

/// 本地图片弹框（图片宽度适应组件）
/// @param title 主标题
/// @param subtitle 副标题
/// @param image 图片
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)fitWidthImageDialogWithTitle:(NSString *)title
                                    subtitle:(NSString *)subtitle
                                       image:(UIImage *)image
                                     buttons:(NSArray<NSString *> *)buttons
                                 resultBlock:(ResultBlock)resultBlock;

/// 网络图片弹框
/// @param title 主标题
/// @param subtitle 副标题
/// @param imageUrl 图片地址
/// @param imageWidth 图片宽度
/// @param imageHeight 图片高度
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)imageDialogWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                            imageUrl:(NSString *)imageUrl
                          imageWidth:(CGFloat)imageWidth
                         imageHeight:(CGFloat)imageHeight
                             buttons:(NSArray<NSString *> *)buttons
                         resultBlock:(ResultBlock)resultBlock;

/// 网络图片弹框（图片宽度适应组件）
/// @param title 主标题
/// @param subtitle 副标题
/// @param imageUrl 图片地址
/// @param imageWidth 图片宽度
/// @param imageHeight 图片高度
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)fitWidthImageDialogWithTitle:(NSString *)title
                                    subtitle:(NSString *)subtitle
                                    imageUrl:(NSString *)imageUrl
                                  imageWidth:(CGFloat)imageWidth
                                 imageHeight:(CGFloat)imageHeight
                                     buttons:(NSArray<NSString *> *)buttons
                                 resultBlock:(ResultBlock)resultBlock;


/// 网络图片弹框--图片在最上
/// @param imageUrl 图片地址
/// @param placeholder 占位图
/// @param title 主标题
/// @param subtitle 副标题
/// @param imageWithTitleGap 图片跟主标题间隔
/// @param titleWithSubTitleGap 主标题跟副标题间隔
/// @param imageWidth 图片宽度
/// @param imageHeight 图片高度
/// @param buttons 按钮标题
/// @param resultBlock 结果回调
+ (DialogView *)imageDialogWithImageUrl:(NSString *)imageUrl
                            placeholder:(UIImage *)placeholder
                                  Title:(NSString *)title
                               subtitle:(NSString *)subtitle
                      imageWithTitleGap:(CGFloat)imageWithTitleGap
                   titleWithSubTitleGap:(CGFloat)titleWithSubTitleGap
                             imageWidth:(CGFloat)imageWidth
                            imageHeight:(CGFloat)imageHeight
                                buttons:(NSArray<NSString *> *)buttons
                            resultBlock:(ResultBlock)resultBlock;

@end
