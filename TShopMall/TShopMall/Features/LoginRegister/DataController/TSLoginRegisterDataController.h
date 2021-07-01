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

-(void)fetchLoginSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete;

-(void)fetchQuickLoginUsername:(NSString *)username
                     validCode:(NSString *)validCode
                      complete:(void(^)(BOOL isSucess))complete;

-(void)fetchRegisterSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete;

-(void)fetchRegisterMobile:(NSString *)mobile
                     validCode:(NSString *)validCode
                invitationCode:(NSString *)invitationCode
                  complete:(void(^)(BOOL isSucess))complete;

-(void)fetchOneStepLoginToken:(NSString *)token
                     accessToken:(NSString *)accessToken
                        complete:(void(^)(BOOL isSucess))complete;

-(void)fetchLoginByAuthCode:(NSString *)code
                    platformId:(NSString *)platformId
                     sucess:(void(^)(BOOL isHaveMobile, NSString *token))complete;

- (void)fetchLoginByToken:(NSString *)token
                    platformId:(NSString *)platformId
                   sucess:(void(^)(BOOL isHaveMobile, NSString *token))complete;

-(void)fetchChangeMobileSMSCodeMobile:(NSString *)mobile
                             complete:(void(^)(BOOL isSucess))complete;

-(void)fetchChangeBindWithNewMobile:(NSString *)newMobile
                          validCode:(NSString *)validCode
                            success:(void(^_Nullable)(void))success
                            failure:(void(^_Nullable)(NSString *errorMsg))failure;

- (void)fetchAccountCancelBackCallBack:(void(^)(BOOL isSucess))complete;

- (void)fetchAccountCancelCallBack:(void(^_Nullable)(NSString *date, NSString *nickname))success
                              failure:(void(^_Nullable)(NSString *errorMsg))failure;

- (void)fetchAccountCancelInfoCallBack:(void(^_Nullable)(NSString *date, NSString *nickname))success
                                  failure:(void(^_Nullable)(NSString *errorMsg))failure;
/** 获取注册登录的协议信息 */
- (void)fetchAgreementWithCompleted: (void(^)(NSArray<TSAgreementModel *> *agreementModels))completed;
@end

NS_ASSUME_NONNULL_END
