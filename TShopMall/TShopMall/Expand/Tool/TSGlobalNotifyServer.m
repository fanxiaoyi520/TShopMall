//
//  TSGlobalNotifyServer.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#import "TSGlobalNotifyServer.h"

@implementation TSGlobalNotifyServer
SingletonM(Server)

-(void)postBusinessNewSatu:(BOOL)haveNew{
    [JAFProxy(GWGlobalNotifyServerDelegate) businessNewSatauChange:haveNew];
}

@end
