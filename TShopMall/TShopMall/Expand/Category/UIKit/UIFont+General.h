//
//  UIFont+General.h
//  TSale
//
//  Created by 橙子 on 2020/11/26.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FontType) {
    PingFangSCRegular     = 0,
    PingFangSCMedium            ,
    PingFangSCSemibold         ,
    TclNumberBold                  ,
    TclNumberRegular
};


@interface UIFont (General)
+ (CGFloat)fontSize:(CGFloat)size;
+ (UIFont *)font:(FontType)type size:(CGFloat)size;
@end
