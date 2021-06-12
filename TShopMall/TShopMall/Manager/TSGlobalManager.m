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

- (void)saveCurrentUserInfo:(NSDictionary *)dit{
    
}

- (void)setLoginType:(NSString*)loginTyppe{
    
}

- (void)clearUserInfo{
    
}
@end
