//
//  TSTools.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/11.
//

#import "TSTools.h"

@implementation TSTools

/** 宽松的手机号校验 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    ///去掉空格的手机号
    NSString *_phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (_phoneNumber.length != 11) {
        return NO;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(1[1-9])\\d{9}$"];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    return isMatch;
}

/** 身份证号校验 */
+ (BOOL)isIdcard:(NSString *)idcardNum {
    
    return YES;
}

/** 昵称的校验 */
+ (BOOL)isCorrectNickname:(NSString *)nickname {///
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\u4e00-\u9fa5a-zA-Z0-9_\\-c]{4,20}$"];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

/** 提现密码的校验 */
+ (BOOL)isWithdrawalPsw:(NSString *)psw {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d{6}$"];
    BOOL isMatch = [pred evaluateWithObject:psw];
    return isMatch;
}
/** 获取时间间隔差 */
+ (NSTimeInterval)timeIntervalWithDate:(NSString *)dateString {
    NSDate *date = [NSDate dateWithString:dateString format:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSTimeInterval endInterval = [date timeIntervalSince1970];///获取时间戳
    NSTimeInterval startInterval = [[NSDate date] timeIntervalSince1970];///获取当前时间戳
    NSTimeInterval interval = endInterval - startInterval;
    return interval;
}
/** 获取剩余时间 */
+ (NSString *)getRestTimeWithTimeInterval:(NSTimeInterval)interval {
    if (interval > (24 * 60 * 60)) {///计算天数
        NSInteger day = interval / (24 * 60 * 60);
        NSInteger hourRest = (NSInteger)(interval) % (24 * 60 * 60);
        NSInteger hour = hourRest / (60 * 60);
        NSInteger minuteRest = hourRest % (60 * 60);
        NSInteger minute = minuteRest / 60;
        NSInteger second = minuteRest % 60;
        return [NSString stringWithFormat:@"剩余时间%ld天 %02ld:%02ld:%02ld", (long)day, (long)hour, (long)minute, (long)second];
    }
    if (interval > (60 * 60)) {///小时
        NSInteger hour = interval / (60 * 60);
        NSInteger minuteRest = (NSInteger)(interval) % (60 * 60);
        NSInteger minute = minuteRest / 60;
        NSInteger second = minuteRest % 60;
        return [NSString stringWithFormat:@"剩余时间 %02ld:%02ld:%02ld", (long)hour, (long)minute, (long)second];
    }
    if (interval > 60) {///分钟
        NSInteger minute = interval / 60;
        NSInteger second = (NSInteger)(interval) % 60;
        return [NSString stringWithFormat:@"剩余时间 %02ld:%02ld", (long)minute, (long)second];
    }
    if (interval <= 60) {///秒
        return [NSString stringWithFormat:@"剩余时间 %lds", (long)interval];
    }
    return @"账户已注销";
}
/** 获取20天后的时间 */
+ (NSString *)getAfter20DaysDate {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval after20dayInterval = timeInterval + 20 * 24 * 60 * 60;
    NSDate *day14date = [NSDate dateWithTimeIntervalSince1970:after20dayInterval];
    return [day14date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
///获取版本号
+ (NSString *)getVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

/*
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    ///移动号段正则表达式
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    ///联通号段正则表达式
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    ///电信号段正则表达式
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:phoneNumber];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:phoneNumber];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:phoneNumber];
    
    if (isMatch1 || isMatch2 || isMatch3 ) {
        return YES;
    } else {
        return NO;
    }
}
*/

@end
