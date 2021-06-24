//  WechatShareManager.h
//  TSale
//
//  Created by L灰灰Y on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.



#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <UserNotifications/UserNotifications.h>
// 分享类型枚举
typedef NS_ENUM(NSInteger, WechatShareType) {
    WechatShareTypeFriends = 0,  // 好友
    WechatShareTypeTimeline = 1,  // 朋友圈
};

// 分享后返回码枚举
typedef NS_ENUM(int, WechatShareStatusCode){
    WechatShareSuccess     = 0, // 分享成功
    WechatShareCancleShare = 1,// 取消分享
    WechatShareFailed      = 2   // 分享失败
};

@interface WechatShareManager : NSObject

// WechatShareManager是微信分享管理类


+ (id)shareInstance;

+ (BOOL)handleOpenUrl:(NSURL *)url;


+ (void)hangleWechatShareWith:(SendMessageToWXReq *)req;
//* @attention 请保证在主线程中调用此函数
//* @param appid 微信开发者ID
//* @param universalLink 微信开发者Universal Link
//* @return 成功返回YES，失败返回NO。
//*/
+ (BOOL)registerApp:(NSString *)appid universalLink:(NSString *)universalLink;

/// 分享详细信息
/// @param title title
/// @param description 描述
/// @param URL 微信要跳转的URL
/// @param thumbImage 分享右边图片
-(void)shareWXWithTitle:(NSString *)title andDescription:(NSString *)description andShareURL:(NSString *)URL andThumbImage:(UIImage *)thumbImage andWXScene:(WechatShareType)WXScene;
//分享小程序
-(void)shareWXSmallCodeImage:(UIImage *)image andParams:(NSDictionary *)params;


@end
