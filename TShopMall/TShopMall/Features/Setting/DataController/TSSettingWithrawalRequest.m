//
//  TSSettingWithrawalRequest.m
//  TShopMall
//
//  Created by edy on 2021/7/6.
//

#import "TSSettingWithrawalRequest.h"

@interface TSSettingWithrawalRequest ()

@property (nonatomic, copy) NSString *cipherPwd;

@end

@implementation TSSettingWithrawalRequest

- (instancetype)initWithCipherPwd:(NSString *)cipherPwd {
    if (self = [super init]) {
        self.cipherPwd = cipherPwd;
    }
    return self;
}


#pragma mark - Super Method
-(NSString *)baseUrl{
    return kMallApiPrefix;
}

- (NSString *)requestUrl {
    return kSetWithdrawalPwdUrl;
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

- (id)requestArgument {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.cipherPwd forKey:@"withdrawal"];
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}


@end
