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
/** 业务沟通是否存在未读计数的状态变换  */
-(void)businessNewSatauChange:(BOOL)haveNew;
@end

@interface TSGlobalNotifyServer : NSObject
SingletonH(Server)

-(void)postBusinessNewSatu:(BOOL)haveNew;
@end

NS_ASSUME_NONNULL_END
