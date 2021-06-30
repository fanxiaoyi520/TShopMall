//
//  NSString+Plugin.m
//  TCLSmartHome
//
//  Created by admin on 2019/7/19.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "NSString+Plugin.h"


@implementation NSString (Plugin)
- (NSString *)toMD5 {
    NSString *inputStr = self;
    const char *newStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(newStr, (unsigned int)strlen(newStr), result);
    NSMutableString *outStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [outStr appendFormat:@"%02x", result[i]]; //注意：这边如果是x则输出32位小写加密字符串，如果是X则输出32位大写字符串
    }
    return outStr;
}


- (NSString *)toSHA1 {
    NSString *srcString = self;
    const char *cstr = [srcString UTF8String];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(cstr, (int)strlen(cstr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

- (NSString *)mqttReply {
    return [self stringByAppendingString:@"_reply"];
}

- (NSData *)base64Decode {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

/**
 *  检查字符是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

/**
 *  去除字符串尾部空格
 *
 *  @param string 字符串
 *
 *  @return 返回值
 */
+ (NSString *)cmString:(NSString *)string {
    NSString *str;
    NSString *storyStr = string.mutableCopy;
    int strLenght = (int)string.length;
    for (int i = strLenght; i > 0; i--) {
        str = [string substringWithRange:NSMakeRange(i - 1, 1)];
        if ([str isEqualToString:@" "]) {
            storyStr = [string substringToIndex:i - 1];

        } else {
            return storyStr;
        }
    }
    return storyStr;
}

/**
 *  去除字符串首尾空格
 *
 *  @param string 字符串
 *
 *  @return 返回值
 */
+ (NSString *)removeHEString:(NSString *)string {
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}

+ (BOOL)isNumber:(NSString *)strValue {
    if (strValue == nil || [strValue length] <= 0) {
        return NO;
    }

    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];

    if (![strValue isEqualToString:filtered]) {
        return NO;
    }
    return YES;
}

- (BOOL)isNumber {
    return [NSString isNumber:self];
}

- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isHaveChinese {
    for (int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)appendNumberToString {
    NSString *tempString = self;
    NSString *tempNumber = @"";
    for (NSInteger i = tempString.length - 1; i >= 0; i--) { // 遍历字符串
        NSString *temp = [tempString substringWithRange:NSMakeRange(i, 1)];
        if (temp.isNumber) {
            tempNumber = [temp stringByAppendingString:tempNumber];
        } else {
            tempString = [tempString stringByReplacingOccurrencesOfString:tempNumber withString:@""];
            break;
        }
    }
    NSInteger newIndex = tempNumber.integerValue + 1;
    tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)newIndex]];
    return tempString;
}

- (NSString *)stringWithOutDuplicateToArray:(NSArray<NSString *> *)strings {
    for (NSString *tempString in strings) {
        if ([self isEqualToString:tempString]) {
            return [[self appendNumberToString] stringWithOutDuplicateToArray:strings];
        }
    }
    return self;
}

- (NSString *)repeatDayName {
    if ([self isEqualToString:@"0"]) {
        return @"仅一次";
    } else if ([self isEqualToString:@"1111111"]) {
        return @"每天";
    } else if ([self isEqualToString:@"1111100"]) {
        return @"工作日";
    } else if ([self isEqualToString:@"0000011"]) {
        return @"周末";
    } else {
        NSMutableArray<NSNumber *> *tempNumbers = [NSMutableArray array];
        for (NSInteger i = 0; i < self.length; i++) {
            unichar character = [self characterAtIndex:i];
            if (character == '0') {
                [tempNumbers addObject:@0];
            } else if (character == '1') {
                [tempNumbers addObject:@1];
            } else {
                return @"";
            }
        }
        __block NSString *customRepeatDayString = @"";
        [tempNumbers enumerateObjectsUsingBlock:^(NSNumber *_Nonnull number, NSUInteger index, BOOL *_Nonnull stop) {
            if (number.integerValue == 1) {
                customRepeatDayString = [customRepeatDayString stringByAppendingString:[NSString weekDayWithIndex:index]];
            }
        }];

        return [customRepeatDayString substringToIndex:customRepeatDayString.length - 1];
    }
}

+ (NSString *)weekDayWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"周一、";
        case 1:
            return @"周二、";
        case 2:
            return @"周三、";
        case 3:
            return @"周四、";
        case 4:
            return @"周五、";
        case 5:
            return @"周六、";
        case 6:
            return @"周日、";
        default:
            return @"";
    }
}


/**
 获取描述性时间
 e.g.
 2017-05-11 上午 02:40
 下午 01:55
 昨天 下午 01:55

 @param sendTime 2017-05-10 14:40:19
 @return 时间描述
 */
