//
//  TSGlobalNotifyServer.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#import "TSGlobalNotifyServer.h"

@implementation TSGlobalNotifyServer
SingletonM(Server)

-(void)postAddBankCard:(id)info {
    [JAFProxy(GWGlobalNotifyServerDelegate) addBankCard:info];
}

@end
