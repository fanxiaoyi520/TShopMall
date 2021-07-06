//
//  TSRealNameAuthDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSRealNameAuthDataController.h"


@interface TSRealNameAuthDataController ()
/** sections  */
@property(nonatomic, strong) NSMutableArray<TSRealNameAuthSectionModel *> *sections;

@end

@implementation TSRealNameAuthDataController

- (void)fetchRealNameAuthContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSRealNameAuthSectionItemModel *item = [[TSRealNameAuthSectionItemModel alloc] init];
        item.cellHeight = kScreenHeight;
        item.identify = @"TSRealNameAuthCell";
        [items addObject:item];
        TSRealNameAuthSectionModel *section = [[TSRealNameAuthSectionModel alloc] init];
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

- (void)checkRealAuthComplete:(void(^)(BOOL isSucess))complete {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineCheckRealAuth
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:NSDictionary.dictionary
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
           
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            complete(NO);
    }];
}

-(void)realAuthWithName:(NSString *)name AndIdCard:(NSString *)idcard complete:(void(^)(BOOL isSucess))complete {
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:name forKey:@"realName"];
    [body setValue:idcard forKey:@"idCard"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineRealAuth
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
//            NSDictionary *data = request.responseModel.data;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            complete(NO);
    }];
}

@end
