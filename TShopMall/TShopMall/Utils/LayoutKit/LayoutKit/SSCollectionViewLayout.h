//
//  SSCollectionViewLayout.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "SSLayoutHeader.h"
#import "SSLayoutFooter.h"
#import "SSLayoutBackground.h"
#import "SSCollectionViewLayoutAttributes.h"
#import "SSLayoutBaseSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSCollectionViewLayout : UICollectionViewLayout

/// 布局方向
@property(nonatomic, assign) SSLayoutDirection direction;
/// 多少个Sections
@property(nonatomic, strong) NSMutableArray <SSLayoutBaseSection *> *sections;
/// 最后固定边距（跟Section的insert无关，contentSize会自动加上去）
@property(nonatomic, assign) CGFloat fixedLastMargin;
/// 是否只计算改变的布局（No为每一次都是重新计算所有布局）
@property(nonatomic, assign) BOOL reLayoutOnlyChanged;
/// 最小可滑动的大小（横向-高度 纵向-宽度）
@property(nonatomic, assign) CGFloat minContentSize;
/// 第一个Section的偏移量
@property(nonatomic, assign) CGFloat firstSectionOffset;

@end

NS_ASSUME_NONNULL_END
