//
//  TSLoginRegisterDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "TSLoginRegisterDataController.h"
#import "TSSMSCodeRequest.h"
#import "TSQuickLoginRequest.h"
#import "TSOneStepLoginRequest.h"
#import "TSUserInfoManager.h"
#import "TSLoginByAuthCodeRequest.h"
#import "TSLoginByTokenRequest.h"
#import "TSChangeBindRequest.h"

@implementation TSLoginRegisterDataController
-(void)fetchChangeBindWithNewMobile:(NSString *)newMobile
                          validCode:(NSString *)validCode
                           success:(void (^ _Nullable)(void))success failure:(void (^ _Nullable)(NSString * _Nonnull))failure{
    TSChangeBindRequest *login = [[TSChangeBindRequest alloc] initWithNewMobile:newMobile validCode:validCode];
    login.animatingView = self.context.view;
    [login startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
       if (request.responseModel.isSucceed) {
           [[TSUserInfoManager userInfo] updateUserInfo:^(BOOL success) {
                
           }];

           success();
       }
       else{
           failure(request.responseModel.originalData[@"msg"]);         
       }
   } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

   }];
}

-(void)fetchChangeMobileSMSCodeMobile:(NSString *)mobile
                             complete:(void(^)(BOOL isSucess))complete{
    TSSMSCodeRequest *codeRequest = [[TSSMSCodeRequest alloc] initWithMobile:mobile type:@"CHANGE_BIND"];
    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            self.smsModel = [[TSLoginSMSModel alloc] init];
            self.smsModel.key = request.responseModel.data[@"key"];
            self.smsModel.text = request.responseModel.data[@"text"];
            self.smsModel.expirationTime = request.responseModel.data[@"expirationTime"];
            
            if (complete) {
                complete(YES);
            }
        }else{
            self.smsModel = [[TSLoginSMSModel alloc] init];
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"failCause"]];

            if (complete) {
                complete(NO);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

-(void)fetchLoginSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete{
    TSSMSCodeRequest *codeRequest = [[TSSMSCodeRequest alloc] initWithMobile:mobile type:@"LOGIN"];
    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            self.smsModel = [[TSLoginSMSModel alloc] init];
            self.smsModel.key = request.responseModel.data[@"key"];
            self.smsModel.text = request.responseModel.data[@"text"];
            self.smsModel.expirationTime = request.responseModel.data[@"expirationTime"];
            
            if (complete) {
                complete(YES);
            }
        }else{
            self.smsModel = [[TSLoginSMSModel alloc] init];
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"failCause"]];

            if (complete) {
                complete(NO);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

-(void)fetchQuickLoginUsername:(NSString *)username
                     validCode:(NSString *)validCode
                      complete:(void(^)(BOOL isSucess))complete{
    TSQuickLoginRequest *login = [[TSQuickLoginRequest alloc] initWithUsername:username
                                                                     validCode:validCode];
    login.animatingView = self.context.view;
    [login startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            TSUserInfoManager *userInfo = [[TSUserInfoManager alloc] init];
            userInfo.accessToken = request.responseModel.originalData[@"accessToken"];
            userInfo.refreshToken = request.responseModel.originalData[@"refreshToken"];
            userInfo.userName = request.responseModel.originalData[@"username"];
            userInfo.accountId = request.responseModel.originalData[@"accountId"];
            [[TSUserInfoManager userInfo] saveUserInfo:userInfo];
            ///登录成功后获取用户信息
            [[TSUserInfoManager userInfo] updateUserInfo:complete];
            //complete(YES);
        }
        else{
            complete(NO);
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);


    }];
    
}

-(void)fetchRegisterSMSCodeMobile:(NSString *)mobile
                         complete:(void(^)(BOOL isSucess))complete{
    TSSMSCodeRequest *codeRequest = [[TSSMSCodeRequest alloc] initWithMobile:mobile type:@"REGISTER"];
    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            self.smsModel = [[TSLoginSMSModel alloc] init];
            self.smsModel.key = request.responseModel.data[@"key"];
            self.smsModel.text = request.responseModel.data[@"text"];
            self.smsModel.expirationTime = request.responseModel.data[@"expirationTime"];
            
            if (complete) {
                complete(YES);
            }
        }else{
            self.smsModel = [[TSLoginSMSModel alloc] init];
            if (complete) {
                complete(NO);
            }
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"msg"]];

        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

