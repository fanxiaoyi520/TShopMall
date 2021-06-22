//
//  TSRegisterRequest.m
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import "TSRegisterRequest.h"
@interface TSRegisterRequest()

@property(nonatomic, copy) NSString *mobile;
@property(nonatomic, copy) NSString *validCode;
@property(nonatomic, copy) NSString *invitationCode;

@end
@implementation TSRegisterRequest
-(instancetype)initWithMobile:(NSString *)mobile
                    validCode:(NSString *)validCode
               invitationCode:(NSString *)invitationCode{
    if (self = [super init]) {
        self.mobile = mobile;
        self.validCode = validCode;
        self.invitationCode = invitationCode;

    }
    return self;
}

#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

-(NSString *)requestUrl{
    return kRegisterUrl;
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
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@"thome" forKey:@"storeUuid"];
    [body setValue:@"tcl" forKey:@"t-id"];
    [body setValue:self.mobile forKey:@"mobile"];
    [body setValue:self.validCode forKey:@"code"];
    [body setValue:self.invitationCode forKey:@"invitationCode"];
   
    return body;
}
@end
