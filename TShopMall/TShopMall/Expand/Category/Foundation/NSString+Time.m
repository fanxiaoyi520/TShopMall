//
//  NSString+Time.m
//  TCLPlus
//
//  Created by kobe on 2020/8/10.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <CoreText/CoreText.h>

#import "NSString+Time.h"


@implementation NSString (Time)


+ (NSString *)compareCurrentTime:(NSDate *)compareDate {
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    if (timeInterval < 60) {
        return [NSString stringWithFormat:@"刚刚"];
    } else if ((temp = timeInterval / 60) < 60) {
        return [NSString stringWithFormat:@"%ld分钟前", temp];
    } else if ((temp = temp / 60) < 24) {
        return [NSString stringWithFormat:@"%ld小时前", temp];
    } else if ((temp = temp / 24) < 30) {
        return [NSString stringWithFormat:@"%ld天前", temp];
    } else if ((temp = temp / 30) < 12) {
        return [NSString stringWithFormat:@"%ld月前", temp];
    } else {
        temp = temp / 12;
        return [NSString stringWithFormat:@"%ld年前", temp];
    }
}


+ (CGFloat)calculatorTextHeight:(NSAttributedString *)string maxWidth:(CGFloat)maxWidth {
    CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)string;
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString(attributedStringRef);
    CFRange range = CFRangeMake(0, string.length);
    CFRange fitCFRange = CFRangeMake(0, 0);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, range, NULL, CGSizeMake(maxWidth, INT_MAX), &fitCFRange);
    CFRelease(frameSetterRef);
    frameSetterRef = nil;
    return roundf(size.height);
}


+ (CGSize)caculatorTextSize:(NSAttributedString *)string maxWdith:(CGFloat)maxWidth {
    CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)string;
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString(attributedStringRef);
    CFRange range = CFRangeMake(0, string.length);
    CFRange fitCFRange = CFRangeMake(0, 0);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, range, NULL, CGSizeMake(maxWidth, INT_MAX), &fitCFRange);
    CFRelease(frameSetterRef);
    frameSetterRef = nil;
    return size;
}


+ (NSInteger)getNumberOfLinesWithString:(NSAttributedString *)string maxWidth:(CGFloat)maxWidth {
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxWidth, INT_MAX));
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), path, NULL);
    CFArrayRef rows = CTFrameGetLines(frameRef);
    NSInteger numberOfLines = CFArrayGetCount(rows);
    CFRelease(frameRef);
    CGPathRelease(path);
    CFRelease(frameSetterRef);
    return numberOfLines;
}


+ (NSRange)getRangeOfRowsWithString:(NSAttributedString *)string rows:(NSUInteger)rows maxWidth:(CGFloat)maxWidth {
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxWidth, INT_MAX));
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frameRef);
    NSRange range = NSMakeRange(0, 0);
    for (NSInteger i = 0; i < lines.count; i++) {
        if (i == (rows - 1)) {
            id line = lines[i];
            CTLineRef lineRef = (__bridge CTLineRef)line;
            CFRange lineRange = CTLineGetStringRange(lineRef);
            range = NSMakeRange(lineRange.location, lineRange.length);
            break;
        }
    }

    // free
    CFRelease(frameRef);
    CGPathRelease(path);
    CFRelease(frameSetterRef);
    return range;
}


+ (NSString *)repalceStringWithAsterisk:(NSString *)string {
    if (string.length <= 3) {
        return nil;
    }

    NSString *str1 = [string substringToIndex:3];
    NSString *str2 = [string substringFromIndex:string.length - 3];
    NSString *str = [NSString stringWithFormat:@"%@ **** %@", str1, str2];
    return str;
}


+ (NSString *)repalcePhoneStringWithAsterisk:(NSString *)string {
    if (string.length <= 3) {
        return nil;
    }

    NSString *str1 = [string substringToIndex:3];
    NSString *str2 = [string substringFromIndex:string.length - 4];
    NSString *str = [NSString stringWithFormat:@"%@ **** %@", str1, str2];
    return str;
}


+ (NSString *)formatterPhoneWithLine:(NSString *)string {
    NSString *str1 = [string substringToIndex:3];
    NSString *str2 = [string substringWithRange:NSMakeRange(3, 4)];
    NSString *str3 = [string substringFromIndex:string.length - 4];
    NSString *str = [NSString stringWithFormat:@"%@-%@-%@", str1, str2, str3];
    return str;
}


+ (NSString *)formatterPhoneWithSpace:(NSString *)string {
    NSString *str1 = [string substringToIndex:3];
    NSString *str2 = [string substringWithRange:NSMakeRange(3, 4)];
    NSString *str3 = [string substringFromIndex:string.length - 4];
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@", str1, str2, str3];
    return str;
}


