//
//  MineConst.h
//  TCLPlus
//
//  Created by kobe on 2020/9/29.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "UIColor+Plugin.h"

#ifndef MineConst_h
#define MineConst_h

#define defaultBackgroundColor [UIColor colorWithHexString:@"#F4F4F5"]
#define defaultLineColor [UIColor colorWithHexString:@"#E6E6E6"]
#define defaultRedColor [UIColor colorWithHexString:@"#E64C3D"]
#define defaultDisableColor [UIColor colorWithHexString:@"#DDDDDD"]

#define defaultTextColor [UIColor colorWithHexString:@"#2D3132"]
#define defaultTextColor999 [UIColor colorWithHexString:@"#999999"]
#define defaultTextColor2 [UIColor colorWithHexString:@"#2D3132" alpha:0.2]
#define defaultTextColor4 [UIColor colorWithHexString:@"#2D3132" alpha:0.4]
#define defaultTextColor6 [UIColor colorWithHexString:@"#2D3132" alpha:0.6]

#define defaultTextFont10 [UIFont systemFontOfSize:10]
#define defaultTextFont12 [UIFont systemFontOfSize:12]
#define defaultTextFont14 [UIFont systemFontOfSize:14]
#define defaultTextFont16 [UIFont systemFontOfSize:16]
#define defaultTextFont15 [UIFont systemFontOfSize:15]
#define defaultTextFont18 [UIFont systemFontOfSize:18]
#define defaultTextFont20 [UIFont systemFontOfSize:20]

#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self

#define kTCLStatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
#define kTCLNavBarH (kTCLStatusBarH + 44)
#define kTCLScreenW [UIScreen mainScreen].bounds.size.width
#define kTCLScreenH [UIScreen mainScreen].bounds.size.height

#define kTCLIPhoneX                                                                                     \
    ({                                                                                                  \
        BOOL isPhoneX = NO;                                                                             \
        if (@available(iOS 11.0, *)) {                                                                  \
            isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0; \
        }                                                                                               \
        (isPhoneX);                                                                                     \
    })

#define kTCLTabbarSafeBottomMargin                                                              \
    ({                                                                                          \
        CGFloat bottom = 0.0f;                                                                  \
        if (@available(iOS 11.0, *)) {                                                          \
            bottom = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom; \
        }                                                                                       \
        (bottom);                                                                               \
    })


#define kTCLTabBarHeight (kTCLIPhoneX ? (49.f + (kTCLTabbarSafeBottomMargin)) : 49.f)

#endif /* MineConst_h */
