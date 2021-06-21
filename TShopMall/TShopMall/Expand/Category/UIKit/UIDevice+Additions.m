//
//  UIDevice+Additions.m
//  TCLPlus
//
//  Created by lidan on 2020/12/7.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "UIDevice+Additions.h"


@implementation UIDevice (Additions)

+ (BOOL)isNotchDevice {
    return UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 0.0;
}

+ (CGFloat)screenWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+ (CGFloat)screenHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

+ (CGFloat)statusBarHeight {
    return CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}

@end