-(void)fetchRegisterMobile:(NSString *)mobile
                 validCode:(NSString *)validCode
            invitationCode:(NSString *)invitationCode
                  complete:(nonnull void (^)(BOOL))complete{
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:mobile forKey:@"mobile"];
    [body setValue:validCode forKey:@"code"];
    [body setValue:invitationCode forKey:@"invitationCode"];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kRegisterUrl requestMethod:YTKRequestMethodPOST requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{@"storeUuid":@"thome", @"t-id":@"tcl"} requestBody:body needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            if (request.responseModel.data) {
                NSDictionary *dic = request.responseModel.data;
                TSUserInfoManager *userInfo = [[TSUserInfoManager alloc] init];
                userInfo.accessToken = dic[@"accessToken"];
                userInfo.refreshToken = dic[@"refreshToken"];
                userInfo.userName = dic[@"username"];
                userInfo.accountId = dic[@"accountId"];
                [[TSUserInfoManager userInfo] saveUserInfo:userInfo];
                //complete(YES);
                [[TSUserInfoManager userInfo] updateUserInfo:complete];
            }
            
        }else
        {
            complete(NO);
            
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"message"]];
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

-(void)fetchOneStepLoginToken:(NSString *)token
                     accessToken:(NSString *)accessToken
                        complete:(void(^)(BOOL isSucess))complete{
    TSOneStepLoginRequest *request = [[TSOneStepLoginRequest alloc] initWithToken:token accessToken:accessToken];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            TSUserInfoManager *userInfo = [[TSUserInfoManager alloc] init];
            userInfo.accessToken = request.responseModel.originalData[@"accessToken"];
            userInfo.refreshToken = request.responseModel.originalData[@"refreshToken"];
            userInfo.userName = request.responseModel.originalData[@"username"];
            userInfo.accountId = request.responseModel.originalData[@"accountId"];
            [[TSUserInfoManager userInfo] saveUserInfo:userInfo];
            [[TSUserInfoManager userInfo] updateUserInfo:complete];
            [Popover removePopoverOnWindow];
            //complete(YES);
        }
        else{
            complete(NO);
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
    
}

-(void)fetchLoginByAuthCode:(NSString *)code
                    platformId:(NSString *)platformId
                     sucess:(void(^)(BOOL isHaveMobile, NSString *token))complete{
    TSLoginByAuthCodeRequest *request = [[TSLoginByAuthCodeRequest alloc] initWithCode:code platformId:platformId];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *dic = request.responseModel.data;
            if ([dic[@"flag"] intValue] == 1) {
                complete(NO, dic[@"token"]);
            }else if([dic[@"flag"] intValue] == 3){
                complete(YES, dic[@"token"]);
            }
        }
        else{
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    
    }];
}

- (void)fetchLoginByToken:(NSString *)token
                    platformId:(NSString *)platformId
                     sucess:(void(^)(BOOL isHaveMobile, NSString *token))complete{

    TSLoginByTokenRequest *request = [[TSLoginByTokenRequest alloc] initWithToken:token platformId:platformId];

    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            if (request.responseModel.data) {
                NSDictionary *dic = request.responseModel.data;
                if ([dic[@"flag"] intValue] == 1) {
                    complete(NO, dic[@"token"]);
                }else if([dic[@"flag"] intValue] == 3){
                    complete(YES, dic[@"token"]);
                }
                
            }
            
        }else
        {
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"message"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/** 获取注册登录的协议信息 */
- (void)fetchAgreementWithCompleted: (void(^)(NSArray<TSAgreementModel *> *agreementModels))completed {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kLoginRegisterAgreementUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:@{}
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseObject[@"data"];
            if (data != nil && data.count) {
                NSMutableArray *_agreementModels = [NSMutableArray array];
                for (int i = 0; i < data.count; i++) {
                    NSDictionary *dict = data[i];
                    TSAgreementModel *agreementModel = [[TSAgreementModel alloc] init];
                    agreementModel.serverUrl = dict[@"serverUrl"];
                    agreementModel.title = dict[@"title"];
                    [_agreementModels addObject:agreementModel];
                }
                if (completed) {
                    completed([_agreementModels copy]);
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)fetchAccountCancelBackCallBack:(void(^)(BOOL isSucess))complete{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&accountId=%@",kLoginByTokenUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].accountId];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:requestUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:@{} needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            
            
        }else
        {
            
                        
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)fetchAccountCancelCallBack:(void (^ _Nullable)(NSString * _Nonnull, NSString * _Nonnull))success failure:(void (^ _Nullable)(NSString * _Nonnull))failure{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&accountId=%@&username=%@",kAccountCancelUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].accountId, [TSUserInfoManager userInfo].userName];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:requestUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:@{} needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            success(request.responseModel.originalData[@"data"], request.responseModel.originalData[@"nickname"]);
        }else{
            failure(request.responseModel.originalData[@"msg"]);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
       
    }];
}

- (void)fetchAccountCancelInfoCallBack:(void(^_Nullable)(NSString *date, NSString *nickname))success
                                  failure:(void(^_Nullable)(NSString *errorMsg))failure{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&accountId=%@",kAccountCancelInfoUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].accountId];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:requestUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:@{} needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            success(request.responseModel.originalData[@"data"], request.responseModel.originalData[@"nickname"]);
            
        }else{
            failure(request.responseModel.originalData[@"msg"]);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
       
    }];
}
@end
