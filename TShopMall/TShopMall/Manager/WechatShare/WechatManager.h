//
//  WechatManager.h
//  push
//
//  Created by L灰灰Y on 2021/1/7.
//

//  WechatManager.h
#import <Foundation/Foundation.h>
#import <WXApi.h>

@interface WechatManager : NSObject
@property (nonatomic, copy) void(^WXSuccess)(void);
@property (nonatomic, copy) void(^WXFail)(void);

+ (id)shareInstance;

+ (BOOL)handleOpenUrl:(NSURL *)url;

+ (void)hangleWechatPayWith:(PayReq *)req;

- (void)selectWXpayWith:(NSDictionary *)dic;
//检查支付宝支付状态
- (void)AlipayResultStatus:(NSDictionary *)resultDic;

+ (void)hangleWechatAuthWith:(SendAuthReq *)req;
@end
