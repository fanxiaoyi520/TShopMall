//
//  TSAboutMeDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSAboutMeDataController.h"
#import "TSSettingSectionModel.h"

@interface TSAboutMeDataController ()

@property (nonatomic, strong) NSMutableArray <TSAboutMeSectionModel *> *sections;

@end

@implementation TSAboutMeDataController

- (void)fetchContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAboutMeSectionItemModel *item = [[TSAboutMeSectionItemModel alloc] init];
        item.cellHeight = 224;
        item.version = @"版本：1.0.0";
        item.identify = @"TSAboutMeTopCell";
        [items addObject:item];
        TSAboutMeSectionModel *section = [[TSAboutMeSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        NSMutableArray *titles = [NSMutableArray arrayWithArray:@[@"版本信息", @"意见反馈"]];
        @weakify(self);
        [self fetchAgreementWithCompleted:^(NSArray<TSAgreementModel *> *agreementModels) {
            @strongify(self);
            for (int i = 0; i < titles.count; i++) {
                NSString *title = titles[i];
                TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
                item.title = title;
                item.detail = @"";
                item.identify = @"TSSettingCommonCell";
                item.cellHeight = 56.5;
                item.showLine = YES;
                item.updateFlag = NO;
                [items addObject:item];
            }
            for (TSAgreementModel *agreementModel in agreementModels) {
                [titles addObject:agreementModel.title];
                TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
                item.title = agreementModel.title;
                item.detail = @"";
                item.serverURL = agreementModel.serverUrl;
                item.identify = @"TSSettingCommonCell";
                item.cellHeight = 56.5;
                item.showLine = YES;
                item.updateFlag = NO;
                [items addObject:item];
            }
            TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
            item.title = @"版本更新";
            item.detail = @"";
            item.identify = @"TSSettingCommonCell";
            item.cellHeight = 56;
            item.showLine = NO;
            item.updateFlag = YES;
            [items addObject:item];
            TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
            section.column = 1;
            section.items = items;
            [sections addObject:section];
            {
                NSMutableArray *items = [NSMutableArray array];
                TSAboutMeBottomSectionItemModel *item = [[TSAboutMeBottomSectionItemModel alloc] init];
                CGFloat height = kScreenHeight - 56.5 * (titles.count + 1) - GK_STATUSBAR_NAVBAR_HEIGHT - 224;
                if (height < 50) {
                    height = 50;
                }
                item.cellHeight = height;
                item.identify = @"TSAboutMeBottomCell";
                [items addObject:item];
                TSAboutMeSectionModel *section = [[TSAboutMeSectionModel alloc] init];
                section.column = 1;
                section.items = items;
                [sections addObject:section];
            }
            self.sections = sections;
            if (complete) {
                complete(YES);
            }
        }];
    }
}

/** 获取注册登录的协议信息 */
- (void)fetchAgreementWithCompleted: (void(^)(NSArray<TSAgreementModel *> *agreementModels))completed {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kAboutMeAgreementUrl
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

@end
