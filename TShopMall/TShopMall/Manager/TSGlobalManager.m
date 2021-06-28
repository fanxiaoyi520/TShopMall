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

- (void)setCurrentUserInfo:(TSUserInfoManager *)currentUserInfo{
    _currentUserInfo = currentUserInfo;
}

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(NSString *)appVersion{
    return [UIApplication sharedApplication].appVersion;
}

- (BOOL)isLogin{
    return _currentUserInfo;
}
@end
