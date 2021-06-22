//
//  TSUserInfoManager.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUserInfoManager : NSObject

/// 授权token
@property(nonatomic, copy) NSString *accessToken;
/// 刷新token 调刷新token接口的时候 , 需要穿这个值
@property(nonatomic, copy) NSString *refreshToken;
/// 用户名
@property(nonatomic, copy) NSString *userName;
/// accountId
@property(nonatomic, copy) NSString *accountId;
/// 初始化并加载本地的用户信息
+(TSUserInfoManager *)userInfo;

/// 保存用户信息到本地
-(void)saveUserInfo;

/// 清除用户信息到本地
-(void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
