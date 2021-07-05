//
//  TSPhoneNumDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSPhoneNumSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPhoneNumDataController : TSBaseDataController

@property(nonatomic, strong) TSLoginSMSModel *smsModel;

@property (nonatomic, strong, readonly) NSMutableArray <TSPhoneNumSectionModel *> *sections;

- (void)fetchPhoneNumContentsComplete:(void(^)(BOOL isSucess))complete;

/** 修改提现密码模块的手机发送验证码 */
- (void)fetchCheckMobileSMSCodeMobile:(NSString *)mobile
                            complete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
