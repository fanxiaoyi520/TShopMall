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
@synthesize accessToken = _accessToken;

@synthesize refreshToken = _refreshToken;

@synthesize userName = _userName;

@synthesize accountId = _accountId;

-(id)copyWithZone:(NSZone *)zone {
    TSUserInfoManager *copy =[[[self class] allocWithZone:zone] init];
    
    copy.accessToken = [self.accessToken copyWithZone:zone];
    
    copy.accountId = [self.accountId copyWithZone:zone];
    
    copy.userName = [self.userName copyWithZone:zone];
    
    copy.refreshToken = [self.refreshToken copyWithZone:zone];
    
    return copy;
    
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        _accessToken = [coder decodeObjectForKey:@"accessToken"];
        _refreshToken = [coder decodeObjectForKey:@"refreshToken"];
        _userName = [coder decodeObjectForKey:@"userName"];
        _accountId = [coder decodeObjectForKey:@"accountId"];

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
