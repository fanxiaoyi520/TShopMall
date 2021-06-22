//
//  TSGlobalManager.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSGlobalManager.h"

@implementation TSGlobalManager

+ (instancetype)shareInstance{
    static TSGlobalManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TSGlobalManager alloc] init];
    });
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        self.currentUserInfo = [TSUserInfoManager userInfo];
    }
    return self;
}

- (void)saveCurrentUserInfo{
    [self.currentUserInfo saveUserInfo:self.currentUserInfo];
}

- (void)clearUserInfo{
    self.isLogin = NO;
    [self.currentUserInfo clearUserInfo];
    self.currentUserInfo = nil;
    
}
@end
