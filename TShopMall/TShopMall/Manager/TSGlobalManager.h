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
@property (nonatomic, readonly) BOOL isLogin;
/// 当前登录的用户的信息
@property (nonatomic, readonly) TSUserInfoManager *currentUserInfo;
/// 上次登录的用户信息
@property (nonatomic, strong) TSLastUserInfoManager *lastUserInfo;
/// 用户设备信息
@property (nonatomic, copy, readonly) NSString *userAgent;
/// app版本号
@property(nonatomic, copy) NSString *appVersion;
/// 默认的官网搜索关键字
@property (nonatomic, copy) NSArray *defaultSearchWords;

/// 单利
+ (instancetype)shareInstance;

/// 保存用户登录数据
/// @param dit 用户信息
- (void)saveCurrentUserInfo:(NSDictionary *)dit;

/// 设置登录类型
/// @param loginTyppe currentUserInfo中用户的loginType
- (void)setLoginType:(NSString*)loginTyppe;

/// 清空用户信息
- (void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
