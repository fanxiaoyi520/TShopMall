//
//  TSUserInfoManager.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSUserInfoManager.h"

@interface TSUserInfoManager()<NSCoding>

@end

@implementation TSUserInfoManager

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        self.accessToken = [coder decodeObjectForKey:@"accessToken"];
        self.refreshToken = [coder decodeObjectForKey:@"refreshToken"];
        self.userName = [coder decodeObjectForKey:@"userName"];
        self.accountId = [coder decodeObjectForKey:@"accountId"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.accessToken forKey:@"accessToken"];
    [coder encodeObject:self.refreshToken forKey:@"refreshToken"];
    [coder encodeObject:self.userName forKey:@"userName"];
    [coder encodeObject:self.accountId forKey:@"accountId"];

}

+(TSUserInfoManager *)userInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:UserInfo_Save_Key];
    TSUserInfoManager *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!userInfo) {
        userInfo = [[TSUserInfoManager alloc] init];
    }
    return userInfo;
}

-(void)saveUserInfo:(TSUserInfoManager *)info{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:data forKey:UserInfo_Save_Key];
        [userDefaults synchronize];
    });
}

-(void)clearUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:UserInfo_Save_Key];
}

- (NSString *)accessToken{
    if ([_accessToken isKindOfClass:[NSNull class]] ||
        _accessToken.length == 0 ||
        [_accessToken containsString:@"null"]) {
        return @"";
    }
    return _accessToken;
}

@end
