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
#import "TSBindUserByAuthCodeRequest.h"
#import "TSLogoutRequest.h"

@implementation TSLoginRegisterDataController

-(void)fetchAccountPublicKeyComplete:(void(^)(BOOL isSucess))complete{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kAccountCenterApiPrefix,kAccountPublicKeyUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *firsttask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil){
            id objc = [data utf8String];
            NSLog(@"%@",objc);
            dispatch_async(dispatch_get_main_queue(), ^{
                [TSGlobalManager shareInstance].publicKey = objc;
               if (complete) {
                   complete(YES);
               }
            });
        }else{
           
        }

    }];
    [firsttask resume];
//    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:kAccountPublicKeyUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:@{} needErrorToast:YES];
//    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
//
//        if (request.responseString) {
//            [TSGlobalManager shareInstance].publicKey = request.responseString;
//            if (complete) {
//                complete(YES);
//            }
//        }
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (complete) {
//            complete(NO);
//        }
//    }];
}

- (void)fetchLogoutComplete:(void (^)(BOOL))complete{
    TSLogoutRequest *request = [TSLogoutRequest new];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        [[TSUserInfoManager userInfo] clearUserInfo];
        complete(YES);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)fetchRefershTokenComplete:(void(^)(BOOL isSucess))complete{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&userName=%@",kAccountRefershTokenUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].userName];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:requestUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{@"refreshToken":[TSUserInfoManager userInfo].refreshToken} requestBody:@{} needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            TSUserInfoManager *userInfo = [TSUserInfoManager userInfo];
            userInfo.accessToken = request.responseModel.originalData[@"accessToken"];
            userInfo.refreshToken = request.responseModel.originalData[@"refreshToken"];
            [[TSUserInfoManager userInfo] saveUserInfo:userInfo];
            if (complete) {
                complete(YES);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}
-(void)fetchBindUserByAuthCode:(NSString *)token
                          type:(NSString *)type
                    platformId:(NSString *)platformId
                         phone:(NSString * __nullable)phone
                       smsCode:(NSString * __nullable)smsCode
                      complete:(void(^)(BOOL isSucess))complete{
    TSBindUserByAuthCodeRequest *codeRequest = [[TSBindUserByAuthCodeRequest alloc] initWithType:type platformId:platformId phone:phone token:token smsCode:smsCode];
    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            
            [self saveUserInfoWithOriginalData:request.responseModel.originalData];
            [[TSUserInfoManager userInfo] updateUserInfo:complete];
            
            if (complete) {
                complete(YES);
            }
        }else{
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

-(void)fetchBindSMSCodeMobile:(NSString *)mobile
                     complete:(void(^)(BOOL isSucess))complete{
    TSSMSCodeRequest *codeRequest = [[TSSMSCodeRequest alloc] initWithMobile:mobile type:@"BINDING"];
    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            if (complete) {
                complete(YES);
            }
        }else{
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

-(void)fetchCheckSalesmanWithMobile:(NSString *)mobile
                           complete:(void(^)(BOOL isSucess))complete{
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:mobile forKey:@"mobile"];
    [body setValue:@"thome" forKey:@"storeUuid"];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kAccountCheckSalesmanWithMobileUrl requestMethod:YTKRequestMethodPOST requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:body needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            complete(YES);
            
        }else
        {
            complete(NO);
            
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"message"]];
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
        [Popover removePopoverOnWindow];
    }];
}

