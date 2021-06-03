//
//  SSLayoutCrossTransformSection.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/27.
//

#import "SSLayoutCrossSection.h"

typedef NS_ENUM(NSUInteger, SSLayoutCrossTransformType){
    SSLayoutCrossTransformTypeNone,     //none
    SSLayoutCrossTransformTypeScale,    //缩小0.9 + 0.1进度
    SSLayoutCrossTransformTypeCrooked,  //M_PI_4 * 0.5 * 进度
    SSLayoutCrossTransformTypeFold      //折叠效果
};

/// Cell是需要做处理的cell,  progress是指cell中心点到屏幕边缘移动的进度  -1 ~ 1   0为在最中间  -1在左边  1在右边
typedef void(^SSLayoutCrossTransformBlock)(UICollectionViewCell *cell, CGFloat progress);

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutCrossTransformSection : SSLayoutCrossSection

@end

NS_ASSUME_NONNULL_END
