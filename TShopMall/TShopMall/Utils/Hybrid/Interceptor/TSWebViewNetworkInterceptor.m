//
//  TSWebViewNetworkInterceptor.m
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSWebViewNetworkInterceptor.h"

@interface TSWebViewNetworkInterceptor ()
@property (nonatomic, strong) NSHashTable *delegates;
@end

@implementation TSWebViewNetworkInterceptor

+ (instancetype)sharedInstance {
    static TSWebViewNetworkInterceptor *interceptor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        interceptor = [[TSWebViewNetworkInterceptor alloc] init];
    });
    return interceptor;
}

- (BOOL)shouldIntercept {
    BOOL shouldIntercept = NO;
    for (id<TSWebViewNetworkInterceptorDelegate> delegate in self.delegates) {
        if (delegate.shouldIntercept) {
            shouldIntercept = YES;
            break;
        }
    }
    return shouldIntercept;
}


- (void)addDelegate:(id<TSWebViewNetworkInterceptorDelegate>) delegate {
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<TSWebViewNetworkInterceptorDelegate>)delegate {
    [self.delegates removeObject:delegate];
}

- (void)handleInterceptorDataWithWebView:(WKWebView *)webView
         decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
                         decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    for (id<TSWebViewNetworkInterceptorDelegate> delegate in self.delegates) {
        [delegate webViewNetworkInterceptorWithWebView:webView
                       decidePolicyForNavigationAction:navigationAction
                                       decisionHandler:decisionHandler];
    }
}

#pragma mark - getter
- (NSHashTable *)delegates {
    if (_delegates == nil) {
        self.delegates = [NSHashTable weakObjectsHashTable];
    }
    return _delegates;
}

@end
