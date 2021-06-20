//
//  TSWKWebViewPool.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWKWebViewReuseUrlString @"kwebkit://reuse-webView"
#define kWKWebViewReuseScheme    @"kwebkit"

NS_ASSUME_NONNULL_BEGIN

@class TSWKWebView;

@protocol TSWKWebViewReuseProtocol <NSObject>

- (void)webViewWillReuse;
- (void)webViewEndReuse;

@end

/**
 是否需要在App启动时提前准备好一个可复用的WebView,默认为YES.
 prepare=YES时,可显著优化WKWebView首次启动时间.
 prepare=NO时,不会提前初始化一个可复用的WebView.
 */
@interface TSWKWebViewPool : NSObject

@property (nonatomic, assign) BOOL prepare;

+ (instancetype)sharedInstance;

- (__kindof TSWKWebView *)getReusedWebViewForHolder:(id)holder;
- (void)recycleReusedWebView:(__kindof TSWKWebView *)webView;
- (void)cleanReusableViews;

@end

NS_ASSUME_NONNULL_END
