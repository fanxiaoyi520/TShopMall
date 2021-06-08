//
//  UIFont+General.m
//  TSale
//
//  Created by 橙子 on 2020/11/26.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "UIFont+General.h"

@implementation UIFont (General)

+ (CGFloat)fontSize:(CGFloat)size{
    return KRateW(size);
}

+ (UIFont *)font:(FontType)type size:(CGFloat)size{
    return [UIFont fontWithName:[self fontName:type] size:size];
}

+ (NSString *)fontName:(FontType)fontType{
    switch (fontType) {
        case  PingFangSCMedium:
            return  @"PingFangSC-Medium";
        case PingFangSCSemibold:
            return @"PingFangSC-Semibold";
        case TclNumberBold:
            return @"TclNumber-Bold";
        case TclNumberRegular:
            return @"TclNumber-Regular";
        default:
            return @"PingFangSC-Regular";
    }
    return @"PingFangSC-Regular";
}
@end
