//
//  TSUserLoginManager.h
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, TSLoginState) {
    TSLoginStateLogin,
    TSLoginStateNone
};

NS_ASSUME_NONNULL_BEGIN

@interface TSUserLoginManager : NSObject
+ (instancetype)shareInstance;
@property (nonatomic, assign, readonly) TSLoginState state;
-(void)startLogin;
-(void)logout;

@end

NS_ASSUME_NONNULL_END
