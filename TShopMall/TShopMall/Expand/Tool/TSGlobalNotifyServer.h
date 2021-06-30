//
//  TSGlobalNotifyServer.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#import <Foundation/Foundation.h>
#import <JAFMultiDelegate/NSObject+JAFMultiProxyAddition.h>
NS_ASSUME_NONNULL_BEGIN
@protocol GWGlobalNotifyServerDelegate <NSObject>
@optional
//添加银行卡
-(void)addBankCard:(id _Nullable)info;
@end

@interface TSGlobalNotifyServer : NSObject
SingletonH(Server)

-(void)postAddBankCard:(id _Nullable)info;
@end

NS_ASSUME_NONNULL_END
