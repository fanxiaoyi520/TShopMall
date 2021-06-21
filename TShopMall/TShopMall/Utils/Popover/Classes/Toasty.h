//
//  Toasty.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/13.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageTextPosition) {
    ImageLeftTextRight = 0, // 图片在左，文字在右
    ImageRightTextLeft = 1, // 图片在右，文字在左
};

typedef NS_ENUM(NSInteger, ToastyType) {
    ToastyTypeNormal = 0,      // 普通（不带图片）
    ToastyTypeSuccess = 1,     // 失败
    ToastyTypeFailure = 2,     // 成功
    ToastyTypeInformation = 3, // 提示
};


@interface ToastyModel : NSObject

/// 图片和标题位置
@property (nonatomic, assign) ImageTextPosition imageTextPosition;
/// 主标题
@property (nonatomic, copy) NSString *title;
/// 副标题
@property (nonatomic, copy) NSString *subTitle;
/// 图片
@property (nonatomic, strong) UIImage *image;
/// 时间间隔
@property (nonatomic, assign) CGFloat interval;
/// 是否要停留
@property (nonatomic, assign) BOOL stay;
/// 是否显示背景蒙板
@property (nonatomic, assign) BOOL showMaskView;
/// 类型
@property (nonatomic, assign) ToastyType type;
///指定距离顶部的间距
@property (nonatomic, assign) CGFloat topOffset;

@end


@interface Toasty : UIView

/// 背景色
@property (nonatomic, strong) UIColor *bgColor;
/// 主标题颜色
@property (nonatomic, strong) UIColor *titleColor;
/// 副标题颜色
@property (nonatomic, strong) UIColor *subTitleColor;
/// 圆角
@property (nonatomic, assign) CGFloat cornerRadius;

/// 初始化方法
/// @param frame 位置
/// @param toastyModel 数据模型
/// @param maxWidth 最大宽度
- (instancetype)initWithFrame:(CGRect)frame toastyModel:(ToastyModel *)toastyModel maxWidth:(CGFloat)maxWidth;

/// 改变布局
/// @param frame 位置
/// @param maxWidth 最大宽度
- (void)changeFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;

/// 获取ToastSize
/// @param toastyModel 数据模型
/// @param maxWidth 最大宽度
+ (CGSize)toastySizeWithToastyModel:(ToastyModel *)toastyModel maxWidth:(CGFloat)maxWidth;

@end
