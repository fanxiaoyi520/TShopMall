//
//  UIDevice+Additions.h
//  TCLPlus
//
//  Created by lidan on 2020/12/7.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIDevice (Additions)

/// 是否为刘海屏
@property (nonatomic, assign, class, readonly, getter=isNotchDevice) BOOL notchDevice;

@property (nonatomic, assign, class, readonly) CGFloat screenWidth;

@property (nonatomic, assign, class, readonly) CGFloat screenHeight;

@property (nonatomic, assign, class, readonly) CGFloat statusBarHeight;

@end

NS_ASSUME_NONNULL_END
