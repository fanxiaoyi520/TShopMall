//
//  TSHybridViewController.m
//  TSale
//
//  Created by 陈洁 on 2020/12/2.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSHybridViewController.h"
#import "TSWKMessageHandlerHelper.h"
#import "UIProgressView+TSWKWebView.h"
#import "TSHybridRightButton.h"
#import "FTPopOverMenu.h"

typedef enum : NSUInteger {
    TSWebViewLoadTypeNetRequest,    //网络请求
    TSWebViewLoadTypeHTMLString,    //HTML模板
    TSWebViewLoadTypeFile,          //文件路径
} TSWebViewLoadType;


@interface TSHybridViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIProgressView         *progressView;
@property (nonatomic, assign) BOOL                   checkUrlCanOpen;
@property (nonatomic, assign) BOOL                   terminate;
@property (nonatomic, assign) BOOL                   appeared;
@property (nonatomic, assign) TSWebViewLoadType     loadType;

@property (nonatomic, strong) TSHybridRightButton *rightButton;

@end

@implementation TSHybridViewController

#pragma mark - Init
- (instancetype)initWithURLString:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)URL {
    return [self initWithURLRequest:[NSMutableURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSMutableURLRequest *)request {
    if (self = [self init]) {
        _request = request;
        _loadType = TSWebViewLoadTypeNetRequest;
    }
    return self;
}

- (instancetype)initWithHTMLString:(NSString *)htmlString {
    if (self = [self init]) {
        _htmlString = htmlString;
        _loadType = TSWebViewLoadTypeHTMLString;
    }
    return self;
}

- (instancetype)initWithFileURL:(NSURL *)fileURL {
    if (self = [self init]) {
        _fileURL = fileURL;
        _loadType = TSWebViewLoadTypeFile;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _allowsBFNavigationGesture  = NO;
        _showProgressView           = YES;
        _terminate                  = NO;
        _webView = [[TSWKWebViewPool sharedInstance] getReusedWebViewForHolder:self];
        [_webView useExternalNavigationDelegate];
        [_webView setMainNavigationDelegate:self];
        _webView.allowsBackForwardNavigationGestures = _allowsBFNavigationGesture;
        _webView.UIDelegate = self;
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self sutupUI];
    
    [self fetchData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.isHiddenNavigationBar) {
        
        CGFloat webViewY = 0;
        CGRect webViewRect = CGRectMake(0, webViewY, SCREEN_WIDTH, CGRectGetHeight(self.view.frame) - webViewY);
        _webView.frame = webViewRect;
        
    }else{
        CGFloat webViewY = CGRectGetHeight(self.gk_navigationBar.frame);
        CGRect webViewRect = CGRectMake(0, webViewY, SCREEN_WIDTH, CGRectGetHeight(self.view.frame) - webViewY);
        _webView.frame = webViewRect;
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        [_progressView removeFromSuperview];
    }
    
    if ([self.delegate respondsToSelector:@selector(hybridViewControllerWillDidDisappear:params:)]) {
        NSDictionary *params = self.jsDataParams[@"params"];
        [self.delegate hybridViewControllerWillDidDisappear:self params:params[@"data"]];
    }
}

-(void)evaluateWebViewInitData{
    if ([self.jsDataParams isKindOfClass:[NSDictionary class]] && self.jsDataParams.count > 0) {
        NSDictionary *callbackDic = self.jsDataParams[@"callback"];
        NSDictionary *params = self.jsDataParams[@"params"];
        NSDictionary *paramData = params[@"data"];

        if ([callbackDic isKindOfClass:[NSDictionary class]] && callbackDic[@"success"]) {
            NSString *method = [NSString stringWithFormat:@"%@",callbackDic[@"success"]];
            NSString *json = @"";
            if ([paramData isKindOfClass:[NSDictionary class]] && paramData.count > 0) {
                json = [paramData jsonStringEncoded];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [TSWKMessageHandlerHelper callbackWithMethodName:method callBackParams:json webView:self.webView];
            });
        }
    }
}

-(void)cancelRightActive{
    
    if (!self.rightButton.isSelected) {
        return;
    }
    
    if (self.rightButton) {
        self.rightButton.selected = !self.rightButton.selected;
    }
}

#pragma mark - UI & Fetch Data
- (void)sutupUI {
    _appeared = YES;
    if (_showProgressView && !self.isHiddenNavigationBar) {
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    if (self.isHiddenNavigationBar) {
        self.gk_navigationBar.hidden = YES;
    }
    
    if (self.rightButtonTitle.length > 0) {
        TSHybridRightButton *rightButton = [TSHybridRightButton buttonWithType:UIButtonTypeCustom];
        self.rightButton = rightButton;
        rightButton.bounds = CGRectMake(0, 0, 60, 40);
        if (self.rightParams[@"normalColor"]) {
            [rightButton setTitleColor:KHexAlphaColor(self.rightParams[@"normalColor"], 0.6) forState:UIControlStateNormal];
            [rightButton setTitleColor:KHexAlphaColor(self.rightParams[@"selectedColor"], 0.6) forState:UIControlStateSelected];
            [rightButton setImage:KImageMake(self.rightParams[@"normalImage"]) forState:UIControlStateNormal];
            [rightButton setImage:KImageMake(self.rightParams[@"selectedImage"]) forState:UIControlStateSelected];
        }

        [rightButton setString:self.rightButtonTitle textColor:KTextColor font:KRegularFont(15.0) forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.gk_navItemRightSpace = 12;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
}

- (void)fetchData {
    if(!_request) return;
    
    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie ='%@=%@';",@"TXKSID",[TSCookiesManager defaultManager].H5Cookies];
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [self.webView.configuration.userContentController addUserScript:cookieScript];
    
    if (self.loadType == TSWebViewLoadTypeNetRequest) {
        if(self.request) [self loadRequest:self.request];
    } else if (self.loadType == TSWebViewLoadTypeHTMLString) {
        if (self.htmlString) [self.webView loadHTMLString:self.htmlString baseURL:nil];
    } else if (self.loadType == TSWebViewLoadTypeFile) {
        if (self.fileURL) {
            if (@available(iOS 9.0, *)) {
                [self.webView loadFileURL:self.fileURL allowingReadAccessToURL:[NSURL URLWithString:@""]];
            }
        }
    }
}

#pragma mark - Actions
- (void)rightButtonOnClick:(UIButton *)item event:(UIEvent *)event{
    
    NSDictionary *callback = self.menuParams[@"callback"];
    NSDictionary *params = self.menuParams[@"params"];
    NSArray *titles = params[@"title"];
    
    FTPopOverMenuConfiguration *config = [FTPopOverMenuConfiguration defaultConfiguration];
    config.tintColor = [UIColor whiteColor];
    config.borderColor = [UIColor whiteColor];
    config.textColor = KTextColor;
    config.textFont = KRegularFont(14);
    config.borderColor = [UIColor clearColor];
    config.menuRowHeight = 40;
    config.menuWidth = 90;
    [FTPopOverMenu showFromEvent:event
                   withMenuArray:titles
                       doneBlock:^(NSInteger selectedIndex) {
            switch (selectedIndex) {
                case 0: {
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    [params setValue:@"0" forKey:@"index"];
                    [TSWKMessageHandlerHelper callbackWithMethodName:callback[@"success"] callBackParams:[params jsonStringEncoded] webView:self.webView];
                }
                    break;
                case 1: {
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    [params setValue:@"1" forKey:@"index"];
                    [TSWKMessageHandlerHelper callbackWithMethodName:callback[@"success"] callBackParams:[params jsonStringEncoded] webView:self.webView];
        }
            break;
    }
    } dismissBlock:nil];
}

- (void)rightAction:(TSHybridRightButton *)sender{
    sender.selected = !sender.selected;
    if (self.rightClick.length > 0) {
        [TSWKMessageHandlerHelper callbackWithMethodName:self.rightClick callBackParams:@"" webView:self.webView];
    }
}

#pragma mark - 重写返回方法
-(void)backItemClick:(id)sender{
    if (self.leftClick.length > 0) {
        [TSWKMessageHandlerHelper callbackWithMethodName:self.leftClick callBackParams:@"" webView:self.webView];
        return;
    }
    [super backItemClick:sender];
}

#pragma mark- KVO
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (self.showProgressView) {
            [_webView addSubview:self.progressView];
            [self _updateFrameOfProgressView];
        }
        float progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        if (progress >= _progressView.progress) {
            [_progressView setProgress:progress animated:YES];
        } else {
            [_progressView setProgress:progress animated:NO];
        }
    }else if ([keyPath isEqualToString:@"title"]) {
        [self updateNavigationTitle];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - LoadRequest
- (void)loadRequest:(NSURLRequest *)request {
    [_webView clearBrowseHistory];
    [_webView loadRequest:request];
}

#pragma mark - NavigationBar
- (void)_updateFrameOfProgressView {
    CGFloat progressBarHeight = 2.0f;
    CGRect barFrame = CGRectMake(0, 0, SCREEN_WIDTH, progressBarHeight);
    _progressView.frame = barFrame;
}

//更新页面title
- (void)updateNavigationTitle {
    NSString *title = self.title;
    title = title.length > 0 ? title : [self.webView title];
    self.gk_navTitle = title;
    if ([title isEqual:@"我的券包"]) { //浏览优惠券埋点
        NSDictionary *dic = @{@"page_title":title,
                              @"page_type":@"列表页",
                              @"coupon_name":@"",
                              @"coupon_type":@"单品券",
                              @"coupon_search_area":@"我的提货券",
                              @"coupon_type":@"发券",
                              @"pre_source ":@"我的券包"};
        [[TSSensorsAnalyticsManager shareSensorsManager]appCouponPageViewEvent:dic];
    }
}

- (void)handleNavigation {
    if (self.navigationController.presentingViewController && self.navigationController.childViewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - WKNavigationDelegate
//发送请求之前决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)interceptRequestWithNavigationAction:(WKNavigationAction *)navigationAction
                             decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyCancel);
}

//在收到响应后，决定是否跳转(表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行。)
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self didStartLoad];
    
}

//接收到服务器跳转请求之后调用(接收服务器重定向时)
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    //...
}

//加载失败时调用(加载内容时发生错误时)
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (error.code == NSURLErrorCancelled) {
        // [webView reloadFromOrigin];
        return;
    }
    [self didFailLoadWithError:error];
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    //...
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self didFinishLoad];
}

