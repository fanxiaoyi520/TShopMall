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
@property (nonatomic, assign, readonly) BOOL isLogin;
/// 当前登录的用户的信息
@property (nonatomic, strong, readonly) TSUserInfoManager *currentUserInfo;
/// 用户唯一标识（设备唯一标识）
@property (nonatomic, copy) NSString *clientID;
/// 公钥
@property (nonatomic, copy) NSString *publicKey;
/// app版本号
@property(nonatomic, copy) NSString *appVersion;
/** 是否是第一次进入APP  */
@property(nonatomic, assign) BOOL firstStartApp;
/** 协议信息  */
@property(nonatomic, strong) NSArray <TSAgreementModel*> *agreementModels;
/// 单利
+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
