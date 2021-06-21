//
//  RefreshGifFooter.h
//  TCLPlus
//
//  Created by kobe on 2020/10/21.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "MJRefreshAutoFooter.h"

NS_ASSUME_NONNULL_BEGIN


@interface RefreshGifFooter : MJRefreshAutoFooter

/// 设置state状态下的文字
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;
/// 隐藏刷新状态的文字
@property (assign, nonatomic, getter=isRefreshingTitleHidden) BOOL refreshingTitleHidden;

@end

NS_ASSUME_NONNULL_END
