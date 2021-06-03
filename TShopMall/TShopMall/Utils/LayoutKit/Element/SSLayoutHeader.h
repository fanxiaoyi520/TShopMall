//
//  SSLayoutHeader.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSSupplementaryElement.h"

typedef NS_ENUM(NSInteger, SSLayoutHeaderType){
    SSLayoutHeaderTypeFixed,            // 跟着滚动
    SSLayoutHeaderTypeSuspension,       // 悬浮在顶部（跟着Section滚动）
    SSLayoutHeaderTypeSuspensionAlways, // 悬浮在顶部（不跟随Section滚动，如果出现多个可能会被覆盖）
    SSLayoutHeaderTypeSuspensionBigger  // 仅支持在第一个头部，下拉放大效果
};

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutHeader : SSSupplementaryElement

/// 显示方式（是悬浮还是跟着滚动，默认跟着滚动）
@property(nonatomic, assign) SSLayoutHeaderType type;
/// 悬浮模式时距离顶部的高度（可以用来设置两个悬浮方式，多个顶部悬浮时，可以通过这个来达到层叠悬浮的模式）
@property(nonatomic, assign) CGFloat suspensionTopMargin;
/// 距离第一个Item的距离（纵向-下方 横向-右边）
@property(nonatomic, assign) CGFloat lastMargin;
/// 是否黏在顶部 目前仅支持（SSLayoutHeaderTypeSuspensionAlways SSLayoutHeaderTypeSuspensionBigger），不同的type效果不一样
/// SSLayoutHeaderTypeSuspensionAlways是下拉黏在当前位置 上拉黏在顶部
/// SSLayoutHeaderTypeSuspensionBigger是上拉黏在顶部 下拉时放大效果
@property(nonatomic, assign) BOOL isStickTop;
/// 缩放模式(SuspensionBigger)下最小值  横向-宽度 纵向-高度  该值请务必小于size  默认是0
@property(nonatomic, assign) CGFloat minSize;
/// 缩放模式(SuspensionBigger)下最大值  横向-宽度 纵向-高度  该值请务必大于size  默认是CGFLOAT_MAX
@property(nonatomic, assign) CGFloat maxSize;
@end

NS_ASSUME_NONNULL_END
