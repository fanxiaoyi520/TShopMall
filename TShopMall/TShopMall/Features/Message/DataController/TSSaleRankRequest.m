//
//  TSSaleRankRequest.m
//  TShopMall
//
//  Created by oneyian on 2021/7/2.
//

#import "TSSaleRankRequest.h"

@interface TSSaleRankRequest ()
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger rankNum;
@end

@implementation TSSaleRankRequest


- (instancetype)initWithTime:(NSInteger)time rankNum:(NSInteger)rankNum
{
    self = [super init];
    if (self) {
        self.time = time;
        self.rankNum = rankNum;
    }
    return self;
}

#pragma mark - Super Method
- (NSString *)baseUrl {
    return kMallApiPrefix;
}

- (NSString *)requestUrl {
    return kRankSaleRankUrl;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSMutableDictionary *comHeader = [self commonHeader];
    [comHeader setValue:[TSUserInfoManager userInfo].accessToken forKey:@"ihome-token"];
    return comHeader;
}

- (id)requestArgument {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@(self.time) forKey:@"time"];
    if (self.rankNum > 0) [params setValue:@(self.rankNum) forKey:@"rankNum"];
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
