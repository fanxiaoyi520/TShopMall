//
//  WKWebView+TSCookiesManager.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (TSCookiesManager)

- (void)writeCookie:(NSArray<NSHTTPCookie *> *)cookies completion:(dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
