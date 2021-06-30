//
//  DialogView.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/18.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TextShouldChangeResModel.h"

#import "ButtonsDialogElement.h"
#import "DialogResult.h"
#import "ImageDialogElement.h"
#import "SelectorDialogElement.h"
#import "TextDialogElement.h"
#import "TextFieldDialogElement.h"
#import "TextViewDialogElement.h"

NS_ASSUME_NONNULL_BEGIN
/**
 出现时动画

 - ShowAnimationFromTop: 从上往下
 - ShowAnimationFromLeft: 从左往右
 - ShowAnimationFromBottom: 从下往上
 - ShowAnimationFromRight: 从右往左
 - ShowAnimationFade: 渐渐显示（透明度动画）
 - ShowAnimationNone: 无动画（默认）
 */
typedef NS_ENUM(NSInteger, ShowAnimation) {
    ShowAnimationFromTop = 0,
    ShowAnimationFromLeft = 1,
    ShowAnimationFromBottom = 2,
    ShowAnimationFromRight = 3,
    ShowAnimationFade = 4,
    ShowAnimationNone = 5,
};

/**
 弹框弹出后停留状态

 - DialogPositionMiddle: 停在中间
 - DialogPositionBottom: 停在下面
 - DialogPositionTop: 停在上面
 */
typedef NS_ENUM(NSInteger, DialogPosition) { DialogPositionMiddle = 0,
                                             DialogPositionBottom = 1,
                                             DialogPositionTop = 2 };

/** 显示回调 */
typedef void (^ShowBlock)(void);
/** 消失回调 */
typedef void (^CloseBlock)(void);
/** 从队列移除回调 */
typedef void (^UnholdInQueueBlock)(void);
/** 点击按钮回调 */
typedef BOOL (^ResultBlock)(DialogResult *result);
/** 输入框即将输入文字，返回有NSString则表示不允许这次修改，并且在TextField/TextView下面提示NSString。传回NSString为nil或者为空字符串则表示允许修改 */
typedef TextShouldChangeResModel *_Nullable (^TextShouldChangeBlock)(id inputView, NSRange changeRange, NSString *replacementText);
/** 输入框已经输入文字，并且在TextField/TextView下面提示NSString。传回NSString为nil或者为空字符串则清空提示 */
typedef NSString *_Nullable (^TextDidChangeBlock)(id inputView);


@interface DialogView : UIView

/**
 显示回调
 */
@property (nonatomic, copy) ShowBlock showBlock;

/**
 消失回调
 */
@property (nonatomic, copy) CloseBlock closeBlock;

/**
 从队列移除回调
 */
@property (nonatomic, copy) UnholdInQueueBlock unholdInQueueBlock;

/**
 结果回调
 */
@property (nonatomic, copy) ResultBlock resultBlock;

/**
 输入框即将输入文字，返回有NSString则表示不允许这次修改，并且在TextField/TextView下面提示NSString。传回NSString为nil或者为空字符串则表示允许修改
*/
@property (nonatomic, copy) TextShouldChangeBlock textShouldChangeBlock;

/**
 输入框已经输入文字，并且在TextField/TextView下面提示NSString。传回NSString为nil或者为空字符串则清空提示
*/
@property (nonatomic, copy) TextDidChangeBlock textDidChangeBlock;

#pragma mark - Public Methods

/// 初始化
/// @param dialogModels 数据
/// @param animation 出场动画
/// @param position 位置
/// @param sideTap 是否可点击周边
/// @param bounce 是否弹性动画
- (instancetype)initWithDialogModels:(NSArray *)dialogModels
                           animation:(ShowAnimation)animation
                            position:(DialogPosition)position
                             sideTap:(BOOL)sideTap
                              bounce:(BOOL)bounce;

/// 初始化
/// @param customView 自定义视图
/// @param customViewHeight 自定义视图高度
/// @param animation 出场动画
/// @param position 位置
/// @param sideTap 是否可点击周边
/// @param bounce 是否弹性动画
- (instancetype)initWithCustomView:(UIView *)customView
                  customViewHeight:(CGFloat)customViewHeight
                         animation:(ShowAnimation)animation
                          position:(DialogPosition)position
                           sideTap:(BOOL)sideTap
                            bounce:(BOOL)bounce;

/// 初始化
/// @param customView 自定义视图
/// @param customViewSize 自定义视图宽高（宽度按照规范）
/// @param animation 出场动画
/// @param position 位置
/// @param sideTap 是否可点击周边
/// @param bounce 是否弹性动画
- (instancetype)initWithCustomView:(UIView *)customView
                    customViewSize:(CGSize)customViewSize
                         animation:(ShowAnimation)animation
                          position:(DialogPosition)position
                           sideTap:(BOOL)sideTap
                            bounce:(BOOL)bounce;

/** 弹出 */
- (void)showDialogView;

/** 关闭 */
- (void)closeDialogView;

/** 关闭 */
- (void)closeDialogViewWithHoldInQueue:(BOOL)holdInQueue;

/** 从队列中移除 */
- (void)unholdInQueue;

/** 关闭 */
- (void)closeDialogViewWithAnimation:(BOOL)animation holdInQueue:(BOOL)holdInQueue;

/// 开启键盘
- (void)becomeFirstResponder;

/// 关闭键盘
- (void)resignFirstResponder;

/** 设置是否可点击周边空白区关闭 */
- (void)sideTapEnable:(BOOL)enable;

/** 使某个按钮重新恢复点击事件 */
- (void)enableButtonAtIndex:(NSInteger)buttonIndex;

/**使某个按钮无法点击。*/
- (void)disabledButtonAtIndex:(NSInteger)buttonIndex;

/// 提醒（输入框类型的弹框）
/// @param errorTips 提醒文案
- (void)showErrorTips:(NSString *)errorTips;

/// 弹框宽度
+ (CGFloat)contentWidth;

/// 限制textfield最大长度限制输入，返回YES表示文本框内容超出了10，被限制了，NO表示未超出。用来判断是否需要显示超出长度错误提示
/// 该方法需要放在UITextfield的通知UITextFieldTextDidChangeNotification中进行判断。
/// 用该方法判断的好处是可以解决中文联想输入时联想内容超出长度无法输入问题。
/// @param textField 输入框
/// @param maxLength 最大长度
+ (BOOL)limitTextField:(UITextField *)textField maxLength:(NSInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
