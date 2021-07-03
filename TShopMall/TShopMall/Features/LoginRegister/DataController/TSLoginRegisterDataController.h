//
//  TSLoginRegisterDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "TSBaseDataController.h"
#import "TSLoginSMSModel.h"
#import "TSAgreementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSLoginRegisterDataController : TSBaseDataController

@property(nonatomic, strong) TSLoginSMSModel *smsModel;
/// 验证码
-(void)fetchLoginSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete;///登录

-(void)fetchRegisterSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete;///注册

-(void)fetchBindSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete;///绑定

-(void)fetchChangeMobileSMSCodeMobile:(NSString *)mobile
                             complete:(void(^)(BOOL isSucess))complete;///换绑

/// 注册
-(void)fetchRegisterMobile:(NSString *)mobile
                     validCode:(NSString *)validCode
                invitationCode:(NSString *)invitationCode
                  complete:(void(^)(BOOL isSucess))complete;
/// 一键登录
-(void)fetchOneStepLoginToken:(NSString *)token
                     accessToken:(NSString *)accessToken
                        complete:(void(^)(BOOL isSucess))complete;
/// 普通登录
-(void)fetchQuickLoginUsername:(NSString *)username
                     validCode:(NSString *)validCode
                      complete:(void(^)(BOOL isSucess))complete;

/// 第三方登录
-(void)fetchLoginByAuthCode:(NSString *)code
                    platformId:(NSString *)platformId
                     sucess:(void(^)(BOOL isHaveMobile, NSString * __nullable token))complete;


- (void)fetchLoginByToken:(NSString *)token
                    platformId:(NSString *)platformId
                   sucess:(void(^)(BOOL isHaveMobile, NSString * __nullable token))complete;

/// 第三方绑定用户信息接口
-(void)fetchBindUserByAuthCode:(NSString *)token
                          type:(NSString *)type
                    platformId:(NSString *)platformId
                         phone:(NSString * __nullable)phone
                       smsCode:(NSString * __nullable)smsCode
                      complete:(void(^)(BOOL isSucess))complete;
/// 更换手机号
-(void)fetchChangeBindWithNewMobile:(NSString *)newMobile
                          validCode:(NSString *)validCode
                            success:(void(^_Nullable)(void))success
                            failure:(void(^_Nullable)(NSString *errorMsg))failure;
/// 账号注销
- (void)fetchAccountCancelBackCallBack:(void(^)(BOOL isSucess))complete;

- (void)fetchAccountCancelCallBack:(void(^_Nullable)(NSString *date, NSString *nickname))success
                              failure:(void(^_Nullable)(NSString *errorMsg))failure;

- (void)fetchAccountCancelInfoCallBack:(void(^_Nullable)(NSString *date, NSString *nickname))success
                                  failure:(void(^_Nullable)(NSString *errorMsg))failure;
/// 是否为分销员
-(void)fetchCheckSalesmanWithMobile:(NSString *)mobile
                             complete:(void(^)(BOOL isSucess))complete;

-(void)fetchCheckSalesmanWithToken:(NSString *)token
                             complete:(void(^)(BOOL isSucess))complete;

/** 获取注册登录的协议信息 */
- (void)fetchAgreementWithCompleted: (void(^)(NSArray<TSAgreementModel *> *agreementModels))completed;
@end

NS_ASSUME_NONNULL_END
