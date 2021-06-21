//
//  NSString+Time.h
//  TCLPlus
//
//  Created by kobe on 2020/8/10.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Time)

+ (NSString *)compareCurrentTime:(NSDate *)compareDate;

/// 计算文本高度
/// @param string NSAttributedString
/// @param maxWidth 文本的最大宽度
+ (CGFloat)calculatorTextHeight:(NSAttributedString *)string maxWidth:(CGFloat)maxWidth;

/// 计算文本尺寸
/// @param string NSAttributedString
/// @param maxWidth 文本的最大宽度
+ (CGSize)caculatorTextSize:(NSAttributedString *)string maxWdith:(CGFloat)maxWidth;

/// 计算文本行数
/// @param string NSAttributedString
/// @param maxWidth 文本的最大宽度
+ (NSInteger)getNumberOfLinesWithString:(NSAttributedString *)string maxWidth:(CGFloat)maxWidth;


+ (NSRange)getRangeOfRowsWithString:(NSAttributedString *)string rows:(NSUInteger)rows maxWidth:(CGFloat)maxWidth;

/// 使用星号代替中间字符串
+ (NSString *)repalceStringWithAsterisk:(NSString *)string;

/// 使用星号代替手机号码中间字符串 example 158****8898
+ (NSString *)repalcePhoneStringWithAsterisk:(NSString *)string;

/// 格式化手机号码 example: 157-7878-9989
+ (NSString *)formatterPhoneWithLine:(NSString *)string;

/// 格式化手机号码 example: 157 7878 9989
+ (NSString *)formatterPhoneWithSpace:(NSString *)string;

/// 验证用户昵称 2-14 位
+ (BOOL)validateNickName:(NSString *)nickName;

/// 验证手机号码
+ (BOOL)validatePhone:(NSString *)phone;

/// 校验是否是座机
+ (BOOL)validateTelePhone:(NSString *)telePhone;

/// 验证密码 6-18位
+ (BOOL)validatePassword:(NSString *)password;

/// 验证验证码 4 位
+ (BOOL)validateCode:(NSString *)code;

/// 验证银行卡号
+ (BOOL)validateBankCard:(NSString *)bankCard;

/// 校验对公银行卡号
+ (BOOL)validateCompanyCard:(NSString *)bankCard;

/// 验证发票税号
+ (BOOL)validateTax:(NSString *)tax;

/// 验证是否有表情
+ (BOOL)validateContainEmoji:(NSString *)string;

/// 验证是否是全是空格
+ (BOOL)validateAllWhiteSpace:(NSString *)string;

/// 验证字符串是否为空
+ (BOOL)validateEmptyString:(NSString *)string;

+ (BOOL)validateSpecialChar:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
