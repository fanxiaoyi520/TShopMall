//
//  TSBindMobileDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBindMobileDataController.h"
#import "TSSMSCodeRequest.h"
#import "TSBindUserByAuthCodeRequest.h"
@interface TSBindMobileDataController ()

@property (nonatomic, strong) NSMutableArray <TSBindMobileSectionModel *> *sections;

@end

@implementation TSBindMobileDataController

- (void)fetchBindMobileContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSBindMobileSectionItemModel *item = [[TSBindMobileSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.identify = @"TSBindMobileCell";
        [items addObject:item];
        TSBindMobileSectionModel *section = [[TSBindMobileSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}
/** 获取更换手机号的数据 */
- (void)fetchChangeMobileContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSBindMobileSectionItemModel *item = [[TSBindMobileSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.oldMobile = @"18175753790";///获取旧手机号
        item.identify = @"TSChangeMobileCell";
        [items addObject:item];
        TSBindMobileSectionModel *section = [[TSBindMobileSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

-(void)fetchLoginSMSCodeMobile:(NSString *)mobile
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

-(void)fetchBindUserByAuthCode:(NSString *)token
                          type:(NSString *)type
                    platformId:(NSString *)platformId
                         phone:(NSString *)phone
                       smsCode:(NSString *)smsCode
                      complete:(void(^)(BOOL isSucess))complete{
    TSBindUserByAuthCodeRequest *codeRequest = [[TSBindUserByAuthCodeRequest alloc] initWithType:type platformId:platformId phone:phone token:token smsCode:smsCode];
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

@end
