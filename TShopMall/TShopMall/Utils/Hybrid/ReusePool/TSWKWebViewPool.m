//
//  TSWKWebViewPool.m
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSWKWebViewPool.h"
#import "TSWKWebView.h"

@interface TSWKWebViewPool()

@property(nonatomic, strong, readwrite) dispatch_semaphore_t lock;
@property(nonatomic, strong, readwrite) NSMutableArray<__kindof TSWKWebView *> *visiableWebViewSet;
@property(nonatomic, strong, readwrite) NSMutableArray<__kindof TSWKWebView *> *reusableWebViewSet;

@end

@implementation TSWKWebViewPool

+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self prepareWebView];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

+ (void)prepareWebView {
    [[TSWKWebViewPool sharedInstance] _prepareReuseWebView];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static TSWKWebViewPool *webViewPool = nil;
    dispatch_once(&once,^{
        webViewPool = [[TSWKWebViewPool alloc] init];
    });
    return webViewPool;
}

- (instancetype)init{
    if(self = [super init]){
        _prepare = YES;
        _visiableWebViewSet = [NSMutableArray array];
        _reusableWebViewSet = [NSMutableArray array];
        _lock = dispatch_semaphore_create(1);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_clearReusableWebViews) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark - Public Method
- (__kindof TSWKWebView *)getReusedWebViewForHolder:(id)holder{
    if (!holder) {
        return nil;
    }
    
    [self _tryCompactWeakHolders];
    
    TSWKWebView *webView;
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    if (_reusableWebViewSet.count > 0) {
        webView = [_reusableWebViewSet firstObject];
        NSTimeInterval diff = [NSDate.new timeIntervalSinceDate:webView.recycleDate];
        if (diff > 2.f) {
            [_reusableWebViewSet removeObject:webView];
            [_visiableWebViewSet addObject:webView];
            [webView webViewWillReuse];
        } else {
            webView = [TSWKWebView webView];
            [_visiableWebViewSet addObject:webView];
        }
    } else {
        webView = [TSWKWebView webView];
        [_visiableWebViewSet addObject:webView];
    }
    webView.holderObject = holder;
    
    dispatch_semaphore_signal(_lock);
    
    return webView;
}

- (void)recycleReusedWebView:(__kindof TSWKWebView *)webView{
    if (!webView) return;
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    if ([_visiableWebViewSet containsObject:webView]) {
        //将webView重置为初始状态
        [webView webViewEndReuse];
        
        [_visiableWebViewSet removeObject:webView];
        [_reusableWebViewSet addObject:webView];
    } else {
        if (![_reusableWebViewSet containsObject:webView]) {
            #if DEBUG
            #endif
        }
    }
    
    dispatch_semaphore_signal(_lock);
}

- (void)cleanReusableViews{
    [self _clearReusableWebViews];
}

#pragma mark - Private Method
- (void)_tryCompactWeakHolders {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    NSMutableSet<TSWKWebView *> *shouldreusedWebViewSet = [NSMutableSet set];
    
    for (TSWKWebView *webView in _visiableWebViewSet) {
        if (!webView.holderObject) {
            [shouldreusedWebViewSet addObject:webView];
        }
    }
    
    for (TSWKWebView *webView in shouldreusedWebViewSet) {
        [webView webViewEndReuse];
        
        [_visiableWebViewSet removeObject:webView];
        [_reusableWebViewSet addObject:webView];
    }
    
    dispatch_semaphore_signal(_lock);
}

- (void)_clearReusableWebViews {
    [self _tryCompactWeakHolders];
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_reusableWebViewSet removeAllObjects];
    dispatch_semaphore_signal(_lock);
    
    [TSWKWebView clearAllWebCache];
}

- (void)_prepareReuseWebView {
    if (!_prepare) return;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        TSWKWebView *webView = [TSWKWebView webView];
        webView.backgroundColor = [UIColor clearColor];
        [weakSelf.reusableWebViewSet addObject:webView];
    });
}

#pragma mark - Other
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
