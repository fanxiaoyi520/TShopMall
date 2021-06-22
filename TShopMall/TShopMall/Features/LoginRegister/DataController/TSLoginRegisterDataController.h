//
//  TSLoginRegisterDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import "TSBaseDataController.h"
#import "TSLoginSMSModel.h"

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
@end

NS_ASSUME_NONNULL_END
