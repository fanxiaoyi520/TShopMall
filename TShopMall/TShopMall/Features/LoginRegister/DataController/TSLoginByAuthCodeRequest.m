//
//  TSLoginByAuthCodeRequest.m
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "TSLoginByAuthCodeRequest.h"
@interface TSLoginByAuthCodeRequest()
@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *platformId;
@end
@implementation TSLoginByAuthCodeRequest
-(instancetype)initWithCode:(NSString *)code platformId:(NSString *)platformId{
    if (self = [super init]) {
        self.code = code;
        self.platformId = platformId;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&platformId=%@&code=%@",kLoginByAuthCode,kAppId,@"tcl",kAppSecret, self.platformId, self.code];
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

//-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
//    NSMutableDictionary *comHeader = [self commonHeader];
//    return comHeader;
//}
//
//-(id)requestArgument{
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    NSMutableDictionary *comBody = [self commonBady];
//    [comBody setValuesForKeysWithDictionary:params];
//    return comBody;
//}

@end
