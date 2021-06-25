//
//  TSHybridViewController.h
//  TSale
//
//  Created by 陈洁 on 2020/12/2.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSBaseViewController.h"
#import "WKWebViewExtension.h"
#import "TSWKWebView.h"
#import "TSH5InterfacedConst.h"

NS_ASSUME_NONNULL_BEGIN

@class TSHybridViewController;

#pragma mark - MSWebViewControllerDelegate
@protocol TSHybridViewControllerDelegate <NSObject>

@optional
- (void)webViewControllerWillGoBack:(TSHybridViewController *)webViewController;
- (void)webViewControllerWillGoForward:(TSHybridViewController *)webViewController;
- (void)webViewControllerWillReload:(TSHybridViewController *)webViewController;
- (void)webViewControllerWillStop:(TSHybridViewController *)webViewController;
- (void)webViewControllerDidStartLoad:(TSHybridViewController *)webViewController;
- (void)webViewControllerDidFinishLoad:(TSHybridViewController *)webViewController;
- (void)webViewController:(TSHybridViewController *)webViewController didFailLoadWithError:(NSError *)error;

-(void)hybridViewControllerWillDidDisappear:(TSHybridViewController *)hybridViewController params:(NSDictionary *)param;

@end

@interface TSHybridViewController : TSBaseViewController

@property (nonatomic, assign) BOOL                             isHiddenNavigationBar;
@property (nonatomic, strong) TSWKWebView                      *webView;
@property (nonatomic, weak)   id<TSHybridViewControllerDelegate>  delegate;
@property (nonatomic, strong) NSArray<NSHTTPCookie *>           *cookies;
@property (nonatomic, strong) UIColor                           *progressTintColor;
@property (nonatomic, copy) NSURLRequest                        *request;
@property (nonatomic, copy) NSString                            *htmlString;
@property (nonatomic, copy) NSURL                               *fileURL;
@property (nonatomic, assign) BOOL                              showProgressView;
@property (nonatomic, assign) BOOL                              allowsBFNavigationGesture;
@property (nonatomic, assign) BOOL                              isRootController;
@property (nonatomic, readonly, getter=isLoading)    BOOL       loading;



/// 开启新页面的时候，h5传过来的参数
@property (nonatomic, strong) NSDictionary *jsDataParams;

/// 右侧控制字典
@property (nonatomic, strong) NSDictionary *rightParams;
/// 右侧按钮标题
@property (nonatomic, copy) NSString *rightButtonTitle;
/// 右侧按钮点击事件（调h5）
@property (nonatomic, copy) NSString *rightClick;
/// 左侧按钮点击事件（调h5）
@property (nonatomic, copy) NSString *leftClick;
/// 菜单数据
@property (nonatomic, strong) NSDictionary *menuParams;

/// 是否是发票页面
@property(nonatomic, assign) BOOL isInvoice;

/// 调用js方法
-(void)evaluateWebViewInitData;

//初始化方法栈
- (instancetype)initWithURLString:(NSString *)urlString;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithURLRequest:(NSMutableURLRequest *)request;
- (instancetype)initWithHTMLString:(NSString *)htmlString;
- (instancetype)initWithFileURL:(NSURL *)fileURL;

- (void)loadRequest:(NSURLRequest *)request;

//当needInterceptRequest=YES时,该方法用于拦截请求
- (void)interceptRequestWithNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler;

//设置UserAgent
- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type
                    customUserAgent:(NSString *)customUserAgent;

//清除所有缓存
+ (void)clearAllWebCache;

@end

//以下方法供子类调用
@interface TSHybridViewController (SubclassHooks)

//即将后退
- (void)willGoBack;

//即将前进
- (void)willGoForward;

//即将刷新
- (void)willReload;

//即将结束
- (void)willStop;

//开始加载
- (void)didStartLoad;

//已经加载完成
- (void)didFinishLoad;

//加载出错
- (void)didFailLoadWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
