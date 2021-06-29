//
//  TSModifyUserInfoRequest.m
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "TSModifyUserInfoRequest.h"

@interface TSModifyUserInfoRequest ()

@property (nonatomic, copy) NSString *accountId;
/** 需要修改的字段名 */
@property (nonatomic, copy) NSString *modifyKey;
/** 修改后的值 */
@property (nonatomic, copy) NSString *modifyValue;

@end

@implementation TSModifyUserInfoRequest

- (instancetype)initWithAccountId:(NSString *)accountId modifyKey:(NSString *)key modifyValue:(NSString *)value {
    if (self = [super init]) {
        _accountId = accountId;
        _modifyKey = key;
        _modifyValue = value;
    }
    return self;
}


#pragma mark - Super Method
-(NSString *)baseUrl{
    return kAccountCenterApiPrefix;
}

- (NSString *)requestUrl {
    return kModifyUserUrl;
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

- (id)requestArgument{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.accountId forKey:@"accountId"];
    [params setValue:self.modifyValue forKey:self.modifyKey];
    [params setValue:@"0" forKey:@"id"];
    NSMutableDictionary *comBody = [self commonBady];
    [comBody setValuesForKeysWithDictionary:params];
    return comBody;
}

@end
