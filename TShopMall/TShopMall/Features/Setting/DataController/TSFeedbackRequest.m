//
//  TSFeedbackRequest.m
//  TShopMall
//
//  Created by oneyian on 2021/7/6.
//

#import "TSFeedbackRequest.h"

@interface TSFeedbackRequest ()
@property (nonatomic, copy) NSString * content;
@end

@implementation TSFeedbackRequest

- (instancetype)initWithContent:(NSString *)content
{
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}

#pragma mark - Super Method
- (NSString *)baseUrl {
    return kMallApiPrefix;
}

- (NSString *)requestUrl {
    return kFeedbackUrl;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSMutableDictionary *comHeader = [self commonHeader];
    [comHeader setValue:@"application/json" forKey:@"Content-Type"];
    [comHeader setValue:[TSUserInfoManager userInfo].accessToken forKey:@"ihome-token"];
    return comHeader;
}

- (id)requestArgument {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.content) {
        [params setValue:self.content forKey:@"content"];
    }
    [params setValue:@(1) forKey:@"sourceType"];
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