+ (BOOL)validateNickName:(NSString *)nickName {
    NSString *regexp = @"^[a-zA-Z0-9\u4E00-\u9FA5]{2,14}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:nickName];
}


+ (BOOL)validatePhone:(NSString *)phone {
    NSString *regexp = @"^1[0-9]{10}";
    //    NSString *regexp = @"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[189])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:phone];
}

+ (BOOL)validateTelePhone:(NSString *)telePhone {
    NSString *regexp = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:telePhone];
}


+ (BOOL)validatePassword:(NSString *)password {
    //    NSString *regexp = @"^((?![0-9]+$)(?![a-zA-Z]+$)(?![~!@#$^&|*-_+=.?,]+$))[0-9A-Za-z~!@#$^&|*-_+=.?,]{8,16}$";
    NSString *regexp = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:password];
}


+ (BOOL)validateCode:(NSString *)code {
    NSString *regexp = @"^[0-9]{4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:code];
}


/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *     1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *     2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *     3，将加法和加上校验位能被 10 整除。
 */
+ (BOOL)validateBankCard:(NSString *)bankCard {
    // 取出最后一位
    NSString *lastNum = [[bankCard substringFromIndex:(bankCard.length - 1)] copy];

    // 前 15 或 18 位
    NSString *forwardNum = [[bankCard substringToIndex:(bankCard.length - 1)] copy];

    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardNum.length; i++) {
        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }

    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];

    // 前 15 位或者前 18 位倒序存进数组
    for (int i = (int)(forwardArr.count - 1); i > -1; i--) {
        [forwardDescArr addObject:forwardArr[i]];
    }

    // 奇数位 *2 的积 < 9
    NSMutableArray *arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];

    // 奇数位 *2 的积 > 9
    NSMutableArray *arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];

    // 偶数位数组
    NSMutableArray *arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i < forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i % 2) { // 偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        } else { // 奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            } else {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }

    __block NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];

    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];

    __block NSInteger sumEvenNumTotal = 0;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];

    NSInteger lastNumber = [lastNum integerValue];

    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;

    return (luhmTotal % 10 == 0) ? YES : NO;
}


+ (BOOL)validateCompanyCard:(NSString *)bankCard {
    NSString *regexp = @"^[1-9]\\d{7,29}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:bankCard];
}


+ (BOOL)validateTax:(NSString *)tax {
    NSString *regexp = @"^[A-Z0-9]{15}$|^[A-Z0-9]{18}$|^[A-Z0-9]{20}$";
    //    NSString *taxNoRegex = @"[0-9]\\\\d{13}([0-9]|X)$";
    //    NSString *regexp = @"^[0-9A-HJ-NPQRTUWXY]{2}\\d{6}[0-9A-HJ-NPQRTUWXY]{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:tax];
}


+ (BOOL)validateContainEmoji:(NSString *)string {
    return ([self isContainSystemKeyboardEmoji:string] || [self isContainOtherKeyboardEmoji:string]);
}


/// 是否包含系统自带键盘表情
+ (BOOL)isContainSystemKeyboardEmoji:(NSString *)string {
    __block BOOL containsEmoji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                // surrogate pair
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f9c0) {
                                            containsEmoji = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3 || ls == 0xfe0f || ls == 0xd83c) {
                                        containsEmoji = YES;
                                    }
                                } else {
                                    // non surrogate
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        containsEmoji = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        containsEmoji = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        containsEmoji = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        containsEmoji = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b ||
                                               hs == 0x2b50) {
                                        containsEmoji = YES;
                                    }
                                }
                                if (containsEmoji) {
                                    *stop = YES;
                                }
                            }];
    return containsEmoji;
}


/// 是否包含有第三方键盘表情
+ (BOOL)isContainOtherKeyboardEmoji:(NSString *)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


/// 是否是九宫格键盘
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *tempStr = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for (int i = 0; i < len; i++) {
        if (!([tempStr rangeOfString:string].location != NSNotFound)) return NO;
    }
    return YES;
}

+ (BOOL)validateAllWhiteSpace:(NSString *)string {
    if (!string) {
        return YES;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimeString = [string stringByTrimmingCharactersInSet:set];
        if ([trimeString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (BOOL)validateEmptyString:(NSString *)string {
    if ([string isEqual:[NSNull null]]) {
        return YES;
    } else if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (string == nil) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)validateSpecialChar:(NSString *)string {
    //    NSString *regexp = @".*[`~!@#$%^&*()+=|{}':;',\\[\\]. <>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？\\\\•_€￡·\\-《》].*";
    NSString *regexp = @".*[`~!@#$%^&()+=|{}':;',\\[\\]. <>/?~！@#￥%……&（）——+|{}【】‘；：”“’。，、？\\\\•_€￡·\\-《》].*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [predicate evaluateWithObject:string];
}

@end
