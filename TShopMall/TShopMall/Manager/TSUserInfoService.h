//
//  TSUserInfoService.h
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUserInfoService : NSObject

- (void)getUserInfoAccountId:(NSString *)accountId
                     success:(void(^_Nullable)(BOOL isSucess))success
                     failure:(void(^_Nullable)(NSString *errorMsg))failure;

/**
 * @params key 可以为nickname（昵称）、city（城市）、province（省份）、country（国家）、sex（性别 1: 男 2:女）、area（区）
 * @params value 为对应key的修改值
 * @params accountId 用户账号的唯一标识
 */
- (void)modifyUserInfoWithKey:(NSString *)key
                        value:(NSString *)value
                    accountId:(NSString *)accountId
                      success:(void(^_Nullable)(BOOL isSucess))success
                      failure:(void(^_Nullable)(NSString *errorMsg))failure;

@end

NS_ASSUME_NONNULL_END
