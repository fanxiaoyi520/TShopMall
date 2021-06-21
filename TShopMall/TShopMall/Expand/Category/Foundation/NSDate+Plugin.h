//
//  NSDate+Plugin.h
//  TCLSmartHome
//
//  Created by admin on 2019/7/5.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDate (Plugin)


/**
 *  获取当前时间戳（10位，秒）
 *
 *  @return 返回时间戳
 */
+ (NSString *)mr_Timestamp;

/**
 *  获取当前时间戳（13位，毫秒）
 *
 *  @return 返回时间戳
 */
+ (NSString *)mr_Timestamp13;

/**
 *  NSDate转成字符串
 *
 *  @param date       日期
 *  @param dateFormat 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)mr_StingFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *  时间字符串转成NSDate
 *
 *  @param dateString 时间字符串
 *  @param dateFormat 时间格式
 *
 *  @return NSDate
 */
+ (NSDate *)mr_DateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/**
 *  时间转换成时间戳，时间戳精确到秒(如果再转回NSDate格式，会有精度损失，可能会误差一两秒！)
 *
 *  @param date 时间
 *
 *  @return 返回时间戳
 */
+ (NSString *)mr_secTimestamp:(NSDate *)date;

/**
 时间转换成时间戳，时间戳精确到毫秒

 @param date 时间
 @return 返回时间戳，毫秒精度
 */
+ (NSString *)mr_milTimestamp:(NSDate *)date;

/**
 *  时间戳转换成时间，对应精度秒，10位数的时间戳
 *
 *  @param timeStamp 时间戳
 *
 *  @return 返回时间
 */
+ (NSDate *)mr_DateFromTimeStamp:(NSString *)timeStamp;

/**
 *  获取当前时间详情(yyyy-MM-dd HH:mm:ss)
 *
 *  @return 返回时间
 */
+ (NSString *)mr_DetailTime;

/**
 *  获取当前日期(yyyyMMdd)
 *
 *  @return 返回时间
 */
+ (NSString *)mr_TodayDate;


/// 获取date当天的最后一个时间NSDate
/// @param date NSDate
+ (NSDate *)mr_DateEndByDayWithDate:(NSDate *)date;

/// 获取当天第一个时间NSDate
/// @param date NSDate
+ (NSDate *)mr_DateBeginByDayWithDate:(NSDate *)date;

/// 时间格式转换
/// @param dateString 原始时间 格式为 yyyy-MM-DD HH:MM:SS
/// @param dateFormat 格式，需要的格式
+ (NSString *)mr_StingFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

@end

NS_ASSUME_NONNULL_END