+ (NSString *)compareDate:(NSString *)sendTime {
    if (sendTime.length < 19) {
        return nil;
    }
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *yesterday = [today dateByAddingTimeInterval:-secondsPerDay];
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *dateString = [sendTime substringToIndex:10];

    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [fomatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *sendDate = [fomatter dateFromString:sendTime];
    if (hasAMPM) {
        NSInteger hour = [[sendTime substringWithRange:NSMakeRange(11, 2)] integerValue];
        if (hour > 11) {
            if (hour != 12) {
                NSDate *newdate = [[NSDate date] initWithTimeInterval:12 * 60 * 60 sinceDate:sendDate];
                sendTime = [fomatter stringFromDate:newdate];
            }
            sendTime =
                [NSString stringWithFormat:@"%@ 下午 %@", [sendTime substringWithRange:NSMakeRange(0, 10)], [sendTime substringWithRange:NSMakeRange(11, 5)]];
        } else {
            sendTime =
                [NSString stringWithFormat:@"%@ 上午 %@", [sendTime substringWithRange:NSMakeRange(0, 10)], [sendTime substringWithRange:NSMakeRange(11, 5)]];
        }
    }
    NSString *displayTime;
    if ([dateString isEqualToString:yesterdayString]) {
        displayTime = [NSString stringWithFormat:@"昨天 %@", [sendTime substringWithRange:NSMakeRange(11, 8)]];
    } else if ([dateString isEqualToString:todayString]) {
        displayTime = [sendTime substringWithRange:NSMakeRange(11, 8)];
    } else {
        displayTime = [sendTime substringWithRange:NSMakeRange(0, 19)];
    }
    return displayTime;
}

- (BOOL)hasIllegalCharacter {
    //提示 标签不能输入特殊字符
    NSString *str = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];

    if (![emailTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

- (NSString *)percentEscapedString {
    static NSString *const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString *const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";

    NSMutableCharacterSet *allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];

    static NSUInteger const batchSize = 50;

    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;

    while (index < self.length) {
        NSUInteger length = MIN(self.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);

        range = [self rangeOfComposedCharacterSequencesForRange:range];

        NSString *substring = [self substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];

        index += range.length;
    }

    return escaped;
}

- (void)rnStringAnalizeWithCompletion:(void (^)(NSString *_Nonnull, NSString *_Nonnull, NSDictionary *_Nullable))completion {
    NSArray *stringArray = [self componentsSeparatedByString:@"@"];
    if (stringArray.count == 2) { // 没有参数的情况
        NSString *ipAddress = stringArray.firstObject;
        ipAddress = [ipAddress stringByAppendingPathComponent:@"index.bundle?platform=ios&dev=true"];
        if (![ipAddress containsString:@"http"]) {
            NSString *prefix = @"http://";
            ipAddress = [prefix stringByAppendingString:ipAddress];
        }
        NSString *packageName = stringArray.lastObject;
        !completion ?: completion(ipAddress, packageName, nil);
    } else if (stringArray.count == 3) { // 有参数的情况
        NSString *ipAddress = stringArray.firstObject;
        NSString *packageName = stringArray[1];

        NSString *jsonString = stringArray.lastObject;

        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

        NSError *jsonError = nil;

        NSDictionary *parameters = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];

        if (jsonError) {
            !completion ?: completion(ipAddress, packageName, nil);
        } else {
            !completion ?: completion(ipAddress, packageName, parameters);
        }

    } else {
        return;
    }
}

+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL,
                                          [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [resultData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        // return [GTMBase64 stringByEncodingData:resultData];
        // return [self hexStringFromData:resultData];
    }
    free(buffer);
    return nil;
}

+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    // NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encryptText options:NSDataBase64DecodingIgnoreUnknownCharacters];

    // NSData *data=[self dataForHexString:encryptText];

    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL,
                                          [data bytes], dataLength, buffer, bufferSize, &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

+ (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for (int i = 0; i < [data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff]; // 16进制数
        newHexStr = [newHexStr uppercaseString];

        if ([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@", newHexStr];
        }

        hexStr = [hexStr stringByAppendingString:newHexStr];
    }
    return hexStr;
}

+ (NSData *)dataForHexString:(NSString *)hexString {
    if (hexString == nil) {
        return nil;
    }
    const char *ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        } else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        } else if ('A' <= *ch && *ch <= 'F') {
            byte = *ch - 'A' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            } else if ('A' <= *ch && *ch <= 'F') {
                byte += *ch - 'A' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}

// 桌面端加密在线工具 http://tool.chacuo.net/cryptaes

- (NSString *)tcl_AES128Encrypt {
    return [[self class] AES128Encrypt:self key:[NSString applicationUUID]];
}

- (NSString *)tcl_AES128Decrypt {
    return [[self class] AES128Decrypt:self key:[NSString applicationUUID]];
}

+ (NSString *)applicationUUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

- (NSString *)base64Encrypt {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
}

- (NSString *)base64Decrypt {
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
}

/// 判断字符串是否包含Emoji表情
- (BOOL)containsEmoji {
    __block BOOL containsEmoji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences
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

+ (NSString *)ramUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    return result;
}


+ (NSString *)appdingString:(NSString *)string component:(NSString *)component {
    if ([string hasSuffix:@"/"]) {
        string = [string substringToIndex:string.length - 1];
    }
    if ([component hasPrefix:@"/"]) {
        component = [component substringFromIndex:1];
    }
    if ([string hasPrefix:@"http"] && [component hasPrefix:@"http"]) {
    }
    return [NSString stringWithFormat:@"%@/%@", string, component];
}

- (BOOL)isValidMobile {
    NSString *pattern = @"^1+\\d{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


/// JSON字符串转化为字典/数组
+ (id)jsonObjectWithJsonString:(NSString *)jsonStr {
    if (jsonStr == nil) {
        return nil;
    }
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\'" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\f" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\b" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\v" withString:@""];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return object;
}

- (BOOL)isWhitespace {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([self stringByTrimmingCharactersInSet:set].length == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidPassword {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)stringByReplacmentWhitespaceAndTrimmingCharacters {
    if (self == nil) return self;

    NSString *string = [self stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/// 解析url中的参数
+ (NSDictionary *)analyzeParametersInUrl:(NSString *)url {
    NSArray *separateds = [url componentsSeparatedByString:@"?"];
    if (separateds.count == 2) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        NSArray *parameters = [[separateds lastObject] componentsSeparatedByString:@"&"];
        for (NSString *parameterString in parameters) {
            NSArray *parameter = [parameterString componentsSeparatedByString:@"="];
            if (parameter.count == 2) {
                [dictionary setValue:[parameter lastObject] forKey:[parameter firstObject]];
            }
        }
        return [dictionary copy];
    } else {
        return nil;
    }
}

/// 解析url中的域名
+ (NSString *)analyzeHostInUrl:(NSString *)url {
    NSArray *separateds = [url componentsSeparatedByString:@"?"];
    if (separateds.count >= 2) {
        return [separateds firstObject];
    } else {
        return url;
    }
}

- (NSString *)urlDecode {
    return [self jk_urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)jk_urlDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR("")));
}

- (NSString *)urlEncode {
    if ([self isHaveChinese]) {
        return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        return self;
    }
}


+ (NSString *)countByK:(NSInteger)count {
    if (count < 1000) {
        return [NSString stringWithFormat:@"%ld", count];
    }

    if (count % 1000 == 0) {
        return [NSString stringWithFormat:@"%ldk", (count / 1000)];
    }

    return [NSString stringWithFormat:@"%.1fk", (double)(count / 1000.f)];
}

//直接传入精度丢失有问题的Double类型
+ (NSString *)reviseString:(NSString *)str {
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

/// 把字典的参数拼接到url后面
+ (NSString *)appendParams:(NSDictionary *)paramDict toUrl:(NSString *)url {
    for (int i = 0; i < paramDict.allKeys.count; i++) {
        // 先判断是否带问号
        if (![url containsString:@"?"]) {
            url = [url stringByAppendingString:@"?"];
        } else {
            NSString *last = [url substringFromIndex:url.length - 1];
            if (![last isEqualToString:@"&"]) {
                url = [url stringByAppendingString:@"&"];
            }
        }
        NSString *key = paramDict.allKeys[i];
        NSString *value = [paramDict valueForKey:key];
        NSString *itemStr = [NSString stringWithFormat:@"%@=%@", key, value];
        url = [url stringByAppendingString:itemStr];
    }
    return url;
}

///去掉小数点后面无效的0
+ (NSString *)removeSuffix:(NSString *)numberStr {
    if (numberStr.length > 1) {
        if ([numberStr componentsSeparatedByString:@"."].count == 2) {
            NSString *last = [numberStr componentsSeparatedByString:@"."].lastObject;
            if (last.length > 2) {
                numberStr = [numberStr substringToIndex:numberStr.length - (last.length - 2)];
            }
            numberStr = [NSString stringWithFormat:@"%@", @([numberStr floatValue])]; //去掉小数点后面无效的0
            return numberStr;
        }
        return numberStr;
    } else {
        return numberStr;
    }
}

- (NSDictionary *)ts_urlParsing {
    if (self == nil || self.length <= 0) {
        return @{};
    }
    NSString *text = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
    if (![text containsString:@"?"] && ![text containsString:@"//"]) {
        text = [@"?" stringByAppendingString:text];
    }
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:text];
    for (NSURLQueryItem *item in components.queryItems) {
        if (item.name && item.name.length > 0 && item.value) {
            [muDict setObject:item.value forKey:item.name];
        }
    }
    return muDict.copy;
}

//银行卡部分秘文展示
+ (NSString *)returnBankCard:(NSString *)BankCardStr {
    NSString *formerStr = [BankCardStr substringToIndex:4];
    NSString *str1 = [BankCardStr stringByReplacingOccurrencesOfString:formerStr withString:@""];
    NSString *endStr = [BankCardStr substringFromIndex:BankCardStr.length-4];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:endStr withString:@""];
    NSString *middleStr = [str2 stringByReplacingOccurrencesOfString:str2 withString:@"****"];
    NSString *CardNumberStr = [formerStr stringByAppendingFormat:@"%@%@",middleStr,endStr];
    return CardNumberStr;
}

@end
