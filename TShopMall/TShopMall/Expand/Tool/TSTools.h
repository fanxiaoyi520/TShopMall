//
//  TSTools.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTools : NSObject
/** 手机号码的校验 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber;
/** 提现密码的校验 */
+ (BOOL)isWithdrawalPsw:(NSString *)psw;
/** 身份证号校验 */
+ (BOOL)isIdcard:(NSString *)idcardNum;
/** 昵称的校验 */
+ (BOOL)isCorrectNickname:(NSString *)nickname;
/** 获取时间间隔差 */
+ (NSTimeInterval)timeIntervalWithDate:(NSString *)dateString;
/** 获取剩余时间 */
+ (NSString *)getRestTimeWithTimeInterval:(NSTimeInterval)interval;
/** 获取20天后的时间 */
+ (NSString *)getAfter20DaysDate;
///获取版本号
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
