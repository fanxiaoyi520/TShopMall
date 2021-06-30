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
    controller.jsDataParams = data;
    [[TSWKAppManager currentNavigationController] pushViewController:controller animated:YES];
}

- (void)checkInvoice:(NSDictionary *)invoice{
    NSLog(@"%@", invoice);
    NSDictionary *params = invoice[@"data"][@"params"];
    if (params) {
        NSDictionary *data = params[@"data"];
        if (data) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"InvoiceChanged" object:nil userInfo:@{@"invoice":data}];
        }
    }
}

-(void)close:(NSDictionary *)params{
    [[TSWKAppManager currentNavigationController] popViewControllerAnimated:YES];
}



@end
