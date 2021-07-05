//
//  TSPhoneNumDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSPhoneNumDataController.h"
#import "TSSMSCodeRequest.h"
#import "TSLoginSMSModel.h"

@interface TSPhoneNumDataController ()

@property (nonatomic, strong) NSMutableArray <TSPhoneNumSectionModel *> *sections;

@end

@implementation TSPhoneNumDataController

- (void)fetchPhoneNumContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSPhoneNumSectionItemModel *item = [[TSPhoneNumSectionItemModel alloc] init];
        item.phoneNum = [TSUserInfoManager userInfo].user.phone;//@"133-7869-2380";
        item.cellHeight = kScreenHeight;
        item.identify = @"TSPhoneNumVeriCell";
        [items addObject:item];
        TSPhoneNumSectionModel *section = [[TSPhoneNumSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}
/** 修改提现密码模块的手机发送验证码 */
-(void)fetchCheckMobileSMSCodeMobile:(NSString *)mobile
                             complete:(void(^)(BOOL isSucess))complete {
    TSSMSCodeRequest *codeRequest = [[TSSMSCodeRequest alloc] initWithMobile:mobile type:@"ALTER_PASSWORD"];
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

@end
