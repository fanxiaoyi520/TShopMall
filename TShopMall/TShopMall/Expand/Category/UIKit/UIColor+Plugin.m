//
//  UIColor+Plugin.m
//  TCLPlus
//
//  Created by OwenChen on 2021/1/25.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "UIColor+Plugin.h"


@implementation UIColor (Plugin)

- (UIImage *)image {
    CGRect rect = CGRectMake(0.0, 0.0, 10, 10);

    UIGraphicsBeginImageContext(CGSizeMake(10, 10));

    CGContextRef ref = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(ref, [self CGColor]);

    CGContextFillRect(ref, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
}

+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha {
    //去除空格
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    //把开头截取
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    // 6位或8位(带透明度)
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    //取出透明度、红、绿、蓝
    unsigned int a, r, g, b;
    NSRange range;
    range.location = 0;
    range.length = 2;

    if (cString.length == 8) {
        // a
        NSString *aString = [cString substringWithRange:range];
        // r
        range.location = 2;
        NSString *rString = [cString substringWithRange:range];
        // g
        range.location = 4;
        NSString *gString = [cString substringWithRange:range];
        // b
        range.location = 6;
        NSString *bString = [cString substringWithRange:range];

        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];

        return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:(a / 255.0f)];
    } else {
        // r
        NSString *rString = [cString substringWithRange:range];
        // g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        // b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];

        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];

        return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:alpha];
    }
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [UIColor colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)colorWithRGB:(CGFloat)rgbValue Alpha:(CGFloat)alpha {
    return [self colorWithR:rgbValue G:rgbValue B:rgbValue Alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(int)hex {
    return [UIColor colorWithR:(float)((hex & 0xFF0000) >> 16) G:(float)((hex & 0xFF00) >> 8) B:(float)(hex & 0xFF) Alpha:1.0];
}

+ (UIColor *)colorWithRGBHex:(int)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithR:(float)((hex & 0xFF0000) >> 16) G:(float)((hex & 0xFF00) >> 8) B:(float)(hex & 0xFF) Alpha:alpha];
}


+ (NSString *)hexStringWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue {
    NSString *prefix = @"#";
    NSString *redHex = [self hexStringWithCGFloat:red];
    NSString *greenHex = [self hexStringWithCGFloat:green];
    NSString *blueHex = [self hexStringWithCGFloat:blue];
    return [NSString stringWithFormat:@"%@%@%@%@", prefix, redHex, greenHex, blueHex];
}

+ (NSString *)hexStringWithCGFloat:(CGFloat)floatValue {
    int leftValue = (int)floatValue / 16;
    int rightValue = (int)floatValue % 16;
    return [NSString stringWithFormat:@"%@%@", [self hexStringWithInt:leftValue], [self hexStringWithInt:rightValue]];
}

+ (NSString *)hexStringWithInt:(int)intValue {
    int remain = intValue / 16;
    int hexNumber = intValue % 16;
    NSString *singleNum = nil;

    switch (hexNumber) {
        case 10:
            singleNum = @"A";
            break;

        case 11:
            singleNum = @"B";
            break;

        case 12:
            singleNum = @"C";
            break;

        case 13:
            singleNum = @"D";
            break;

        case 14:
            singleNum = @"E";
            break;

        case 15:
            singleNum = @"F";
            break;

        default:
            singleNum = [NSString stringWithFormat:@"%d", intValue];
            break;
    }
    if (remain > 0) {
        return [[self hexStringWithInt:remain] stringByAppendingString:singleNum];
    } else {
        return singleNum;
    }
}

+ (UIColor *)mixColor1:(UIColor *)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio {
    if (ratio > 1) ratio = 1;

    const CGFloat *components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat *components2 = CGColorGetComponents(color2.CGColor);

    CGFloat r = components1[0] * ratio + components2[0] * (1 - ratio);
    CGFloat g = components1[1] * ratio + components2[1] * (1 - ratio);
    CGFloat b = components1[2] * ratio + components2[2] * (1 - ratio);

    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
