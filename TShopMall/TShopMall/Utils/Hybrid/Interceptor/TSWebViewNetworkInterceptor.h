//
//  TSWebViewNetworkInterceptor.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSWebViewNetworkInterceptorDelegate <NSObject>

- (BOOL)shouldIntercept;

- (void)webViewNetworkInterceptorWithWebView:(WKWebView *)webView
             decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
                             decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

@end

@interface TSWebViewNetworkInterceptor : NSObject

- (void)addDelegate:(id<TSWebViewNetworkInterceptorDelegate>)delegate;
- (void)removeDelegate:(id<TSWebViewNetworkInterceptorDelegate>)delegate;
- (void)handleInterceptorDataWithWebView:(WKWebView *)webView
         decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
                         decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

@end

NS_ASSUME_NONNULL_END
