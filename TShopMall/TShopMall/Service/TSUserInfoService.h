//
//  TSUserInfoService.h
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import <Foundation/Foundation.h>
#import "TSUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSUserInfoService : NSObject
/** 校验验证码 */
- (void)checkCodeMobile:(NSString *)mobile
                   code:(NSString *)code
                success:(void(^_Nullable)(void))success
                failure:(void(^_Nullable)(NSString *errorMsg))failure;
/** 校验已有的提现密码 */
- (void)checkWithrawalPwd:(NSString *)withrawalPwd
                success:(void(^_Nullable)(void))success
                  failure:(void(^_Nullable)(NSString *errorMsg))failure;
/** 设置提现密码 */
- (void)setWithrawalPwd:(NSString *)withrawalPwd
                success:(void(^_Nullable)(void))success
                failure:(void(^_Nullable)(NSString *errorMsg))failure;

- (void)getUserInfoAccountId:(NSString *)accountId
                     success:(void(^_Nullable)(TSUser *user))success
                     failure:(void(^_Nullable)(NSString *errorMsg))failure;

/**
 * @params key 可以为nickname（昵称）、city（城市）、province（省份）、country（国家）、sex（性别 1: 男 2:女）、area（区）
 * @params value 为对应key的修改值
 */
- (void)modifyUserInfoWithKey:(NSString *)key
                        value:(NSString *)value
                      success:(void(^_Nullable)(void))success
                      failure:(void(^_Nullable)(NSString *errorMsg))failure;

@end

NS_ASSUME_NONNULL_END
