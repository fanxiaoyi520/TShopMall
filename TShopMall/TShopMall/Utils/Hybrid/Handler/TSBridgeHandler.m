//
//  TSBridgeHandler.m
//  TSale
//
//  Created by 陈洁 on 2020/12/31.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSBridgeHandler.h"
#import "TSHybridViewController.h"
#import "TSWKAppManager.h"


@implementation TSBridgeHandler

-(void)goForward:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramDic = data[@"params"];

    TSHybridViewController *controller = [[TSHybridViewController alloc] initWithURLString:paramDic[@"url"]];
    controller.rightParams = paramDic;
    controller.jsDataParams = data;
    controller.gk_navTitle = paramDic[@"title"];
    controller.rightButtonTitle = paramDic[@"rightText"];
    controller.rightClick = paramDic[@"rightClick"];
    controller.leftClick = paramDic[@"leftClick"];
    [[TSWKAppManager currentNavigationController] pushViewController:controller animated:YES];
}




@end
