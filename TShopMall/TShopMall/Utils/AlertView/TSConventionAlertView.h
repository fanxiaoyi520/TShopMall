//
//  TSConventionAlertView.h
//  TSale
//
//  Created by Daisy  on 2020/12/7.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TCLAlertItemStyle) {
    
    TCLAlertItemStyleDefault = 0,  //默认类型
    
    TCLAlertItemStyleCancel      //取消
};

typedef NS_ENUM(NSInteger,  TCLAlertViewStyle){
    
    TCLAlertViewStyleActionSheet = 0,  //从 底部弹出
    
    TCLAlertViewStyleAlert             //正常 中间弹出
};

typedef NS_ENUM(NSInteger, TCLAlertViewAnimationStyle) {
    
    TCLAlertViewAnimationStyleDefault = 0 ,      //默认没有动画显示
    
    TCLAlertViewAnimationStyleTransparent,       //渐变显示
    
    TCLAlertViewAnimationStyleSlideFromBottom    //从下往上显示
};

@interface TSConventionAlertItem : NSObject

@property (nonatomic, copy) NSString *title;  //标题

@property (nonatomic, strong) UIFont *titleFont; //标题的字体大小

@property (nonatomic, strong) UIColor *titleColor;   //标题字体颜色

@property (nonatomic, strong) UIColor *backgrooundColor;

@property (nonatomic, assign) TCLAlertItemStyle showStyle;  //展示的弹窗的类型

@property (nonatomic, copy) void (^handler)(TSConventionAlertItem * item);

/**
 *    title  标题
 *    style  类型
 */
+(instancetype)tcl_itemWithTile:(NSString *)title
                          style:(TCLAlertItemStyle)style
                         handle:(void(^)(TSConventionAlertItem * item))handler;

/**
 *     title  标题
 *     bgColor 背景颜色
 *     style  类型
 */
+(instancetype)tcl_itemWithTile:(NSString *)title
                backgroundColor:(UIColor  *)bgColor
                          style:(TCLAlertItemStyle)style
                         handle:(void(^)(TSConventionAlertItem * item))handler;

/**
 *     传入title，
 *     字体大小
 *     style:类型
 */
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler;

/**
 *   传入title
 *   字体颜色
 *   style:类型
 */
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler;

/**
 *   传入title，
 *   字体大小
 *   字体颜色
 *   style:类型
 */
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                       titleColor:(UIColor *)titleColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler;
/**
 *   传入title
 *   字体颜色
 *   背景颜色
 *   style:类型
 */
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                  backgroundColor:(UIColor *)backgroundColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler;

/**
 *   传入title，
 *   字体大小
 *   背景颜色
 *   style:类型
 */
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                  backgroundColor:(UIColor *)backgroundColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler;

/**
 *   传入title，
 *   字体大小
 *   字体颜色
 *   背景颜色
 *   style:类型
 */
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                       titleColor:(UIColor *)titleColor
                  backgroundColor:(UIColor *)backgroundColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler;

@end

@interface TSConventionAlertView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *msg;

//类型
@property (nonatomic, assign) TCLAlertViewStyle preferredStyle;

//显示类型
@property (nonatomic, assign) TCLAlertViewAnimationStyle animationStyle;

//字体大小
@property (nonatomic, strong) UIFont *titleFont;
///
@property (nonatomic, strong) UIFont *msgFont;
///
@property (nonatomic, strong) UIColor *titleColor;
///
@property (nonatomic, strong) UIColor *msgColor;
///
@property (nonatomic, strong) UIColor *viewBackgroundColor;

@property (nonatomic, assign) CGFloat widthMargin; //距离左右边距(左右边距是一样的)

///
@property (nonatomic, strong) UIColor *highliaghtColor;
///
@property (nonatomic, strong) NSString *highliaghtStr;

@property (nonatomic, strong) NSString *prefixStr;
/**
 *   preferredStyle  弹窗类型
 *   msgFont 具体内容字体大小
 *   widthMargin message内容距离左右边距的距离
 *   highlighted 高亮字符
 *   prefixStr  高亮字符之前的字符
 *   highliaghtColor 高亮的颜色
 */
+ (instancetype)tcl_alertViewWithPreferredStyle:(TCLAlertViewStyle)preferredStyle
                                        msgFont:(UIFont *)msgFont
                                    widthMargin:(CGFloat)widthMargin
                                highlightedText:(NSString *)highlighted
                                   hasPrefixStr:(NSString *)prefixStr
                               highlightedColor:(UIColor *)highliaghtColor;

/**
 * title 弹窗题目
 * preferredStyle  弹窗类型
 * msgFont 具体内容字体大小
 * widthMargin message内容距离左右边距的距离
 * highlighted 高亮字符
 * prefixStr  高亮字符之前的字符
 * highliaghtColor 高亮的颜色
 */
+ (instancetype)tcl_alertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                        preferredStyle:(TCLAlertViewStyle)preferredStyle
                               msgFont:(UIFont *)msgFont
                           widthMargin:(CGFloat)widthMargin
                       highlightedText:(NSString *)highlighted
                          hasPrefixStr:(NSString *)prefixStr
                      highlightedColor:(UIColor *)highliaghtColor;

/**
 * preferredStyle  弹窗类型
 * msgFont 具体内容字体大小
 * animationStyle 弹窗动画类型
 * widthMargin message内容距离左右边距的距离
 * highlighted 高亮字符
 * prefixStr  高亮字符之前的字符
 * highliaghtColor 高亮的颜色
 */
+ (instancetype)tcl_alertViewWithPreferredStyle:(TCLAlertViewStyle)preferredStyle
                                 animationStyle:(TCLAlertViewAnimationStyle)animationStyle
                                        msgFont:(UIFont *)msgFont
                                    widthMargin:(CGFloat)widthMargin
                                highlightedText:(NSString *)highlighted
                                   hasPrefixStr:(NSString *)prefixStr
                               highlightedColor:(UIColor *)highliaghtColor;

/**
 * title 弹窗题目
 * preferredStyle  弹窗类型
 * msgFont 具体内容字体大小
 * animationStyle 弹窗动画类型
 * widthMargin message内容距离左右边距的距离
 * highlighted 高亮字符
 * prefixStr  高亮字符之前的字符
 * highliaghtColor 高亮的颜色
 */
+ (instancetype)tcl_alertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                        preferredStyle:(TCLAlertViewStyle)preferredStyle
                        animationStyle:(TCLAlertViewAnimationStyle)animationStyle
                               msgFont:(UIFont *)msgFont
                           widthMargin:(CGFloat)widthMargin
                       highlightedText:(NSString *)highlighted
                          hasPrefixStr:(NSString *)prefixStr
                      highlightedColor:(UIColor *)highliaghtColor;

/**
 * add item
 */
- (void)tcl_addAlertItem:(TSConventionAlertItem *)alertItem;

/**
 *  显示弹窗提示
 */
- (void)tcl_showView;
/**
 *  移除视图
 */
- (void)tcl_hideView;
@end


