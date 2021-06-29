//
//  TSSaveLocalConst.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSSaveLocalConst : NSObject

/// 保存登录用户信息
UIKIT_EXTERN NSString *const UserInfo_Save_Key;
///保存第一次启动APP同意协议的响应
UIKIT_EXTERN NSString *const KFirstEnterAppKey;
///保存第一次启动APP同意协议的响应
UIKIT_EXTERN NSString *const KFirstEnterAppValue;

@end

NS_ASSUME_NONNULL_END
