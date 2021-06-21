//
//  TSGlobalManager.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TSUserInfoManager.h"
#import "TSLastUserInfoManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface TSGlobalManager : NSObject

/// 用户是否已经登录
@property (nonatomic, assign) BOOL isLogin;
/// 当前登录的用户的信息
@property (nonatomic, strong) TSUserInfoManager *currentUserInfo;
/// 用户唯一标识（设备唯一标识）
@property (nonatomic, copy) NSString *clientID;
/// app版本号
@property(nonatomic, copy) NSString *appVersion;

/// 单利
+ (instancetype)shareInstance;

/// 保存用户登录数据
/// @param dit 用户信息
- (void)saveCurrentUserInfo;

/// 清空用户信息
- (void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
