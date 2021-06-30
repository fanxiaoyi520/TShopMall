//
//  TSWKCallNativeMethodMessageHandler.m
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSWKCallNativeMethodMessageHandler.h"
#import "TSWKMessageHandlerDispatch.h"

@implementation TSWKCallNativeMethodMessageHandler

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //获取到js脚本传过来的参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:message.body];
    
    //other mark
    params[@"isFromH5"] = @(YES);
    //注意：这里的webview还是当前页 （有push情况下，不是push出来的webview）
    params[@"webview"] = message.webView;
    
    //target-action
    NSString *targetName = params[@"targetName"];
    NSString *actionName = params[@"actionName"];
    if ([actionName isKindOfClass:[NSString class]] && actionName.length > 0) {
        [[TSWKMessageHandlerDispatch sharedInstance] performTarget:targetName action:actionName params:params shouldCacheTarget:YES];
    }
}

@end
