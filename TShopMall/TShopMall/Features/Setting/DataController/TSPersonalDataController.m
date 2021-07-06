//
//  TSPersonalDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSPersonalDataController.h"


@interface TSPersonalDataController ()

@property (nonatomic, strong) NSMutableArray <TSPersonalSectionModel *> *sections;

@end

@implementation TSPersonalDataController

- (void)fetchPersonalContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *titles = @[@"头像", @"姓名", @"身份证", @"性别", @"出生年月"];
        TSUser *user = [TSUserInfoManager userInfo].user;
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSPersonalSectionItemModel *item = [[TSPersonalSectionItemModel alloc] init];
            item.title = title;
            item.cellHeight = 57;
            item.identify = @"TSPersonalCommonCell";
            if (i == 0) {///头像
                NSString *avatar = user.avatar;
                item.head = avatar.length == 0 ? @"default" : avatar;
                item.sex = none;
                item.detail = nil;
            } else if(i == 1) {///姓名
                item.detail = user.nickname;
                item.head = nil;
                item.sex = none;
            } else if(i == 2) {///身份证
                item.detail = user.identity;
                item.sex = none;
                item.head = nil;
            } else if(i == 3) {///性别
                item.sex = user.sex.length == 0 ? unknow : [user.sex intValue];
                item.head = nil;
                item.detail = nil;
            } else if(i == 4) {///出生年月
                item.detail = user.birthday;
                item.head = nil;
                item.sex = none;
                item.cellHeight = 57.33;
            }
            [items addObject:item];
        }
        TSPersonalSectionModel *section = [[TSPersonalSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

- (void)checkRealAuthComplete:(void(^)( NSDictionary * _Nullable info))complete{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineCheckRealAuth
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:NSDictionary.dictionary
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            
            complete(data);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(nil);
    }];
}



@end
