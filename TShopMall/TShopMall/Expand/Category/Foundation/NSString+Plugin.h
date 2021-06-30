//
//  NSString+Plugin.h
//  TCLSmartHome
//
//  Created by admin on 2019/7/19.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static inline BOOL TStringIsEmpty(NSString *str) {
    if (str && [str isKindOfClass:[NSString class]]) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (str.length > 0) {
            return NO;
        }
    }
    return YES;
}

static inline NSString *TStringToString(NSString *str) { return TStringIsEmpty(str) ? @"" : str; }


@interface NSString (Plugin)

@property (nonatomic, copy, readonly) NSString *toMD5;
@property (nonatomic, copy, readonly) NSString *toSHA1;
@property (nonatomic, copy, readonly) NSString *mqttReply;
@property (nonatomic, copy, readonly) NSData *base64Decode;

/// 针对单个字符，是否是数字
@property (nonatomic, assign, readonly) BOOL isNumber;

/// 是否含有英文汉字数字以外的字符
@property (nonatomic, assign, readonly) BOOL hasIllegalCharacter;
@property (nonatomic, assign, readonly) BOOL isChinese;
@property (nonatomic, assign, readonly) BOOL isHaveChinese;

@property (nonatomic, copy, readonly) NSString *tcl_AES128Encrypt;
@property (nonatomic, copy, readonly) NSString *tcl_AES128Decrypt;
@property (nonatomic, copy, readonly) NSString *base64Encrypt;
@property (nonatomic, copy, readonly) NSString *base64Decrypt;

/**
 *  检查字符是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  去除字符串尾部空格
 *
 *  @param string 字符串
 *
 *  @return 返回值
 */
+ (NSString *)cmString:(NSString *)string;

/**
 *  去除字符串首尾空格
 *
 *  @param string 字符串
 *
 *  @return 返回值
 */
+ (NSString *)removeHEString:(NSString *)string;

/// 字符串后依次累加数字
- (NSString *)appendNumberToString;

/// 避免和某组字符串重复
/// @param strings 字符串数组
- (NSString *)stringWithOutDuplicateToArray:(NSArray<NSString *> *)strings;

/// 获取描述日期，周一，周二，周末，每天等
- (NSString *)repeatDayName;

/**
 获取描述性时间
 e.g.
 2017-05-11 上午 02:40
 下午 01:55
 昨天 下午 01:55

 @param sendTime 格式为2017-05-10 14:40:19
 @return 时间描述
 */
+ (NSString *)compareDate:(NSString *)sendTime;

- (NSString *)percentEscapedString;

/// 解析RN字符串
/// @param completion 回调Block
- (void)rnStringAnalizeWithCompletion:(void (^)(NSString *ip, NSString *packageName, NSDictionary *_Nullable parameters))completion;

/// AES128加密，key为16位及以下，如果不是16位，默认处理为加空补齐16位
/// @param plainText 原文
/// @param key 密钥
+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

/// AES128解密
/// @param encryptText 密文
/// @param key 密钥
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

/// APP唯一标识，除非卸载APP否则不会改变
+ (NSString *)applicationUUID;

/// 判断字符串是否包含Emoji表情
- (BOOL)containsEmoji;

/// 获取UUID，每次获取都不一样
+ (NSString *)ramUUID;

+ (NSString *)appdingString:(NSString *)string component:(NSString *)component;


/// 是否是手机号，简单判断是否是1开头，后面跟10个数字
- (BOOL)isValidMobile;

/// JSON字符串转化为字典/数组
+ (id)jsonObjectWithJsonString:(NSString *)jsonStr;

/// 只有空格
- (BOOL)isWhitespace;


/// 8-16位密码校验
- (BOOL)isValidPassword;

/// 先去除字符中间多个空格为 1 个空格，然后去除前后空格
- (NSString *)stringByReplacmentWhitespaceAndTrimmingCharacters;

/// 解析url中的参数
/// @param url url
+ (NSDictionary *)analyzeParametersInUrl:(NSString *)url;

/// 解析url中的域名
/// @param url url
+ (NSString *)analyzeHostInUrl:(NSString *)url;

// URL解码
- (NSString *)urlDecode;

/// 如果有中文，就会进行url编码，否则不进行编码
- (NSString *)urlEncode;

// 以K为阅读数
+ (NSString *)countByK:(NSInteger)count;

// 修正浮点型精度丢失
+ (NSString *)reviseString:(NSString *)str;

/// 把字典的参数拼接到url后面
+ (NSString *)appendParams:(NSDictionary *)paramDict toUrl:(NSString *)url;

///去掉小数点后面无效的0
+ (NSString *)removeSuffix:(NSString *)numberStr;

/// url解析获取其中的参数
- (NSDictionary *)ts_urlParsing;

//银行卡部分秘文展示
+ (NSString *)returnBankCard:(NSString *)BankCardStr;
@end


NS_ASSUME_NONNULL_END
