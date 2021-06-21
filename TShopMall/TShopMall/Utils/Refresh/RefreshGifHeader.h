//
//  RefreshGifHeader.h
//  TCLPlus
//
//  Created by kobe on 2020/10/21.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "MJRefreshGifHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IndicatorStyle) { IndicatorStyleWhite,
                                             IndicatorStyleBlack,
                                             IndicatorStyleRed };


@interface RefreshGifHeader : MJRefreshHeader


@property (nonatomic, assign) IndicatorStyle indicatorStyle;


/// 距离loading图标距离顶部的距离，可适配全屏时候
@property (nonatomic, assign) CGFloat loadingOffsetTop;

@end

NS_ASSUME_NONNULL_END
