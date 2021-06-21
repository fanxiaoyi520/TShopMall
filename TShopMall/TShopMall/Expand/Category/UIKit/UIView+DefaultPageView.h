//
//  UIView+DefaultPageView.h
//  NavBar
//
//  Created by Doman on 2017/5/2.
//  Copyright © 2017年 Doman. All rights reserved.
//  无网络和无数据提示view扩展类

#import <UIKit/UIKit.h>

#pragma mark - DefaultPageView


@interface DefaultPageView : UIView

@property (nonatomic, copy) void (^didClickReloadBlock)(void);

@property (nonatomic, copy) void (^didPulledDownBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                        title:(NSString *)title
                         tips:(NSString *)tips
                   buttonText:(NSString *)buttonText
                      inserts:(UIEdgeInsets)inserts;

- (void)showImage:(UIImage *)image title:(NSString *)title tips:(NSString *)tips buttonText:(NSString *)buttonText inserts:(UIEdgeInsets)inserts;

@end

#pragma mark - UIView (CDMEmpty)


@interface UIView (CDMEmpty)

// DefaultPageView
@property (nonatomic, strong) DefaultPageView *defaultPageView;

/// 显示缺省页
- (void)showDefaultPageView;

/// 显示缺省页
/// @param image 图片
/// @param tips 描述
/// @param buttonText 刷新按钮文字
- (void)showDefaultPageViewWithImage:(UIImage *)image tips:(NSString *)tips buttonText:(NSString *)buttonText;

/// 显示缺省页
/// @param image 图片
/// @param tips 描述
/// @param buttonText 刷新按钮文字
/// @param inserts 四边距
- (void)showDefaultPageViewWithImage:(UIImage *)image tips:(NSString *)tips buttonText:(NSString *)buttonText inserts:(UIEdgeInsets)inserts;

/// 显示缺省页
/// @param image 图片
/// @param title 标题
/// @param tips 描述
/// @param buttonText 刷新按钮文字
/// @param inserts 四边距
- (void)showDefaultPageViewWithImage:(UIImage *)image
                               title:(NSString *)title
                                tips:(NSString *)tips
                          buttonText:(NSString *)buttonText
                             inserts:(UIEdgeInsets)inserts;

/// 显示缺省页
/// @param image 图片
/// @param tips 描述
- (void)showDefaultPageViewWithImage:(UIImage *)image tips:(NSString *)tips;

/// 隐藏缺省页
- (void)hideDefaultPageView;

/// 刷新按钮点击事件回调
/// @param block 点击回调
- (void)configReloadAction:(void (^)(void))block;

/// 下拉事件回调
/// @param block 下拉事件回调
- (void)configPullDownAction:(void (^)(void))block;

@end
