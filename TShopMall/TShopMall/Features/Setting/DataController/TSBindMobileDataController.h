//
//  TSBindMobileDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSBindMobileSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBindMobileDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSBindMobileSectionModel *> *sections;

- (void)fetchBindMobileContentsComplete:(void(^)(BOOL isSucess))complete;

/** 获取更换手机号的数据 */
- (void)fetchChangeMobileContentsComplete:(void (^)(BOOL))complete;
/// 获取验证码
-(void)fetchLoginSMSCodeMobile:(NSString *)mobile
                      complete:(void(^)(BOOL isSucess))complete;
/// 第三方绑定用户信息接口
-(void)fetchBindUserByAuthCode:(NSString *)token
                          type:(NSString *)type
                    platformId:(NSString *)platformId
                         phone:(NSString *)phone
                       smsCode:(NSString *)smsCode
                      complete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
