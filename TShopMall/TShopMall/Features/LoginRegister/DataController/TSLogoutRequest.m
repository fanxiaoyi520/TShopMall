//
//  TSLogoutRequest.m
//  TShopMall
//
//  Created by sway on 2021/6/22.
//

#import "TSLogoutRequest.h"

@implementation TSLogoutRequest
#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@",kLoginQuickLoginUrl,kAppId,@"tcl",kAppSecret];
    return requestUrl;
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

-(YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    NSMutableDictionary *comHeader = [self commonHeader];
    return comHeader;
}

-(id)requestArgument{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[TSUserInfoManager userInfo].userName forKey:@"userName"];
    [params setValue:[TSUserInfoManager userInfo].accessToken forKey:@"accessToken"];
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}
@end
