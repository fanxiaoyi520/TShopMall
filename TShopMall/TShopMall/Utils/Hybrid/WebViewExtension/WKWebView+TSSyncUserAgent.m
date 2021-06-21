//
//  WKWebView+TSSyncUserAgent.m
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "WKWebView+TSSyncUserAgent.h"

@implementation WKWebView (TSSyncUserAgent)

- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type
                    customUserAgent:(NSString *)customUserAgent {
    
    if (!customUserAgent || customUserAgent.length <= 0) {
        return;
    }
    
    if(type == CustomUserAgentTypeReplace){
        if (@available(iOS 9.0, *)) {
            self.customUserAgent = customUserAgent;
        }
    }else if (type == CustomUserAgentTypeAppend){
        [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id userAgent, NSError * _Nullable error) {
            if ([userAgent isKindOfClass:[NSString class]]) {
                NSString *newUserAgent = [NSString stringWithFormat:@"%@-%@", userAgent, customUserAgent];
                if (@available(iOS 9.0, *)) {
                    self.customUserAgent = newUserAgent;
                }
            }
        }];
    }else{
        TSLog(@"WKWebView (SyncConfigUA) config with invalid type :%@", @(type));
    
    }
}

@end
