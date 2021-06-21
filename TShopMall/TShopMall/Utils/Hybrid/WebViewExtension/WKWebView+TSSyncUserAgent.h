//
//  WKWebView+TSSyncUserAgent.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef NS_ENUM (NSInteger, CustomUserAgentType){
    CustomUserAgentTypeReplace,     //替换所有UA
    CustomUserAgentTypeAppend,      //在原UA后面追加字符串
};

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (TSSyncUserAgent)

/// 设置UserAgent
/// @param type replace or append original UA
/// @param customUserAgent customUserAgent
- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type
                    customUserAgent:(NSString *)customUserAgent;

@end

NS_ASSUME_NONNULL_END
