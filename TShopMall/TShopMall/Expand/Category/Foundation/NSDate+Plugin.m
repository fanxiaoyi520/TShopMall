//
//  NSDate+Plugin.m
//  TCLSmartHome
//
//  Created by admin on 2019/7/5.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import "NSDate+Plugin.h"


@implementation NSDate (Plugin)

/**
 *  获取当前时间戳
 *
 *  @return 返回时间戳
 */
+ (NSString *)mr_Timestamp {
    return [NSString stringWithFormat:@"%ld", time(NULL)];
}

/**
 *  获取当前时间戳（13位，毫秒）
 *
 *  @return 返回时间戳
 */
+ (NSString *)mr_Timestamp13 {
    double currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *strTime = [NSString stringWithFormat:@"%.0f", currentTime];
    return strTime;
}

/**
 *  NSDate转成字符串
 *
 *  @param date       日期
 *  @param dateFormat 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)mr_StingFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    return [df stringFromDate:date];
}

/**
 *  时间字符串转成NSDate
 *
 *  @param dateString 时间字符串
 *  @param dateFormat 时间格式
 *
 *  @return NSDate
 */
+ (NSDate *)mr_DateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    return [df dateFromString:dateString];
}

/**
 *  时间转换成时间戳，时间戳精确到秒(如果再转回NSDate格式，会有精度损失，可能会误差一两秒！)
 *
 *  @param date 时间
 *
 *  @return 返回时间戳
 */
+ (NSString *)mr_secTimestamp:(NSDate *)date {
    NSTimeInterval a = [date timeIntervalSince1970];               // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

/**
 时间转换成时间戳，时间戳精确到毫秒

 @param date 时间
 @return 返回时间戳，毫秒精度
 */
+ (NSString *)mr_milTimestamp:(NSDate *)date {
    NSTimeInterval a = [date timeIntervalSince1970] * 1000;        // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

/**
 *  获取当前时间详情(yyyy-MM-dd HH:mm:ss)
 *
 *  @return 返回时间
 */
+ (NSString *)mr_DetailTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];

    return currentTimeString;
}

+ (NSDate *)mr_DateFromTimeStamp:(NSString *)timeStamp {
    NSString *arg = timeStamp;

    if (![timeStamp isKindOfClass:[NSString class]]) {
        arg = [NSString stringWithFormat:@"%@", timeStamp];
    }

    NSTimeInterval time = [timeStamp doubleValue]; //因为时差问题要加8小时 == 28800 sec;
    return [NSDate dateWithTimeIntervalSince1970:time];
}

/**
 *  获取当前日期(yyyyMMdd)
 *
 *  @return 返回时间
 */
+ (NSString *)mr_TodayDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // hh与HH的区别:分别表示12小时制,24小时制，一定要小写yyyy
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];

    return currentTimeString;
}

/// 获取date当天的最后一个时间NSDate
/// @param date NSDate
+ (NSDate *)mr_DateEndByDayWithDate:(NSDate *)date {
    NSString *tempTimeString = [NSString stringWithFormat:@"%@ 23:59:59", [NSDate mr_StingFromDate:date dateFormat:@"yyyy-MM-dd"]];
    NSDate *newDate = [NSDate mr_DateFromString:tempTimeString dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return newDate;
}

/// 获取当天第一个时间NSDate
/// @param date NSDate
+ (NSDate *)mr_DateBeginByDayWithDate:(NSDate *)date {
    NSString *tempTimeString = [NSString stringWithFormat:@"%@ 00:00:00", [NSDate mr_StingFromDate:date dateFormat:@"yyyy-MM-dd"]];
    NSDate *newDate = [NSDate mr_DateFromString:tempTimeString dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return newDate;
}
+ (NSString *)mr_StingFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    return [df stringFromDate:[NSDate mr_DateFromString:dateString dateFormat:@"yyyy-MM-dd HH:mm:ss"]];
}

@end
