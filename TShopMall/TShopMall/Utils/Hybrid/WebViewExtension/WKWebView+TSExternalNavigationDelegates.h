//
//  WKWebView+TSExternalNavigationDelegates.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (TSExternalNavigationDelegates)

@property(nonatomic, weak) id<WKNavigationDelegate> mainNavigationDelegate;

- (void)useExternalNavigationDelegate;
- (void)unUseExternalNavigationDelegate;
- (void)addExternalNavigationDelegate:(id<WKNavigationDelegate>)delegate;
- (void)removeExternalNavigationDelegate:(id<WKNavigationDelegate>)delegate;
- (BOOL)containsExternalNavigationDelegate:(id<WKNavigationDelegate>)delegate;
- (void)clearExternalNavigationDelegates;

@end

NS_ASSUME_NONNULL_END