//导航期间发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self didFailLoadWithError:error];
}

//iOS9.0以上异常终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    _terminate = YES;
    [webView reload];
}

#pragma mark - WKNavigationDelegate - 为子类提供的WKWebViewDelegate方法,使用时一定要调用super方法!
- (void)willGoBack{
    if (_delegate && [_delegate respondsToSelector:@selector(webViewControllerWillGoBack:)]) {
        [_delegate webViewControllerWillGoBack:self];
    }
}

- (void)willGoForward{
    if (_delegate && [_delegate respondsToSelector:@selector(webViewControllerWillGoForward:)]) {
        [_delegate webViewControllerWillGoForward:self];
    }
}

- (void)willReload{
    if (_delegate && [_delegate respondsToSelector:@selector(webViewControllerWillReload:)]) {
        [_delegate webViewControllerWillReload:self];
    }
}

- (void)willStop{
    if (_delegate && [_delegate respondsToSelector:@selector(webViewControllerWillStop:)]) {
        [_delegate webViewControllerWillStop:self];
    }
}

- (void)didStartLoad{
    if (_delegate && [_delegate respondsToSelector:@selector(webViewControllerDidStartLoad:)]) {
        [_delegate webViewControllerDidStartLoad:self];
    }
}

- (void)didFinishLoad{
    [self updateNavigationTitle];
    if (_delegate && [_delegate respondsToSelector:@selector(webViewControllerDidFinishLoad:)]) {
        [_delegate webViewControllerDidFinishLoad:self];
    }
}

