//
//  TSWKMessageHandlerHelper.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSWKMessageHandlerHelper : NSObject

+ (void)callbackWithResult:(NSString *)result resultData:(NSDictionary *)resultData identifier:(NSString *)identifier message:(WKScriptMessage *)message;

+ (void)callbackWithMethodName:(NSString *)methodName callBackParams:(NSString *)params webView:(WKWebView *)webview;

@end

NS_ASSUME_NONNULL_END
