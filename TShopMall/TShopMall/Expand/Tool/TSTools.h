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

@end

NS_ASSUME_NONNULL_END
