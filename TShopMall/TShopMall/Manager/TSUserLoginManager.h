//
//  TSUserLoginManager.h
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, TSLoginState) {
    Login,
    None
};

NS_ASSUME_NONNULL_BEGIN

@interface TSUserLoginManager : NSObject
+ (instancetype)shareInstance;
@property (nonatomic, copy) void(^ _Nonnull loginStateDidChanged)(TSLoginState state);
@property (nonatomic, assign, readonly) TSLoginState state;
-(void)startLogin;
-(void)startLogout;

@end

NS_ASSUME_NONNULL_END
