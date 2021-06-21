//
//  UIProgressView+TSWKWebView.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSHybridViewController;

@interface UIProgressView (TSWKWebView)

@property(nonatomic, assign) BOOL hiddenWhenWebDidLoad;

@property(nonatomic, strong) TSHybridViewController *webViewController;

@end

NS_ASSUME_NONNULL_END
