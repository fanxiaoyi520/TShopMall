//
//  TSRealnameInfoDataController.m
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSRealnameInfoDataController.h"

@interface TSRealnameInfoDataController ()
/** sections  */
@property(nonatomic, strong) NSMutableArray<TSRealnameInfoSectionModel *> *sections;
@property(nonatomic,copy) NSString *idCard;
@property(nonatomic,copy) NSString *name;
@end



@implementation TSRealnameInfoDataController


- (void)fetchRealnameInfoContentsComplete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSRealnameInfoSectionItemModel *item = [[TSRealnameInfoSectionItemModel alloc] init];
        item.realname = self.name;
        item.idcard = self.idCard;
        item.cellHeight = kScreenHeight;
        item.identify = @"TSRealNameInfoCell";
        [items addObject:item];
        TSRealnameInfoSectionModel *section = [[TSRealnameInfoSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
   
}

- (void)checkRealAuthComplete:(void(^)(BOOL isSucess))complete{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineCheckRealAuth
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:NSDictionary.dictionary
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            self.idCard = [data stringForkey:@"idCard"];
            self.name = [data stringForkey:@"name"];
            [self fetchRealnameInfoContentsComplete];
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            [self fetchRealnameInfoContentsComplete];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self fetchRealnameInfoContentsComplete];
        complete(NO);
    }];
}


@end
