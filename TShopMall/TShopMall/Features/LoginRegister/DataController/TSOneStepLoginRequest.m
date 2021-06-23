//
//  TSOneStepLoginRequest.m
//  TShopMall
//
//  Created by  on 2021/6/23.
//

#import "TSOneStepLoginRequest.h"
@interface TSOneStepLoginRequest()

@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *accessToken;

@end
@implementation TSOneStepLoginRequest
-(instancetype)initWithToken:(NSString *)token accessToken:(NSString *)accessToken{
    if (self = [super init]) {
        self.token = token;
        self.accessToken = accessToken;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@",kOneStepLoginUrl,kAppId,@"tcl",kAppSecret];
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
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.accessToken forKey:@"accessToken"];
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
