//
//  TSUser.m
//  TShopMall
//
//  Created by edy on 2021/6/30.
//

#import "TSUser.h"

@interface TSUser ()<NSCoding>

@end

@implementation TSUser

- (id)copyWithZone:(NSZone *)zone {
    TSUser *user = [[[self class] allocWithZone:zone] init];
    user.accountId = [self.accountId copyWithZone:zone];
    user.addressText = [self.addressText copyWithZone:zone];
    user.appId = [self.appId copyWithZone:zone];
    user.appName = [self.appName copyWithZone:zone];
    user.area = [self.area copyWithZone:zone];
    user.avatar = [self.avatar copyWithZone:zone];
    user.birthday = [self.birthday copyWithZone:zone];
    user.city = [self.city copyWithZone:zone];
    user.province = [self.province copyWithZone:zone];
    user.country = [self.country copyWithZone:zone];
    user.email = [self.email copyWithZone:zone];
    user.identity = [self.identity copyWithZone:zone];
    user.institutionUser = [self.institutionUser copyWithZone:zone];
    user.nickname = [self.nickname copyWithZone:zone];
    user.permissionValue = [self.permissionValue copyWithZone:zone];
    user.personalUser = [self.personalUser copyWithZone:zone];
    user.phone = [self.phone copyWithZone:zone];
    user.regRegion = [self.regRegion copyWithZone:zone];
    user.region = [self.region copyWithZone:zone];
    user.sex = [self.sex copyWithZone:zone];
    user.userType = [self.userType copyWithZone:zone];
    user.username = [self.username copyWithZone:zone];
    return user;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _accountId = [coder decodeObjectForKey:@"accountId"];
        _addressText = [coder decodeObjectForKey:@"addressText"];
        _appId = [coder decodeObjectForKey:@"appId"];
        _appName = [coder decodeObjectForKey:@"appName"];
        _area = [coder decodeObjectForKey:@"area"];
        _avatar = [coder decodeObjectForKey:@"avatar"];
        _birthday = [coder decodeObjectForKey:@"birthday"];
        _city = [coder decodeObjectForKey:@"city"];
        _province = [coder decodeObjectForKey:@"province"];
        _country = [coder decodeObjectForKey:@"country"];
        _email = [coder decodeObjectForKey:@"email"];
        _identity = [coder decodeObjectForKey:@"identity"];
        _institutionUser = [coder decodeObjectForKey:@"institutionUser"];
        _nickname = [coder decodeObjectForKey:@"nickname"];
        _permissionValue = [coder decodeObjectForKey:@"permissionValue"];
        _personalUser = [coder decodeObjectForKey:@"personalUser"];
        _phone = [coder decodeObjectForKey:@"phone"];
        _region = [coder decodeObjectForKey:@"region"];
        _regRegion = [coder decodeObjectForKey:@"regRegion"];
        _sex = [coder decodeObjectForKey:@"sex"];
        _userType = [coder decodeObjectForKey:@"userType"];
        _username = [coder decodeObjectForKey:@"username"];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
    [coder encodeObject:self.accountId forKey:@"accountId"];
    [coder encodeObject:self.addressText forKey:@"addressText"];
    [coder encodeObject:self.appId forKey:@"appId"];
    [coder encodeObject:self.appName forKey:@"appName"];
    [coder encodeObject:self.area forKey:@"area"];
    [coder encodeObject:self.avatar forKey:@"avatar"];
    [coder encodeObject:self.birthday forKey:@"birthday"];
    [coder encodeObject:self.city forKey:@"city"];
    [coder encodeObject:self.province forKey:@"province"];
    [coder encodeObject:self.country forKey:@"country"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.identity forKey:@"identity"];
    [coder encodeObject:self.institutionUser forKey:@"institutionUser"];
    [coder encodeObject:self.nickname forKey:@"nickname"];
    [coder encodeObject:self.permissionValue forKey:@"permissionValue"];
    [coder encodeObject:self.personalUser forKey:@"personalUser"];
    [coder encodeObject:self.phone forKey:@"phone"];
    [coder encodeObject:self.region forKey:@"region"];
    [coder encodeObject:self.regRegion forKey:@"regRegion"];
    [coder encodeInt:self.sex forKey:@"sex"];
    [coder encodeObject:self.userType forKey:@"userType"];
    [coder encodeObject:self.username forKey:@"username"];
}


@end
