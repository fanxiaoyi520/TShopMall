//
//  TSUserLoginManager.h
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import <Foundation/Foundation.h>
#import "TSAgreementModel.h"

typedef NS_ENUM(NSUInteger, TSLoginState) {
    TSLoginStateLogin,
    TSLoginStateNone
};

NS_ASSUME_NONNULL_BEGIN

@interface TSUserLoginManager : NSObject
+ (instancetype)shareInstance;
@property (nonatomic, assign, readonly) TSLoginState state;
@property (nonatomic, copy) void(^ _Nonnull loginBlock)(void);
@property (nonatomic, copy) void(^ _Nonnull logoutBlock)(void);

-(void)startLogin;
-(void)logout;
-(void)configLoginController:(void(^)(UIViewController *))callBack;

/** 获取注册登录的协议信息 */
- (void)fetchAgreementWithCompleted: (void(^)(NSArray<TSAgreementModel *> *agreementModels))completed;

@end

NS_ASSUME_NONNULL_END
