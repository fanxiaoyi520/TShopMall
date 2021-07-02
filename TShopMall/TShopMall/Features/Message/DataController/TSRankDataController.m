//
//  TSRankDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankDataController.h"
#import "TSSaleRankRequest.h"
#import "TSProfitRankRequest.h"

@interface TSRankDataController()

@property (nonatomic, strong) NSMutableArray <TSRankSectionModel *> *coronalSections;

@end

@implementation TSRankDataController

- (void)fetchRankDataWithRankNum:(NSInteger)rankNum Complete:(void(^)(BOOL isSucess))complete {
    NSInteger time = self.isNowMonth ? 1 : 2;
    @weakify(self);
    
    if (self.isProfitRank) {
        NSLog(@"财富榜 - %ld", time);
        
        TSProfitRankRequest *webRequest = [[TSProfitRankRequest alloc] initWithTime:time rankNum:rankNum];
        [webRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
            @strongify(self);
            
            if (request.responseModel.isSucceed) {
                
                [self analyseRankData:request];
                
                if (complete) {
                    complete(YES);
                }
            }else{
                [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
                
                if (complete) {
                    complete(NO);
                }
            }

        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            if (complete) {
                complete(NO);
            }
        }];
        
    }else {
        NSLog(@"冲冠榜 - %ld", time);
        
        TSSaleRankRequest *webRequest = [[TSSaleRankRequest alloc] initWithTime:time rankNum:rankNum];
        [webRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
            @strongify(self);
            
            if (request.responseModel.isSucceed) {
                
                [self analyseRankData:request];
                
                if (complete) {
                    complete(YES);
                }
            }else{
                [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
                
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
}

/// 解析数据
- (void)analyseRankData:(SSBaseRequest *)request {
    if (request.responseModel.isSucceed) {
        
        //当前用户数据
        NSDictionary *currentUserRank = [NSDictionary dictionaryWithDictionary:request.responseModel.data[@"currentUserRank"]];
        self.currentUserRankModel = [TSRankUserModel yy_modelWithDictionary:currentUserRank];
        
        //排行数据
        NSArray *userRankList = [NSArray arrayWithArray:request.responseModel.data[@"userRankList"]];
        
        // 列表数据
        NSMutableArray *sections = [NSMutableArray array];
        // 前三名列表
        NSMutableArray<TSRankUserModel *> *topRankList = [NSMutableArray new];
        // 排行榜列表
        NSMutableArray<TSRankSectionItemModel *> *rankList = [NSMutableArray new];
        
        for (NSInteger i = 0; i < userRankList.count; i++) {
            TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
            item.cellHeight = 55;
            item.identify = @"TSRankCell";
            item.isLast = i == (userRankList.count - 1);
            NSDictionary *userRankDict = userRankList[i];
            item.userModel = [TSRankUserModel yy_modelWithDictionary:userRankDict];
            [rankList addObject:item];
            
            // 保存前三名
            if (topRankList.count < 3) {
                [topRankList addObject:item.userModel];
            }
        }
        
        // 前三名 topSection
        NSMutableArray *topItems = [NSMutableArray array];
        TSRankSectionItemModel *topItem = [[TSRankSectionItemModel alloc] init];
        topItem.cellHeight = 280;
        topItem.identify = @"TSRankHonourCell";
        topItem.rankList = topRankList.copy;
        [topItems addObject:topItem];
        
        TSRankSectionModel *topSection = [[TSRankSectionModel alloc] init];
        topSection.column = 1;
        topSection.items = topItems;
        [sections addObject:topSection];
        
        // 排行榜 listSection
        if (rankList.count > 0) {
            TSRankSectionModel *listSection = [[TSRankSectionModel alloc] init];
            listSection.hasHeader = YES;
            listSection.headerSize = CGSizeMake(0, 44);
            listSection.headerIdentify = @"TSRankHeaderView";
            listSection.column = 1;
            listSection.items = rankList;
            [sections addObject:listSection];
        }
        
        //尾部 热销推荐
        {
            NSMutableArray *items = [NSMutableArray array];

            TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
            item.identify = @"TSRankRecommendCell";
            [items addObject:item];

            TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
            section.hasHeader = NO;
            section.items = items;
            
            [sections addObject:section];
        }
        
        self.coronalSections = sections;
    }
}

@end
