//
//  TSChangeBindRequest.m
//  TShopMall
//
//  Created by  on 2021/6/30.
//

#import "TSChangeBindRequest.h"
@interface TSChangeBindRequest()

@property(nonatomic, copy) NSString *mobile;
@property(nonatomic, copy) NSString *validCode;

@end
@implementation TSChangeBindRequest
-(instancetype)initWithNewMobile:(NSString *)newMobile validCode:(NSString *)validCode{
    if (self = [super init]) {
        self.mobile = newMobile;
        self.validCode = validCode;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    return kChangeBindMobileUrl;
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
    [params setValue:[TSUserInfoManager userInfo].userName forKey:@"username"];
    [params setValue:self.mobile forKey:@"value"];
    [params setValue:self.validCode forKey:@"validCode"];
    [params setValue:@"CHANGE_BIND" forKey:@"bType"];

    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
