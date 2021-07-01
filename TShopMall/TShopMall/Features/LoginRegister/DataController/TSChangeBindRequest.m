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
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&username=%@&value=%@&validCode=%@&bType=CHANGE_BIND",kChangeBindMobileUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].userName, self.mobile, self.validCode];
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
