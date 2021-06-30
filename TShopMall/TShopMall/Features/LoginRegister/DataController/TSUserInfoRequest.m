//
//  TSUserInfoRequest.m
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "TSUserInfoRequest.h"

@interface TSUserInfoRequest ()

@end

@implementation TSUserInfoRequest

- (NSString *)baseUrl {
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@",kUserInfoUrl,kAppId,@"tcl",kAppSecret];
    return requestUrl;
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

-(YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    NSMutableDictionary *comHeader = [self commonHeader];
    return comHeader;
}

- (id)requestArgument {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[TSUserInfoManager userInfo].accountId forKey:@"accountId"];
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
