//
//  TSQuickLoginRequest.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "TSQuickLoginRequest.h"

@interface TSQuickLoginRequest()

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *validCode;

@end

@implementation TSQuickLoginRequest

-(instancetype)initWithUsername:(NSString *)username
                      validCode:(NSString *)validCode{
    if (self = [super init]) {
        self.username = username;
        self.validCode = validCode;
    }
    return self;
}

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
    [params setValue:self.username forKey:@"username"];
    [params setValue:self.validCode forKey:@"validCode"];
    [params setValue:@"LOGIN" forKey:@"bType"];
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}


@end
