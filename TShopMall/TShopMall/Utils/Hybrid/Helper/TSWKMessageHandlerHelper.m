//
//  TSWKMessageHandlerHelper.m
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSWKMessageHandlerHelper.h"

@implementation TSWKMessageHandlerHelper

+ (void)callbackWithMethodName:(NSString *)methodName callBackParams:(NSString *)params webView:(WKWebView *)webview{
    NSString *callbackString = [NSString stringWithFormat:@"window.%@()",methodName];
    if (params.length > 0) {
        callbackString = [NSString stringWithFormat:@"window.%@('%@')",methodName,params];
    }
    
    if ([[NSThread currentThread] isMainThread]) {
        [webview evaluateJavaScript:callbackString completionHandler:^(id para, NSError * _Nullable error) {
            if (error) {
                [webview evaluateJavaScript:callbackString completionHandler:nil];
            }
        }];

    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [webview evaluateJavaScript:callbackString completionHandler:nil];
        });
    }
}

+ (void)callbackWithResult:(NSString *)result resultData:(NSDictionary *)resultData identifier:(NSString *)identifier message:(WKScriptMessage *)message {
    
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] initWithDictionary:resultData];
    resultDictionary[@"result"] = result;
    
    NSString *resultDataString = [self jsonStringWithData:resultDictionary];
    
    NSString *callbackString = [NSString stringWithFormat:@"window.Callback('%@', '%@', '%@')", identifier, result, resultDataString];
    
    if ([[NSThread currentThread] isMainThread]) {
        [message.webView evaluateJavaScript:callbackString completionHandler:nil];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [message.webView evaluateJavaScript:callbackString completionHandler:nil];
        });
    }
}

+ (NSString *)jsonStringWithData:(NSDictionary *)data {
    NSString *messageJSON = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:data options:0 error:NULL] encoding:NSUTF8StringEncoding];;
    
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    
    return messageJSON;
}

@end
