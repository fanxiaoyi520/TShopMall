//
//  TSWKWebView.m
//  TSale
//
//  Created by 陈洁 on 2020/12/2.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSWKWebView.h"
#import "TSWKCallNativeMethodMessageHandler.h"

@interface TSWKWebView()

@end

@implementation TSWKWebView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
                configuration:(WKWebViewConfiguration *)configuration {
    if (self = [super initWithFrame:frame configuration:configuration]) {
        _recycleDate = NSDate.new;
        [self config];
    }
    return self;
}

- (void)dealloc{
    //清除handler
    [self.configuration.userContentController removeScriptMessageHandlerForName:@"WKNativeMethodMessage"];
    //清除UserScript
    [self.configuration.userContentController removeAllUserScripts];
    //停止加载
    [self stopLoading];
    //清空Dispatcher
    [self unUseExternalNavigationDelegate];
    //清空相关delegate
    [super setUIDelegate:nil];
    [super setNavigationDelegate:nil];
    //持有者置为nil
    _holderObject = nil;
}

#pragma mark - Configuration
- (void)config {
    self.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

#pragma mark - MSWKWebViewReuseProtocol
//即将被复用时
- (void)webViewWillReuse{
    _recycleDate = nil;
    [self useExternalNavigationDelegate];
}

//被回收
- (void)webViewEndReuse{
    _recycleDate = NSDate.new;
    _holderObject = nil;
    self.scrollView.delegate = nil;
    [self stopLoading];
    [self unUseExternalNavigationDelegate];
    [super setUIDelegate:nil];
    [super clearBrowseHistory];
    [self loadHTMLTemplate:[self _getWebViewReuseLoadString]];
    [self evaluateJavaScript:@"JSCallBackMethodManager.removeAllCallBacks();" completionHandler:nil];
}

- (NSString *)_getWebViewReuseLoadString{
    return @"<html><head><meta name=\"viewport\" " @"content=\"initial-scale=1.0,width=device-width,user-scalable=no\"/><title>T销客</title></head><body></body></html>";
}

#pragma mark - public method
- (void)loadRequestURLString:(NSString *)urlString {
    [self loadRequestURL:[NSURL URLWithString:urlString]];
}

- (void)loadRequestURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self loadRequest:request.copy];
}

- (void)loadRequest:(NSURLRequest *)requset {
    [super loadRequest:requset];
}

- (void)loadHTMLTemplate:(NSString *)htmlTemplate {
    [super loadHTMLString:htmlTemplate baseURL:nil];
}

#pragma mark - Cache
+ (void)clearAllWebCache {
    [super clearAllWebCache];
}

#pragma mark - UserAgent
- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent {
    [super syncCustomUserAgentWithType:type customUserAgent:customUserAgent];
}

+ (instancetype)webView {
    TSWKWebView *webView = [[TSWKWebView alloc] initWithFrame:CGRectZero
                                                  configuration:[self defaultConfiguration]];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    return webView;
}

+ (WKWebViewConfiguration *)defaultConfiguration {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"TXKJSBridge.js" ofType:nil];
    NSString *bridgeJSString = [[NSString alloc] initWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:bridgeJSString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [configuration.userContentController addUserScript:userScript];
    [configuration.userContentController addScriptMessageHandler:[[TSWKCallNativeMethodMessageHandler alloc] init]
                                                            name:@"WKNativeMethodMessage"];
    return configuration;
}

@end
