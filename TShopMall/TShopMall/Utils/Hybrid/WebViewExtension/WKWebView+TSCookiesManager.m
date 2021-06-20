//
//  WKWebView+TSCookiesManager.m
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "WKWebView+TSCookiesManager.h"

@implementation WKWebView (TSCookiesManager)

- (void)writeCookie:(NSArray<NSHTTPCookie *> *)cookies completion:(dispatch_block_t)completion{
    if (cookies.count == 0) {
        completion();
        return;
    }
    if (@available(iOS 11.0, *)) {
        WKHTTPCookieStore *cookieStore = self.configuration.websiteDataStore.httpCookieStore;
        //添加新的cookie
        [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cookieStore setCookie:obj completionHandler:^{
                if (idx == cookies.count - 1) {
                    completion();
                }
            }];
        }];
    }else{
        [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:obj];
        }];
        [self reload];
        completion();
    }
    
}

@end
