//
//  TSLoginRegisterDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "TSLoginRegisterDataController.h"
#import "TSSMSCodeRequest.h"
#import "TSQuickLoginRequest.h"
#import "TSRegisterRequest.h"

#import "TSUserInfoManager.h"
@implementation TSLoginRegisterDataController

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
    [login startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        TSUserInfoManager *userInfo = [[TSUserInfoManager alloc] init];
        userInfo.accessToken = request.responseModel.originalData[@"accessToken"];
        userInfo.refreshToken = request.responseModel.originalData[@"refreshToken"];
        userInfo.userName = request.responseModel.originalData[@"username"];
        
        TSGlobalManager *manager = [TSGlobalManager shareInstance];
        manager.isLogin = YES;
        manager.currentUserInfo = userInfo;
        [manager saveCurrentUserInfo];
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
     
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
//    [body setValue:@"thome" forKey:@"storeUuid"];
//    [body setValue:@"tcl" forKey:@"t-id"];
    [body setValue:mobile forKey:@"mobile"];
    [body setValue:validCode forKey:@"code"];
    [body setValue:invitationCode forKey:@"invitationCode"];

//    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kRegisterUrl
//                                                               requestMethod:YTKRequestMethodPOST
//                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
//                                                               requestHeader:NSMutableDictionary.dictionary
//                                                                 requestBody:body
//                                                              needErrorToast:YES];
//    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
//
//        if (request.responseModel.isSucceed) {
////            [TSUserInfoManager userInfo].accessToken =
//
//        }
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        complete(NO);
//    }];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithBaseUrl:@"" RequestUrl:kRegisterUrl requestMethod:YTKRequestMethodPOST requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON requestHeader:@{@"storeUuid":@"thome", @"t-id":@"tcl"} requestBody:body needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
       //            [TSUserInfoManager userInfo].accessToken =
       
               }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    
//    TSRegisterRequest *codeRequest = [[TSRegisterRequest alloc] initWithMobile:mobile validCode:validCode invitationCode:invitationCode];
//    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
//        if (request.responseModel.isSucceed) {
//
//        }else{
//
//            if (complete) {
//                complete(NO);
//            }
//        }
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (complete) {
//            complete(NO);
//        }
//    }];
}
@end