-(void)fetchCheckSalesmanWithToken:(NSString *)token
                          complete:(void(^)(BOOL isSucess))complete{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kAccountCheckSalesmanWithTokenUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:@{}
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            complete(YES);
        }
        else{
//            -1：账号不存在
//            0：分销员待审核状态
//            1：分销员审核通过
//            2：分销员审核失败
//            3：分销员已冻结
            complete(NO);
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"message"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)fetchChangeBindWithNewMobile:(NSString *)newMobile
                          validCode:(NSString *)validCode
                           success:(void (^ _Nullable)(void))success failure:(void (^ _Nullable)(NSString * _Nonnull))failure{
    TSChangeBindRequest *login = [[TSChangeBindRequest alloc] initWithNewMobile:newMobile validCode:validCode];
    login.animatingView = self.context.view;
    [login startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
       if (request.responseModel.isSucceed) {
           [[TSUserInfoManager userInfo] updateUserInfo:nil];
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
            [Popover popToastOnWindowWithText:@"无网络连接"];
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
            [self saveUserInfoWithOriginalData:request.responseModel.originalData];
            [[TSUserInfoManager userInfo] updateUserInfo:complete];
//            complete(YES);
        }
        else{
            complete(NO);
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
        [Popover popToastOnWindowWithText:@"无网络连接"];

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
            [self saveUserInfoWithOriginalData:request.responseModel.originalData];
            [[TSUserInfoManager userInfo] updateUserInfo:complete];
            
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
    @weakify(self);
    TSOneStepLoginRequest *request = [[TSOneStepLoginRequest alloc] initWithToken:token accessToken:accessToken];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            TSUserInfoManager *userInfo = [TSUserInfoManager userInfo];
            userInfo.accessToken = request.responseModel.originalData[@"accessToken"];
            [[TSUserInfoManager userInfo] saveUserInfo:userInfo];
            @strongify(self)
            [self fetchCheckSalesmanWithToken:request.responseModel.originalData[@"accessToken"] complete:^(BOOL isSucess) {
                if (isSucess) {
                    [self saveUserInfoWithOriginalData:request.responseModel.originalData];
                    [[TSUserInfoManager userInfo] updateUserInfo:complete];
                }
            }];
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
//    @weakify(self);
    TSLoginByAuthCodeRequest *request = [[TSLoginByAuthCodeRequest alloc] initWithCode:code platformId:platformId];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
//        @strongify(self)
        if (request.responseModel.isSucceed) {
            NSDictionary *dic = request.responseModel.data;
            if ([dic[@"flag"] intValue] == 1) {
                complete(NO, dic[@"token"]);
            }else if([dic[@"flag"] intValue] == 3){
                
                [self saveUserInfoWithOriginalData:request.responseModel.originalData];
                [[TSUserInfoManager userInfo] updateUserInfo:nil];
                complete(YES, nil);

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
                    [self saveUserInfoWithOriginalData:request.responseModel.originalData];
                    [[TSUserInfoManager userInfo] updateUserInfo:Nil];
                    complete(YES, nil);
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&accountId=%@",kAccountCancelBackUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].accountId];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:requestUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:@{} needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (complete) {
            complete(request.responseModel.isSucceed);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

- (void)fetchAccountCancelCallBack:(void (^ _Nullable)(NSString * _Nonnull, NSString * _Nonnull))success failure:(void (^ _Nullable)(NSString * _Nonnull))failure{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?appId=%@&tenantId=%@&appSecret=%@&accountId=%@&username=%@",kAccountCancelUrl,kAppId,@"tcl",kAppSecret, [TSUserInfoManager userInfo].accountId, [TSUserInfoManager userInfo].userName];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:kAccountCenterApiPrefix RequestUrl:requestUrl requestMethod:YTKRequestMethodGET requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{} requestBody:@{} needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSString *date;
            if (request.responseModel.originalData[@"data"]) {
                date = request.responseModel.originalData[@"data"];
            }
            success(date, request.responseModel.originalData[@"nickname"]);
        }else{
            failure(request.responseModel.originalData[@"msg"]);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(@"服务器发生未知错误~~~");
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

- (void)saveUserInfoWithOriginalData:(NSDictionary *)dic{
    TSUserInfoManager *userInfo = [TSUserInfoManager userInfo];
    userInfo.accessToken = dic[@"accessToken"];
    userInfo.refreshToken = dic[@"refreshToken"];
    userInfo.userName = dic[@"username"];
    userInfo.accountId = dic[@"accountId"];
    [[TSUserInfoManager userInfo] saveUserInfo:userInfo];
    [Popover removePopoverOnWindow];
}
@end
