//
//  TSWKWebView.h
//  TSale
//
//  Created by 陈洁 on 2020/12/2.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WKWebViewExtension.h"
#import "TSWKWebViewPool.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSWKWebView : WKWebView<TSWKWebViewReuseProtocol>

/// 被谁持有
@property (nonatomic, weak, readwrite) id holderObject;
/// 复用时间
@property (nonatomic, strong, readonly) NSDate *recycleDate;

+ (instancetype)webView;
+ (WKWebViewConfiguration *)defaultConfiguration;

#pragma mark - load request
- (void)loadRequestURLString:(NSString *)urlString;
- (void)loadRequestURL:(NSURL *)url;
- (void)loadRequest:(NSURLRequest *)requset;
- (void)loadHTMLTemplate:(NSString *)htmlTemplate;

#pragma mark - Cache
+ (void)clearAllWebCache;

#pragma mark - UserAgent
- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent;

@end

NS_ASSUME_NONNULL_END