- (void)didFailLoadWithError:(NSError *)error{
    [self updateNavigationTitle];
    if (_delegate && [_delegate respondsToSelector:@selector(webViewController:didFailLoadWithError:)]) {
        [_delegate webViewController:self didFailLoadWithError:error];
    }
    [_progressView setProgress:0.9 animated:YES];
}

#pragma mark - goBack & goForward
- (BOOL)isLoading{
    return _webView.isLoading;
}

- (BOOL)canGoBack{
    return _webView.canGoBack;
}

- (BOOL)canGoForward{
    return _webView.canGoForward;
}

- (void)goBack {
    [self willGoBack];
    [_webView goBack];
}

- (void)reload {
    [self willReload];
    [_webView reload];
}

- (void)forward {
    [self willGoForward];
    [_webView goForward];
}

- (void)stopLoading {
    [self willStop];
    [_webView stopLoading];
}

#pragma mark - setter
- (void)setAllowsBFNavigationGesture:(BOOL)allowsBFNavigationGesture {
    _allowsBFNavigationGesture = allowsBFNavigationGesture;
    _webView.allowsBackForwardNavigationGestures = allowsBFNavigationGesture;
}

#pragma mark - getter
- (UIProgressView *)progressView {
    if (_progressView){
        return _progressView;
    }
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.progressTintColor = _progressTintColor ? _progressTintColor : [UIColor orangeColor];
    _progressView.hiddenWhenWebDidLoad = YES;
    __weak typeof(self) weakSelf = self;
    _progressView.webViewController = weakSelf;
    return _progressView;
}

#pragma mark - Ohter Method
- (void)dealloc {
    if (_appeared) {
        if (_showProgressView) [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [_webView removeObserver:self forKeyPath:@"title"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (!_terminate) {
        [[TSWKWebViewPool sharedInstance] recycleReusedWebView:_webView];
    }
}

+ (void)clearAllWebCache {
    [TSWKWebView clearAllWebCache];
}

- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent {
    [_webView syncCustomUserAgentWithType:type customUserAgent:customUserAgent];
}

- (void)loadHTMLTemplate:(NSString *)htmlTemplate {
    [_webView loadHTMLTemplate:htmlTemplate];
}



@end
