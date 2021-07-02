//
//  TSSecurityCenterDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSecurityCenterDataController.h"

@interface TSSecurityCenterDataController ()

@property (nonatomic, strong) NSMutableArray <TSSettingSectionModel *> *sections;

@end

@implementation TSSecurityCenterDataController

- (void)fetchSecurityCenterContentsComplete:(void (^)(BOOL))complete {
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSecurCenterAgreementUrl
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
                NSMutableArray *agreementTitles = @[].mutableCopy;
                for (int i = 0; i < data.count; i++) {
                    NSDictionary *dict = data[i];
                    TSAgreementModel *agreementModel = [[TSAgreementModel alloc] init];
                    agreementModel.serverUrl = dict[@"serverUrl"];
                    agreementModel.title = dict[@"title"];
                    [agreementTitles addObject:dict[@"title"]];
                    [_agreementModels addObject:agreementModel];
                }
                self.agreementModels = _agreementModels;
                
                NSMutableArray *sections = [NSMutableArray array];
                {
                    NSMutableArray *items = [NSMutableArray array];
                    
                    NSMutableArray *titles = @[@"账户协议"].mutableCopy;
                    [titles addObjectsFromArray:agreementTitles];
                    for (int i = 0; i < titles.count; i++) {
                        NSString *title = titles[i];
                        TSSettingCommonSectionItemModel *item = [[TSSettingCommonSectionItemModel alloc] init];
                        item.title = title;
                        item.cellHeight = 54;
                        if (i == 0) {
                            item.identify = @"TSSecurityCenterTitleCell";
                        } else {
                            item.identify = @"TSSettingCommonCell";
                            item.showLine = YES;
                            if (i == titles.count - 1) {
                                item.showLine = NO;
                            }
                        }
                        [items addObject:item];
                    }
                    TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
                    section.column = 1;
                    section.items = items;
                    [sections addObject:section];
                }
                self.sections = sections;
                if (complete) {
                    complete(YES);
                }
                
                
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
   
}

@end
