//
//  WKWebView+TSClearWebCache.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (TSClearWebCache)

+ (void)clearAllWebCache;
- (void)clearBrowseHistory;

@end

NS_ASSUME_NONNULL_END
