//
//  TSBindUserByAuthCodeRequest.m
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "TSBindUserByAuthCodeRequest.h"
@interface TSBindUserByAuthCodeRequest()
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *platformId;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *smsCode;
@end
@implementation TSBindUserByAuthCodeRequest
-(instancetype)initWithType:(NSString *)type platformId:(NSString *)platformId phone:(NSString *)phone token:(NSString *)token smsCode:(NSString *)smsCode{
    if (self = [super init]) {
        self.type = type;
        self.platformId = platformId;
        
        self.phone = phone;
        self.token = token;
        
        self.smsCode = smsCode;
    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    NSString *requestUrl;
    if (self.phone == nil) {
        requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&platformId=%@&type=%@&token=%@",kBindUserByAuthCode,kAppId,@"tcl",kAppSecret, self.platformId, self.type, self.token];
    }
    else{
        requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&platformId=%@&type=%@&phone=%@&token=%@&smsCode=%@",kBindUserByAuthCode,kAppId,@"tcl",kAppSecret, self.platformId, self.type, self.phone, self.token, self.smsCode];
    }
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
@end
