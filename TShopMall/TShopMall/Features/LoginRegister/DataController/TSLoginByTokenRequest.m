//
//  TSLoginByTokenRequest.m
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "TSLoginByTokenRequest.h"
@interface TSLoginByTokenRequest()

@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *platformId;

@end
@implementation TSLoginByTokenRequest
-(instancetype)initWithToken:(NSString *)token platformId:(NSString *)platformId{
    if (self = [super init]) {
        self.token = token;
        self.platformId = platformId;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&platformId=%@&idToken=%@",kLoginByTokenUrl,kAppId,@"tcl",kAppSecret,self.platformId,self.token];
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
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
