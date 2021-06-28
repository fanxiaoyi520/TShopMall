//
//  TSGlobalManager.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSGlobalManager.h"
@interface TSGlobalManager ()
//@property (nonatomic, strong) TSUserInfoManager *currentUserInfo;

@end
@implementation TSGlobalManager

+ (instancetype)shareInstance{
    static TSGlobalManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TSGlobalManager alloc] init];
    });
    return instance;
}

- (TSUserInfoManager *)currentUserInfo{
    return [TSUserInfoManager userInfo];
}

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (NSString *)appVersion{
    return [UIApplication sharedApplication].appVersion;
}

- (BOOL)firstStartApp {
    NSString *value = [[NSUserDefaults standardUserDefaults] valueForKey:KFirstEnterAppKey];
    return value == nil;
}

- (void)setFirstStartApp:(BOOL)firstStartApp {
    _firstStartApp = firstStartApp;
    [[NSUserDefaults standardUserDefaults] setValue:KFirstEnterAppValue forKey:KFirstEnterAppKey];
}

- (BOOL)isLogin{
    if ([TSUserInfoManager userInfo].accessToken && [TSUserInfoManager userInfo].userName && [TSUserInfoManager userInfo].refreshToken) {
        return YES;
    }else
        return NO;
}
@end
