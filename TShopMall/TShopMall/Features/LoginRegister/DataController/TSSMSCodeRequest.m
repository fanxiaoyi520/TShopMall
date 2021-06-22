//
//  TSSMSCodeRequest.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "TSSMSCodeRequest.h"

@interface TSSMSCodeRequest()

@property(nonatomic, copy) NSString *mobile;
@property(nonatomic, copy) NSString *type;

@end

@implementation TSSMSCodeRequest

-(instancetype)initWithMobile:(NSString *)mobile type:(NSString *)type{
    if (self = [super init]) {
        self.mobile = mobile;
        self.type = type;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    return kLoginSmsCaptchaUrl;
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
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
    [params setValue:kAppId forKey:@"appId"];
    [params setValue:@"tcl" forKey:@"tenantId"];
    [params setValue:kAppSecret forKey:@"appSecret"];
    [params setValue:self.mobile forKey:@"mobile"];
    [params setValue:@"zh" forKey:@"language"];
    [params setValue:self.type forKey:@"bType"];
    
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
