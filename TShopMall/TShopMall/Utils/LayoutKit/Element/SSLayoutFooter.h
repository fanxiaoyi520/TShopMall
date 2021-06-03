//
//  SSLayoutFooter.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSSupplementaryElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutFooter : SSSupplementaryElement

/// 距离最后一个Item的距离（纵向-上方 横向-左边）
@property(nonatomic, assign) CGFloat topMargin;

@end

NS_ASSUME_NONNULL_END
