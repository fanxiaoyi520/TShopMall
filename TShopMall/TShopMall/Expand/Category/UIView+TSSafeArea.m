//
//  UIView+TSSafeArea.m
//  TSale
//
//  Created by Daqin He on 2020/11/26.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "UIView+TSSafeArea.h"

@implementation UIView (TSSafeArea)

- (UIEdgeInsets)ts_safeAreaInsets {
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0); //默认有状态栏的高度
    if (@available(iOS 11.0, *)) {
        inset = self.safeAreaInsets;
    }
    return inset;
}

- (CGFloat)statusBarHight {
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    }
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (CGFloat)bottomSafeAreaHeight{
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        return window.safeAreaInsets.bottom;
    }
    return 0.f;
}

@end
