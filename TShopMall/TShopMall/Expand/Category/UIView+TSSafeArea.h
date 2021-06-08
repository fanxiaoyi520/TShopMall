//
//  UIView+TSSafeArea.h
//  TSale
//
//  Created by Daqin He on 2020/11/26.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TSSafeArea)

@property(nonatomic, assign, readonly) UIEdgeInsets ts_safeAreaInsets;

@property (nonatomic, assign, readonly) CGFloat statusBarHight;

@property (nonatomic, assign, readonly) CGFloat bottomSafeAreaHeight;
@end

NS_ASSUME_NONNULL_END
